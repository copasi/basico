"""This module hosts all method for loading/saving new models.

All methods for loading / saving a new model are within this module. As well as
the functionality to get/set the currently loaded model. Whenever a function needs
the currently loaded model, and no model was provided in the `kwargs`, the
:func:`.get_current_model()` function retrieves the model loaded last. There are also convenience
methods to load models directly from BioModels or from url.

"""
import COPASI
import os
import zipfile

import basico.model_info
from basico.callbacks import get_default_handler

try:
    import urllib2
    _use_urllib2 = True
except ImportError:
    import urllib
    import urllib.request
    _use_urllib2 = False

import traceback
import logging
import glob
import atexit
import subprocess
import tempfile
import shutil
import platform

logger = logging.getLogger(__name__)
__current_model = None
__model_list = []
__temp_files = []
__temp_dirs = []


def set_current_model(model):
    """Sets the current model.

    The current model, is the one that all functions will use if not is provided explicitly.

    :param model: the model to be set as current
    :type model: COPASI.CDataModel
    :return: the model
    :rtype: COPASI.CDataModel
    """
    global __current_model
    global __model_list
    __current_model = model
    if model not in __model_list:
        __model_list.append(model)

    if __current_model is not None:
        __current_model.getModel().applyInitialValues()
        logger.debug(overview(__current_model))
    return __current_model


def get_current_model():
    """Returns the current model.

    This function returns the current model. That is the model loaded / created last. If no model exists
    a new one will be created first.

    :return: the current model
    :rtype: COPASI.CDataModel
    """
    global __current_model
    if __current_model is None:
        logger.warning('There is no model, creating a new one')
        new_model()
    return __current_model


def get_model_from_dict_or_default(d, key='model'):
    """Convenience function returning the data model from the dictionary

    :param d: the dictionary optionally containing the data model
    :param key: the key that the model is under (defaults to 'model')
    :return: the data model if found, or the one from  :func:`.get_current_model`
    :rtype: COPASI.CDataModel
    """
    model = None
    if key in d:
        model = d[key]

    if model is None:
        model = get_current_model()

    return model


def create_datamodel():
    """creates a new data model

    :return: new data model
    :rtype: COPASI.CDataModel
    """
    try:
        data_model = COPASI.CRootContainer.addDatamodel()
    except NameError:
        traceback.print_exc()
        data_model = COPASI.CCopasiRootContainer.addDatamodel()
    return data_model


def remove_datamodel(model):
    """Removes the model from the internal list of loaded models.

    The model is removed from the list of models, and current model,
    before it is freed

    :param model: the model to be removed

    :type model:COPASI.CDataModel
    :return: None
    """
    global __model_list
    global __current_model
    if model in __model_list:
        __model_list.remove(model)
    if __current_model is model:
        __current_model = None
    COPASI.CRootContainer.removeDatamodel(model)
    return None


def get_num_loaded_models():
    """
    :return: the number of loaded models
    """
    return COPASI.CRootContainer.getDatamodelList().size()

def remove_loaded_models():
    """Removes all loaded models

    :return: None
    """

    while COPASI.CRootContainer.getDatamodelList().size() > 0:
        model = COPASI.CRootContainer.getDatamodelList().get(0)
        COPASI.CRootContainer.removeDatamodel(model)

    global __current_model
    global __model_list
    __model_list = []
    __current_model = None

def new_model(**kwargs):
    """Creates a new model and sets it as current.

    :param kwargs: optional arguments

    - `name` (str): the name for the new model

    - `quantity_unit` (str): the unit to use for species

    - `time_unit` (str): the time unit to use

    - `volume_unit` (str): the unit to use for 3D compartments

    - `area_unit` (str): the unit to use for 2D compartments

    - `length_unit` (str): the unit to use for 1D compartments

    - `remove_user_defined_functions` (bool): whether to remove user defined functions when creating the model

    - | `notes`: sets notes for the model (either plain text, or valid xhtml)

    :return: the new model
    :rtype: COPASI.CDataModel
    """
    if 'remove_user_defined_functions' in kwargs and kwargs['remove_user_defined_functions']:
        basico.model_info.remove_user_defined_functions()

    dm = create_datamodel()
    dm.newModel()

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'name' in kwargs:
        model.setObjectName(kwargs['name'])

    basico.model_info.set_model_unit(model=dm, **kwargs)

    if 'notes' in kwargs:
        model.setNotes(kwargs['notes'])

    return set_current_model(dm)

