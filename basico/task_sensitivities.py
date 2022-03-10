"""Utility methods for working with the sensitivity task

"""
import logging

import basico
import COPASI

from . import model_io

class EnumHelper:
    """Utility class for dealing with mapping from names to enums easier

    """

    _names = None
    _values = None

    @classmethod
    def _create_name_map(cls):
        return dict()

    @classmethod
    def _create_value_map(cls):
        if cls._names is None:
            cls._names = cls._create_name_map()

        return basico.model_info._invert_dict(cls._names)

    @classmethod
    def _convert_names_to_values(cls):
        cls._values = basico.model_info._invert_dict(cls._names)

    @classmethod
    def from_enum(cls, int_value):
        if cls._names is None:
            cls._names = cls._create_name_map()

        return cls._names.get(int_value, next(iter(cls._names.items()))[1])

    @classmethod
    def to_enum(cls, value):
        if cls._values is None:
            cls._values = cls._create_value_map()

        return cls._values.get(value, next(iter(cls._values.items()))[1])

    @classmethod
    def get_all_names(cls):
        if cls._names is None:
            cls._names = cls._create_name_map()
        return cls._names.values()


class SENS(EnumHelper):
    """Class for Sensitivity object lists

    """

    EMPTY_LIST = "Not Set"
    SINGLE_OBJECT = "Single Object"

    METABS = "Species"
    METAB_INITIAL_CONCENTRATIONS = "Initial Concentrations"
    METAB_INITIAL_NUMBERS = "Initial Numbers"
    METAB_CONCENTRATIONS = "Concentrations of Species"
    METAB_NUMBERS = "Numbers of Species"
    NON_CONST_METAB_CONCENTRATIONS = "Non-Constant Concentrations of Species"
    NON_CONST_METAB_NUMBERS = "Non-Constant Numbers of Species"
    CONST_METAB_CONCENTRATIONS = "Constant Concentrations of Species"
    CONST_METAB_NUMBERS = "Constant Numbers of Species"
    ODE_METAB_CONCENTRATIONS = "Concentrations of Species with ODE"
    ODE_METAB_NUMBERS = "Numbers of Species with ODE"
    REACTION_METAB_CONCENTRATIONS = "Concentrations of Species determined by Reactions"
    REACTION_METAB_NUMBERS = "Numbers of Species determined by Reactions"
    ASS_METAB_CONCENTRATIONS = "Concentrations of Species with Assignment"
    ASS_METAB_NUMBERS = "Numbers of Species with Assignment"
    METAB_CONC_RATES = "Concentration Rates"
    METAB_PART_RATES = "Particle Rates"
    METAB_TRANSITION_TIME = "Transition Time"

    REACTIONS = "Reactions"
    REACTION_CONC_FLUXES = "Concentration Fluxes of Reactions"
    REACTION_PART_FLUXES = "Particle Fluxes of Reactions"

    GLOBAL_PARAMETERS = "Global Quantity"
    GLOBAL_PARAMETER_INITIAL_VALUES = "Global Quantity Initial Values"
    GLOBAL_PARAMETER_VALUES = "Global Quantity Values"
    NON_CONST_GLOBAL_PARAMETER_VALUES = "Non-Constant Global Quantity Values"
    CONST_GLOBAL_PARAMETER_INITIAL_VALUES = "Constant Global Quantity Values"
    ODE_GLOBAL_PARAMETER_VALUES = "Values of Global Quantities with ODE"
    ASS_GLOBAL_PARAMETER_VALUES = "Values of Global Quantities with Assignment"
    GLOBAL_PARAMETER_RATES = "Global Quantity Rates"

    COMPARTMENTS = "Compartments"
    COMPARTMENT_INITIAL_VOLUMES = "Compartment Initial Volumes"
    COMPARTMENT_VOLUMES = "Compartment Volumes"
    NON_CONST_COMPARTMENT_VOLUMES = "Non-Constant Compartment Volumes"
    CONST_COMPARTMENT_VOLUMES = "Constant Compartment Volumes"
    ODE_COMPARTMENT_VOLUMES = "Values of Compartment Volumes with ODE"
    ASS_COMPARTMENT_VOLUMES = "Values of Compartment Volumes with Assignment"
    COMPARTMENT_RATES = "Compartment Volume Rates"

    ALL_INITIAL_VALUES = "All initial Values"
    ALL_LOCAL_PARAMETER_VALUES = "Local Parameter Values"

    ALL_PARAMETER_VALUES = "All Parameter Values"
    ALL_PARAMETER_AND_INITIAL_VALUES = "All Parameter and Initial Values"

    ALL_VARIABLES = "All Variables of the model"
    ALL_ODE_VARIABLES = "All independent Variables of the model"

    REDUCED_JACOBIAN_EV_RE = "Real part of eigenvalues of the reduced jacobian"
    REDUCED_JACOBIAN_EV_IM = "Imaginary part of eigenvalues of the reduced jacobian"

    @classmethod
    def _create_name_map(cls):
        result = {
            COPASI.CObjectLists.EMPTY_LIST: SENS.EMPTY_LIST,
            COPASI.CObjectLists.SINGLE_OBJECT: SENS.SINGLE_OBJECT,

            COPASI.CObjectLists.METABS: SENS.METABS,
            COPASI.CObjectLists.METAB_INITIAL_CONCENTRATIONS: SENS.METAB_INITIAL_CONCENTRATIONS,
            COPASI.CObjectLists.METAB_INITIAL_NUMBERS: SENS.METAB_INITIAL_NUMBERS,
            COPASI.CObjectLists.METAB_CONCENTRATIONS: SENS.METAB_CONCENTRATIONS,
            COPASI.CObjectLists.METAB_NUMBERS: SENS.METAB_NUMBERS,
            COPASI.CObjectLists.NON_CONST_METAB_CONCENTRATIONS: SENS.NON_CONST_METAB_CONCENTRATIONS,
            COPASI.CObjectLists.NON_CONST_METAB_NUMBERS: SENS.NON_CONST_METAB_NUMBERS,
            COPASI.CObjectLists.CONST_METAB_CONCENTRATIONS: SENS.CONST_METAB_CONCENTRATIONS,
            COPASI.CObjectLists.CONST_METAB_NUMBERS: SENS.CONST_METAB_NUMBERS,
            COPASI.CObjectLists.ODE_METAB_CONCENTRATIONS: SENS.ODE_METAB_CONCENTRATIONS,
            COPASI.CObjectLists.ODE_METAB_NUMBERS: SENS.ODE_METAB_NUMBERS,
            COPASI.CObjectLists.REACTION_METAB_CONCENTRATIONS: SENS.REACTION_METAB_CONCENTRATIONS,
            COPASI.CObjectLists.REACTION_METAB_NUMBERS: SENS.REACTION_METAB_NUMBERS,
            COPASI.CObjectLists.ASS_METAB_CONCENTRATIONS: SENS.ASS_METAB_CONCENTRATIONS,
            COPASI.CObjectLists.ASS_METAB_NUMBERS: SENS.ASS_METAB_NUMBERS,
            COPASI.CObjectLists.METAB_CONC_RATES: SENS.METAB_CONC_RATES,
            COPASI.CObjectLists.METAB_PART_RATES: SENS.METAB_PART_RATES,
            COPASI.CObjectLists.METAB_TRANSITION_TIME: SENS.METAB_TRANSITION_TIME,

            COPASI.CObjectLists.REACTIONS: SENS.REACTIONS,
            COPASI.CObjectLists.REACTION_CONC_FLUXES: SENS.REACTION_CONC_FLUXES,
            COPASI.CObjectLists.REACTION_PART_FLUXES: SENS.REACTION_PART_FLUXES,

            COPASI.CObjectLists.GLOBAL_PARAMETERS: SENS.GLOBAL_PARAMETERS,
            COPASI.CObjectLists.GLOBAL_PARAMETER_INITIAL_VALUES: SENS.GLOBAL_PARAMETER_INITIAL_VALUES,
            COPASI.CObjectLists.GLOBAL_PARAMETER_VALUES: SENS.GLOBAL_PARAMETER_VALUES,
            COPASI.CObjectLists.NON_CONST_GLOBAL_PARAMETER_VALUES: SENS.NON_CONST_GLOBAL_PARAMETER_VALUES,
            COPASI.CObjectLists.CONST_GLOBAL_PARAMETER_INITIAL_VALUES: SENS.CONST_GLOBAL_PARAMETER_INITIAL_VALUES,
            COPASI.CObjectLists.ODE_GLOBAL_PARAMETER_VALUES: SENS.ODE_GLOBAL_PARAMETER_VALUES,
            COPASI.CObjectLists.ASS_GLOBAL_PARAMETER_VALUES: SENS.ASS_GLOBAL_PARAMETER_VALUES,
            COPASI.CObjectLists.GLOBAL_PARAMETER_RATES: SENS.GLOBAL_PARAMETER_RATES,

            COPASI.CObjectLists.COMPARTMENTS: SENS.COMPARTMENTS,
            COPASI.CObjectLists.COMPARTMENT_INITIAL_VOLUMES: SENS.COMPARTMENT_INITIAL_VOLUMES,
            COPASI.CObjectLists.COMPARTMENT_VOLUMES: SENS.COMPARTMENT_VOLUMES,
            COPASI.CObjectLists.NON_CONST_COMPARTMENT_VOLUMES: SENS.NON_CONST_COMPARTMENT_VOLUMES,
            COPASI.CObjectLists.CONST_COMPARTMENT_VOLUMES: SENS.CONST_COMPARTMENT_VOLUMES,
            COPASI.CObjectLists.ODE_COMPARTMENT_VOLUMES: SENS.ODE_COMPARTMENT_VOLUMES,
            COPASI.CObjectLists.ASS_COMPARTMENT_VOLUMES: SENS.ASS_COMPARTMENT_VOLUMES,
            COPASI.CObjectLists.COMPARTMENT_RATES: SENS.COMPARTMENT_RATES,

            COPASI.CObjectLists.ALL_INITIAL_VALUES: SENS.ALL_INITIAL_VALUES,
            COPASI.CObjectLists.ALL_LOCAL_PARAMETER_VALUES: SENS.ALL_LOCAL_PARAMETER_VALUES,

            COPASI.CObjectLists.ALL_PARAMETER_VALUES: SENS.ALL_PARAMETER_VALUES,
            COPASI.CObjectLists.ALL_PARAMETER_AND_INITIAL_VALUES: SENS.ALL_PARAMETER_AND_INITIAL_VALUES,

            COPASI.CObjectLists.ALL_VARIABLES: SENS.ALL_VARIABLES,
            COPASI.CObjectLists.ALL_ODE_VARIABLES: SENS.ALL_ODE_VARIABLES,

            COPASI.CObjectLists.REDUCED_JACOBIAN_EV_RE: SENS.REDUCED_JACOBIAN_EV_RE,
            COPASI.CObjectLists.REDUCED_JACOBIAN_EV_IM: SENS.REDUCED_JACOBIAN_EV_IM
        }

        cls._names = result
        cls._values = basico.model_info._invert_dict(result)

        return result


