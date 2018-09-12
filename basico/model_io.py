import COPASI
import os
import urllib2
import traceback
import logging
import glob
import atexit
import subprocess
import task_parameterestimation
import tempfile
import shutil

__current_model = None
__model_list = []
__temp_files = []
__temp_dirs = []


def set_current_model(model):
    # type: (COPASI.CDataModel) -> COPASI.CDataModel
    global __current_model
    global __model_list
    __current_model = model
    if model not in __model_list:
        __model_list.append(model)

    if __current_model is not None:
        logging.debug(model_info(__current_model))
    return __current_model


def get_current_model():
    # type: () -> COPASI.CDataModel
    global __current_model
    if __current_model is None:
        logging.warn('There is no model, creating a new one')
        new_model()
    return __current_model


def create_datamodel():
    # type: () -> COPASI.CDataModel
    try:
        data_model = COPASI.CRootContainer.addDatamodel()
    except:
        traceback.print_exc()
        data_model = COPASI.CCopasiRootContainer.addDatamodel()
    return data_model


def remove_datamodel(model):
    # type: (COPASI.CDataModel) -> None
    global __model_list
    global __current_model
    if model in __model_list:
        __model_list.remove(model)
    if __current_model is model:
        __current_model = None
    COPASI.CRootContainer.removeDatamodel(model)
    return None


def new_model():
    # type: () -> COPASI.CDataModel
    model = create_datamodel()
    model.newModel()
    return set_current_model(model)


def load_model_from_string(content):
    # type: (str) -> COPASI.CDataModel
    model = create_datamodel()
    if '<COPASI ' in content:
        if model.loadModelFromString(content, os.getcwd()):
            return set_current_model(model)

    if '<sbml ' in content:
        if model.importSBMLFromString(content):
            return set_current_model(model)

    return remove_datamodel(model)


def load_model_from_url(url):
    # type: (str) -> COPASI.CDataModel
    content = urllib2.urlopen(url).read()
    return load_model_from_string(content)


def load_model(location):
    # type: (str) -> COPASI.CDataModel
    model = create_datamodel()

    if os.path.isfile(location):
        if model.importSBML(location):
            return set_current_model(model)
        if model.loadModel(location):
            return set_current_model(model)

    remove_datamodel(model)

    model_from_string = load_model_from_string(location)
    if model_from_string is not None:
        return model_from_string

    if 'https://' in location or 'http://' in location:
        return load_model_from_url(location)

    return None


def load_biomodel_from_caltech(model_id):
    # type: (Union[int, str, unicode]) -> COPASI.CDataModel
    if type(model_id) is int:
        url = 'http://biomodels.caltech.edu/download?mid=BIOMD{0:010d}'.format(model_id)
    else:
        url = 'http://biomodels.caltech.edu/download?mid={0}'.format(model_id)
    return load_model_from_url(url)


def load_biomodel(model_id):
    # type: (Union[int, str, unicode]) -> COPASI.CDataModel
    if type(model_id) is int:
        url = 'http://www.ebi.ac.uk/biomodels-main/download?mid=BIOMD{0:010d}'.format(model_id)
    else:
        url = 'http://www.ebi.ac.uk/biomodels-main/download?mid={0}'.format(model_id)
    return load_model_from_url(url)


def get_examples(selector = ''):
    # type: (str) -> [str]
    dir_name = os.path.dirname(__file__)
    types = ('*.xml', '*.cps')
    files = []
    for ext in types:
        files.extend(glob.glob(os.path.join(dir_name, 'data', '*{0}{1}'.format(selector, ext))))

    return files


def load_example(selector):
    # type: (str) -> COPASI.CDataModel
    files = get_examples(selector)

    if not files:
        return None

    return load_model(files[0])


def model_info(model=None):
    # type: (COPASI.CDataModel) -> Str
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
    # type: (COPASI.CDataModel) -> None
    if model is None:
        model = get_current_model()
    print (model_info(model))