def _is_archive(buffer):
    result = False

    if buffer is None:
        return result

    length = len(buffer)
    if length > 3:
        result = result or (buffer[0] == ord('P') and buffer[1] == ord('K') and buffer[2] == ord('\x03') and buffer[3] == ord('\x04'))
        result = result or (buffer[0] == ord('P') and buffer[1] == ord('K') and buffer[2] == ord('\x05') and buffer[3] == ord('\x06'))
        result = result or (buffer[0] == ord('P') and buffer[1] == ord('K') and buffer[2] == ord('\x07') and buffer[3] == ord('\x08'))
    return result


def load_model_from_string(content):
    """Loads either COPASI model / SBML model from the raw string given.

    :param content: the copasi / sbml model serialized as string
    :type content: str or bytes

    :return: the loaded model
    :rtype: COPASI.CDataModel
    """
    model = create_datamodel()

    if _is_archive(content):
        global __temp_dirs, __temp_files
        temp_name = tempfile.mkdtemp()
        __temp_dirs.append(temp_name)

        name = os.path.join(temp_name, 'model.omex')
        __temp_files.append(name)
        with open(name, 'wb') as temp_file:
            temp_file.write(content)
        if model.openCombineArchive(name):
            return set_current_model(model)

    if type(content) is bytes:
        content = content.decode("utf8")

    if '<COPASI ' in content and model.loadModelFromString(content, os.getcwd()):
        return set_current_model(model)

    if '<sbml ' in content and model.importSBMLFromString(content):
        return set_current_model(model)

    if '<sedML '  in content and model.importSEDMLFromString(content):
        return set_current_model(model)

    return remove_datamodel(model)


def load_model_from_url(url):
    """Loads either COPASI model / SBML model from the url.

    :param url: url to a copasi / sbml model
    :type url: str

    :return: the loaded model
    :rtype: COPASI.CDataModel
    """
    if _use_urllib2:
        content = urllib2.urlopen(url).read()
    else:
        content = urllib.request.urlopen(url).read()

    return load_model_from_string(content)


def load_model(location, remove_user_defined_functions=False):
    """Loads the model and sets it as current

    :param location: either a filename, url or raw string of a COPASI / SBML model
    :type location: str

    :param  remove_user_defined_functions: optional flag, indicating that user defined functions should be removed
            before loading the model. Since function definitions are global, this can be helpful to ensure that
            function names remain the same as in the loaded file. (default: False)
    :type remove_user_defined_functions: bool

    :return: the loaded model
    :rtype: COPASI.CDataModel
    """

    if remove_user_defined_functions:
        basico.model_info.remove_user_defined_functions()

    model = create_datamodel()

    if os.path.isfile(location):
        location = os.path.abspath(location)
        if zipfile.is_zipfile(location):
            try:
                if model.openCombineArchive(location):
                    return set_current_model(model)
            except COPASI.CCopasiException:
                pass
        try:
            if model.importSBML(location):
                return set_current_model(model)
        except COPASI.CCopasiException:
            pass
        try:
            if model.loadModel(location):
                return set_current_model(model)
        except COPASI.CCopasiException:
            pass
        try:
            if model.importSEDML(location):
                return set_current_model(model)
        except COPASI.CCopasiException:
            pass

    remove_datamodel(model)

    model_from_string = load_model_from_string(location)
    if model_from_string is not None:
        return model_from_string

    if 'https://' in location or 'http://' in location:
        return load_model_from_url(location)

    return None