class SENS_ST(EnumHelper):
    """Enumeration of Sensitivity Subtasks"""
    Evaluation = "Evaluation"
    SteadyState = "Steady State"
    TimeSeries = "Time Series"
    ParameterEstimation = "Parameter Estimation"
    Optimization = "Optimization"
    CrossSection = "Cross Section"

    @classmethod
    def _create_name_map(cls):
        return {
            COPASI.CSensProblem.Evaluation: SENS_ST.Evaluation,
            COPASI.CSensProblem.SteadyState: SENS_ST.SteadyState,
            COPASI.CSensProblem.TimeSeries: SENS_ST.TimeSeries,
            COPASI.CSensProblem.ParameterEstimation: SENS_ST.ParameterEstimation,
            COPASI.CSensProblem.Optimization: SENS_ST.Optimization,
            COPASI.CSensProblem.CrossSection: SENS_ST.CrossSection,
        }

    @classmethod
    def _create_value_map(cls):
        cls._names = cls._create_name_map()
        cls._convert_names_to_values()

        # add alternative names used throughout basico elsewhere
        cls._values[basico.T.STEADY_STATE] = COPASI.CSensProblem.SteadyState
        cls._values[basico.T.TIME_COURSE] = COPASI.CSensProblem.TimeSeries

        return cls._values