def save_model(filename, **kwargs):
    # type: (str, **kwargs) -> None
    model = kwargs.get('model', get_current_model())
    assert (isinstance(model, COPASI.CDataModel))
    file_type = kwargs.get('type', 'copasi').lower()
    overwrite = kwargs.get('overwrite', True)
    level = kwargs.get('level', 2)
    version = kwargs.get('version', 4)
    export_copasi_miriam = kwargs.get('export_copasi_miriam', True)
    export_incomplete = kwargs.get('export_incomplete', True)

    exporters = {
        'sbml': lambda filename: model.exportSBML(filename, overwrite, sbmlLevel=level, sbmlVersion=version,
                                                  exportIncomplete=export_incomplete,
                                                  export_copasi_miriam=export_copasi_miriam),
        'copasi': lambda filename: model.saveModel(filename, overwrite ),
    }

    if file_type in exporters:
        try:
            if not exporters[file_type](filename):
                logging.warning("Saving the file as {0} failed with: \n{1}".format(os.path.basename(filename), COPASI.CCopasiMessage.getAllMessageText()))
        except:
            logging.error("Couldn't save the file as {0}".format(os.path.basename(filename)))


def save_model_and_data(filename, **kwargs):
    model = kwargs.get('model', get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    has_validations = task_parameterestimation.num_validations_files(**kwargs)
    has_experiments = task_parameterestimation.num_experiment_files(**kwargs)

    delete_data_on_exit = kwargs.get('delete_data_on_exit', False)

    global __temp_files

    if has_experiments + has_validations > 0:

        data_dir = os.path.dirname(filename)
        if not data_dir:
            data_dir = '.'

        old_names = {}
        new_names = {}

        model = kwargs.get('model', get_current_model())
        assert (isinstance(model, COPASI.CDataModel))

        task = model.getTask("Parameter Estimation")
        assert (isinstance(task, COPASI.CFitTask))

        problem = task.getProblem()
        assert (isinstance(problem, COPASI.CFitProblem))

        exp_set = problem.getExperimentSet();
        assert (isinstance(exp_set, COPASI.CExperimentSet))

        # copy experiment files
        for old_name in exp_set.getFileNames():
            new_name = os.path.join(data_dir, os.path.basename(old_name))
            if not os.path.exists(old_name):
                logging.warning("Experimental data file {0} does not exist, the resulting COPASI file cannot be used for Parameter Estimation")
                continue
            shutil.copyfile(old_name, new_name)
            old_names [old_name] = new_name
            new_names [new_name] = old_name
            if delete_data_on_exit:
                __temp_files.append(new_name)

        # rename experiments
        for i in range(problem.getExperimentSet().size()):
            experiment = problem.getExperimentSet().getExperiment(i)
            assert (isinstance(experiment, COPASI.CExperiment))

            new_name = old_names.get(experiment.getFileNameOnly(), '')
            if not new_name:
                continue

            experiment.setFileName(new_name)

        # export model to string
        model_string = model.saveModelToString()

        # rename experiments
        for i in range(problem.getExperimentSet().size()):
            experiment = problem.getExperimentSet().getExperiment(i)
            assert (isinstance(experiment, COPASI.CExperiment))

            old_name = new_names.get(experiment.getFileNameOnly(), '')
            if not old_name:
                continue

            experiment.setFileName(old_name)

        with open(filename, 'w') as f:
            f.write(model_string)
    else:
        model.saveModel(filename, True)


def open_copasi(**kwargs):
    model = kwargs.get('model', get_current_model())
    assert (isinstance(model, COPASI.CDataModel))
    name = kwargs.get('filename', '')

    if not name:
        global __temp_dirs, __temp_files
        temp_name = tempfile.mkdtemp()
        __temp_dirs.append(temp_name)

        name = os.path.join(temp_name, 'model.cps')
        __temp_files.append(name)

        logging.info('using temp file: ' + name)
        logging.warning("Created a temporary file to open. This file will be deleted later, so safe your changes.")
        save_model_and_data(name, delete_data_on_exit=True, **kwargs)

    subprocess.call(name, shell=True)


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
            except:
                logging.warning("Couldn't remove temp dir: {0}".format(name))