def load_biomodel(model_id, remove_user_defined_functions=False):
    """Loads a model from the BioModels Database.

    :param model_id: either an integer of the biomodels id, or a valid biomodels id
    :type model_id: Union[int,str]

    :param  remove_user_defined_functions: optional flag, indicating that user defined functions should be removed
            before loading the model. Since function definitions are global, this can be helpful to ensure that
            function names remain the same as in the loaded file. (default: False)
    :type remove_user_defined_functions: bool

    :return:
    :rtype: COPASI.CDataModel
    """

    if remove_user_defined_functions:
        basico.model_info.remove_user_defined_functions()

    from . import biomodels

    return load_model_from_string(biomodels.get_content_for_model(model_id))


def get_examples(selector=''):
    """Returns the filenames of examples bundled with this version.

    A number of example models are included with the distribution. This method returns the filenames
    to those examples. Filtered by the argument.

    :param selector: a filter expression to be used, only files matching `*{selector}.[cps|xml]` will be returned
    :type selector: str
    :return: the list of examples matching
    :rtype: [str]
    """
    dir_name = os.path.dirname(__file__)
    types = ('*.xml', '*.cps')
    files = []
    for ext in types:
        files.extend(glob.glob(os.path.join(dir_name, 'data', '*{0}{1}'.format(selector, ext))))

    return files


def load_example(selector):
    """Loads the example matching the selector.

    :param selector: the filter expression to use for the examples see :func:`get_examples`
    :type selector: str
    :return: the loaded model, or None, if none matched
    :rtype: COPASI.CDataModel or None
    """
    files = get_examples(selector)

    if not files:
        return None

    return load_model(files[0])


def overview(model=None):
    """Returns a basic representation of the model.

    :param model: the model to get the overview for
    :type model: COPASI.CDataModel or None

    :return: a string, consisting of name, # compartments, # species, # parameters, # reaction
    :rtype: str
    """
    if model is None:
        model = get_current_model()

    c_model = model.getModel()

    assert (isinstance(c_model, COPASI.CModel))
    result = "Name:           {0}\n".format(c_model.getObjectName())
    if c_model.getNumCompartments() > 1:
        result += "# Compartments: {0}\n".format(c_model.getNumCompartments())
    if c_model.getNumMetabs() > 0:
        result += "# Species:      {0}".format(c_model.getNumMetabs())
    if c_model.getNumModelValues() > 0:
        result += "# Parameters:   {0}".format(c_model.getNumModelValues())
    if c_model.getNumReactions() > 0:
        result += "# Reactions:    {0}".format(c_model.getNumReactions())
    if c_model.getNumEvents() > 0:
        result += "# Events:       {0}".format(c_model.getNumEvents())

    return result


def print_model(model=None):
    """Prints the model overview.

    See also :func:`overview`

    :param model: the model
    :type model: COPASI.CDataModel

    :return: None
    """
    print(overview(model))