def get_sensitivity_settings(basic_only=True, **kwargs):
    """Returns the settings of the sensitivity task

    :param basic_only: if true, only basic parameters will be returned
    :type basic_only: bool

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)


    :return: the settings as dictionary
    :rtype: dict
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    settings = basico.get_task_settings(basico.T.SENSITIVITIES, basic_only, model=model)
    del settings['problem']

    task = model.getTask(basico.T.SENSITIVITIES)
    assert (isinstance(task, COPASI.CSensTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSensProblem))

    settings['sub_task'] = SENS_ST.from_enum(problem.getSubTaskType())

    item = problem.getTargetFunctions()
    assert (isinstance(item, COPASI.CSensItem))

    settings['effect'] = _get_name_for_item(item, model)

    num_causes = problem.getNumberOfVariables()

    cause = SENS.EMPTY_LIST
    if num_causes > 0:
        cause = _get_name_for_item(problem.getVariables(0), model)
    settings['cause'] = cause

    cause = SENS.EMPTY_LIST
    if num_causes > 1:
        cause = _get_name_for_item(problem.getVariables(1), model)
    settings['secondary_cause'] = cause

    return settings


def set_sensitivity_settings(settings, **kwargs):
    """Applies the settings to the sensitivity task

    :param settings: the setting dictionary with keys, as obtained by get_sensitivity_settings
    :type settings: dict

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)


    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    basico.set_task_settings(basico.T.SENSITIVITIES, settings, model=model)

    task = model.getTask(basico.T.SENSITIVITIES)
    assert (isinstance(task, COPASI.CSensTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSensProblem))

    if 'sub_task' in settings:
        problem.setSubTaskType(SENS_ST.to_enum(settings['sub_task']))

    if 'effect' in settings:
        problem.setTargetFunctions(_to_sens_item(settings['effect'], model))

    if 'cause' in settings:
        problem.changeVariables(0, _to_sens_item(settings['cause'], model))

    if 'secondary_cause' in settings:
        problem.changeVariables(1, _to_sens_item(settings['secondary_cause'], model))