def save_model(filename, **kwargs):
    """Saves the model to the given filename.

    :param filename: the file to be written
    :type filename: str

    :param kwargs: optional arguments:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - `type` (str): `copasi` to write COPASI files, `sbml` to write SBML files (defaults to `copasi`),
      `sedml` to write SED-ML files, `omex` to write a COMBINE archive

    - `overwrite` (bool): whether the file should be overwritten if present (defaults to True)

    - `sbml_level` (int): SBML level to export

    - `sbml_version` (int): SBML version to export

    - `sedml_level` (int): SEDML level to export

    - `sedml_version` (int): SEDML version to export

    - `export_copasi_miriam` (bool): whether to export copasi miriam annotations

    - `export_incomplete` (bool): whether to export incomplete SBML model

    - `include_copasi` (bool): whether to include the COPASI file in the COMBINE archive (defaults to True)
    - `include_data` (bool): whether to include the data file in the COMBINE archive (defaults to True)
    - `include_sbml` (bool): whether to include the SBML file in the COMBINE archive (defaults to True)
    - `include_sedml` (bool): whether to include the SED-ML file in the COMBINE archive (defaults to False)

    :return: None
    """
    model = get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))
    file_type = kwargs.get('type', 'copasi').lower()
    overwrite = kwargs.get('overwrite', True)
    sbml_level = kwargs.get('sbml_level', kwargs.get('level', 2))
    sbml_version = kwargs.get('sbml_version', kwargs.get('version', 4))
    sedml_level = kwargs.get('sedml_level', kwargs.get('level', 1))
    sedml_version = kwargs.get('sedml_version', kwargs.get('version', 4))
    export_copasi_miriam = kwargs.get('export_copasi_miriam', True)
    export_incomplete = kwargs.get('export_incomplete', True)

    exporters = {
        'sbml': lambda filename: model.exportSBML(filename, overwrite, sbmlLevel=sbml_level, sbmlVersion=sbml_version,
                                                  exportIncomplete=export_incomplete,
                                                  exportCOPASIMIRIAM=export_copasi_miriam),
        'copasi': lambda filename: model.saveModel(filename, overwrite),
        'sedml': lambda filename: model.exportSEDML(filename, overwrite,
                                                    sedmlLevel=sedml_level, sedmlVersion=sedml_version),
        'omex': lambda filename: model.exportCombineArchive(filename,
                                                            includeCOPASI=kwargs.get('include_copasi', True),
                                                            includeSBML=kwargs.get('include_sbml', True),
                                                            includeData=kwargs.get('include_data', True),
                                                            includeSEDML=kwargs.get('include_sedml', False),
                                                            overwriteFile=overwrite,
                                                            sbmlLevel=sbml_level, sbmlVersion=sbml_version,
                                                            sedmlLevel=sedml_level, sedmlVersion=sedml_version)
    }

    if file_type in exporters:
        try:
            if not exporters[file_type](filename):
                logger.warning("Saving the file as {0} failed with: \n{1}".
                                format(os.path.basename(filename), COPASI.CCopasiMessage.getAllMessageText()))
        except COPASI.CCopasiException:
            logger.error("Couldn't save the file as {0}".format(os.path.basename(filename)))
    else:
        logger.error("Couldn't save the file as {0}, unknown file type {1}"
                      .format(os.path.basename(filename), file_type))


def save_model_to_string(**kwargs):
    """Saves the current model to string

    :param kwargs: optional arguments:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - `type` (str): `copasi` to write COPASI files, `sbml` to write SBML files (defaults to `copasi`),
      `sedml` to write SED-ML files

    - `sbml_level` (int): SBML level to export

    - `sbml_version` (int): SBML version to export

    - `sedml_level` (int): SEDML level to export

    - `sedml_version` (int): SEDML version to export

    :return: the copasi model as string
    :rtype: str

    """
    model = get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    file_type = kwargs.get('type', 'copasi').lower()
    sbml_level = kwargs.get('sbml_level', kwargs.get('level', 2))
    sbml_version = kwargs.get('sbml_version', kwargs.get('version', 4))
    sedml_level = kwargs.get('sedml_level', kwargs.get('level', 1))
    sedml_version = kwargs.get('sedml_version', kwargs.get('version', 4))

    exporters = {
        'copasi': lambda: model.saveModelToString(),
        'sbml': lambda: model.exportSBMLToString(sbml_level, sbml_version),
        'sedml': lambda: model.exportSEDMLToString(get_default_handler(),
                                                   sedml_level, sedml_version,
                                                   kwargs.get('model_location', 'model.xml'))
    }

    if file_type in exporters:
        try:
            return exporters[file_type]()
        except COPASI.CCopasiException:
            logger.error("Couldn't save the model")
    else:
        logger.error("Couldn't save the model, unknown file type {0}", file_type)


def save_model_and_data(filename, **kwargs):
    """Saves the model to the give filename, along with all experimental data files.

    :param filename: the filename of the COPASI file to write
    :param filename: str
    :param kwargs: optional arguments:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - | `delete_data_on_exit` (bool): a flag indicating whether the files should be deleted at the end of the
      | python session (defaults to False)

    :return: None
    """

    try:
        from . import task_parameterestimation
    except ImportError:
        import task_parameterestimation

    model = get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    has_validations = task_parameterestimation.num_validations_files(**kwargs)
    has_experiments = task_parameterestimation.num_experiment_files(**kwargs)

    delete_data_on_exit = kwargs.get('delete_data_on_exit', False)

    if has_experiments + has_validations == 0:
        # we have no experiments, so just save and return
        model.saveModel(filename, True)
        return

    global __temp_files

    data_dir = os.path.dirname(filename)
    if not data_dir:
        data_dir = '.'

    old_names = {}
    new_names = {}

    task = model.getTask("Parameter Estimation")
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    exp_set = problem.getExperimentSet()
    assert (isinstance(exp_set, COPASI.CExperimentSet))

    written_files = []

    # copy experiment files
    for old_name in exp_set.getFileNames():
        new_name = os.path.join(data_dir, os.path.basename(old_name))
        if new_name == old_name or new_name in written_files:
            # same file skipping
            continue

        if not os.path.exists(old_name) and not os.path.isabs(old_name):
            directory = os.path.dirname(model.getFileName())
            old_name = os.path.join(directory, old_name)

        if not os.path.exists(old_name):
            logger.warning("Experimental data file {0} does not exist, the resulting COPASI file cannot"
                            " be used for Parameter Estimation".format(old_name))
            continue

        if os.path.exists(new_name):
            logger.warning("Experimental data file {0} does already exist, and will not be overwritten."
                            .format(new_name))
        else:
            shutil.copyfile(old_name, new_name)
            written_files.append(new_name)
        old_names[old_name] = new_name
        new_names[new_name] = old_name
        if delete_data_on_exit:
            __temp_files.append(new_name)

    # rename experiments
    for i in range(problem.getExperimentSet().size()):
        experiment = problem.getExperimentSet().getExperiment(i)
        assert (isinstance(experiment, COPASI.CExperiment))

        new_name = old_names.get(experiment.getFileNameOnly(), '')
        if not new_name:
            continue

        # set relative path
        experiment.setFileName(os.path.relpath(new_name, data_dir))

    # write out model
    model.saveModel(filename, True)

    # rename experiments
    for i in range(problem.getExperimentSet().size()):
        experiment = problem.getExperimentSet().getExperiment(i)
        assert (isinstance(experiment, COPASI.CExperiment))

        old_name = new_names.get(experiment.getFileNameOnly(), '')
        if not old_name:
            continue

        experiment.setFileName(os.path.abspath(old_name))


def open_copasi(filename='', **kwargs):
    """Saves the model as COPASI file and opens it in COPASI.

    The file will be written to a temporary file, and then it will be executed, so that the
    application registered to open it will start.

    :param filename:  the file name to write to, if not given a temp file will be created
                      that will be deleted at the end of the python session.
    :type filename: str

    :param kwargs: optional arguments:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    model = get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))
    name = filename
    old_filename = model.getFileName()
    delete_data_on_exit = False

    if not name:
        global __temp_dirs, __temp_files
        temp_name = tempfile.mkdtemp()
        __temp_dirs.append(temp_name)

        name = os.path.join(temp_name, 'model.cps')
        __temp_files.append(name)

        logger.info('using temp file: ' + name)
        logger.warning("Created a temporary file to open. This file will be deleted later, so safe your changes.")
        delete_data_on_exit = True

    save_model_and_data(name, delete_data_on_exit=delete_data_on_exit, **kwargs)

    if delete_data_on_exit:
        # we need to set the filename back to the original one, otherwise relative paths will be broken
        model.setFileName(old_filename)

    if not os.path.exists(name):
        logger.error('Saving the model failed')

    if platform.system() == 'Darwin':
        subprocess.call(('open', name))
    elif platform.system() == 'Windows':  # Windows
        os.startfile(name)
    else:  # linux
        subprocess.call(('xdg-open', name))


@atexit.register
def __cleanup():
    # clean up temp files
    global __temp_files
    for name in __temp_files:
        if os.path.exists(name):
            os.remove(name)

    global __temp_dirs
    for name in __temp_dirs:
        if os.path.exists(name):
            try:
                os.removedirs(name)
            except OSError:
                logger.warning("Couldn't remove temp dir: {0}".format(name))