def _to_sens_item(name, model):
    """converts the name to a sens item

    :param name: display name, cn or object list name
    :type name: str
    :param model: the model to resolve elements in
    :return: the sens item for the named element
    """
    if name in SENS.get_all_names():
        return COPASI.CSensItem(SENS.to_enum(name))

    if name.startswith('CN='):
        return COPASI.CSensItem(COPASI.CCommonName(name))

    obj = model.findObjectByDisplayName(name)
    if obj is None:
        logging.warning('Object could not be resolved {0}'.format(name))
        return COPASI.CSensItem(0)

    if obj.getObjectType() != 'Reference':
        obj = obj.getValueReference()

    return COPASI.CSensItem(obj.getCN())


def _get_name_for_item(item, model):
    """ Transforms the sens item to a name

    :param item: the sens item
    :type: COPASI.CSensItem

    :param model: the model for resolving elements in
    :type model: COPASI.CDataModel

    :return: the name for the element, or list
    :rtype: str
    """
    name = SENS.EMPTY_LIST
    if item.isSingleObject():
        cn = item.getSingleObjectCN()
        obj = model.getObject(cn)
        if obj is None:
            logging.warning('Object for sensitivities not found')

        name = basico.model_info._get_name_for_object(obj, model=model)
    else:
        name = item.getListTypeDisplayName()
    return name


def run_sensitivities(**kwargs):
    """Runs the sensitivity task, the result is obtained

    by calling:

    * `get_scaled_sensitivies`
    * `get_unscaled_sensitivies` or
    * `get_summarized_sensitivites`

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    if 'settings' in kwargs:
        basico.set_sensitivity_settings(kwargs['settings'], model=model)

    task = model.getTask(basico.T.SENSITIVITIES)
    assert (isinstance(task, COPASI.CSensTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSensProblem))

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logging.error('Could not initialize Sensitivity Task: {0}'.format(COPASI.CCopasiMessage.getAllMessageText()))
        return

    use_initial_values = kwargs.get('use_initial_values', True)

    if not task.processRaw(use_initial_values):
        logging.error('Could not run Sensitivity Task: {0}'.format(COPASI.CCopasiMessage.getAllMessageText()))
        return

    task.restore()


def get_scaled_sensitivities(**kwargs):
    """Returns the scaled sensitivity matrix as pandas data frame

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `run_first`: boolean flag indicating that the task should be run first (defaults to false)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the scaled sensitivity matrix
    :rtype: pd.DataFrame
    """

    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    if 'run_first' in kwargs and kwargs['run_first']:
        run_sensitivities(**kwargs)

    task = model.getTask(basico.T.SENSITIVITIES)
    assert (isinstance(task, COPASI.CSensTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSensProblem))

    return basico.model_info._annotated_matrix_to_df(problem.getScaledResultAnnotated())


def get_unscaled_sensitivities(**kwargs):
    """Returns the unscaled sensitivity matrix as pandas data frame

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `run_first`: boolean flag indicating that the task should be run first (defaults to false)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the unscaled sensitivity matrix
    :rtype: pd.DataFrame
    """

    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    if 'run_first' in kwargs and kwargs['run_first']:
        run_sensitivities(**kwargs)

    task = model.getTask(basico.T.SENSITIVITIES)
    assert (isinstance(task, COPASI.CSensTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSensProblem))

    return basico.model_info._annotated_matrix_to_df(problem.getResultAnnotated())


def get_summarized_sensitivities(**kwargs):
    """Returns the summarized sensitivity matrix as pandas data frame

    The summarized result is computed as the 2 norm of the scaled result, thus collapsing the dimension

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `run_first`: boolean flag indicating that the task should be run first (defaults to false)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the summarized sensitivity matrix
    :rtype: pd.DataFrame or None
    """

    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    if 'run_first' in kwargs and kwargs['run_first']:
        run_sensitivities(**kwargs)

    task = model.getTask(basico.T.SENSITIVITIES)
    assert (isinstance(task, COPASI.CSensTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSensProblem))

    return basico.model_info._annotated_matrix_to_df(problem.getCollapsedResultAnnotated())

