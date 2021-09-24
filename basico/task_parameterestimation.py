"""Submodule with utility methods for carrying out and plotting of parameter estimations.

The main function provided by this submodule is :func:`run_parameter_estimation`. Without any parameters, the
previously set up parameter estimation as stored in the file will be carried out. And the parameters found will
be returned.

It is also possible to set up parameter estimation problems from scratch. To make it as simple as possible, pandas
data frames are used, the mapping from the columns to the model element will be done implicitly by naming the
columns like the corresponding model elements.

Example:

    >>> from basico import *
    >>> m = model_io.load_example("LM-test1")
    >>> print(get_fit_parameters())
    >>> print(get_parameters_solution())
    >>> run_parameter_estimation(method='Levenberg - Marquardt')
    >>> print(get_parameters_solution())

"""

import pandas
import COPASI
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import logging

import basico

AFFECTED_EXPERIMENTS = 'Affected Experiments'
TASK_PARAMETER_ESTIMATION = 'Parameter Estimation'


class PE:
    """Constants for Parameter estimation method names"""
    CURRENT_SOLUTION = "Current Solution Statistics"
    RANDOM_SEARCH = "Random Search"
    SIMULATED_ANNEALING = "Simulated Annealing"
    DIFFERENTIAL_EVOLUTION = "Differential Evolution"
    SCATTER_SEARCH = "Scatter Search"
    GENETIC_ALGORITHM = "Genetic Algorithm"
    EVOLUTIONARY_PROGRAMMING = "Evolutionary Programming"
    GENETIC_ALGORITHM_SR = "Genetic Algorithm SR"
    EVOLUTIONARY_STRATEGY_SRES = "Evolution Strategy (SRES)"
    PARTICLE_SWARM = "Particle Swarm"
    LEVENBERG_MARQUARDT = "Levenberg - Marquardt"
    HOOKE_JEEVES = "Hooke & Jeeves"
    NELDER_MEAD = "Nelder - Mead"
    STEEPEST_DESCENT = "Steepest Descent"
    NL2SOL = "NL2SOL"
    PRAXIS = "Praxis"
    TRUNCATED_NEWTON = "Truncated Newton"


try:
    from . import model_io
except ValueError:
    import model_io

try:
    from builtins import ValueError
except ImportError:
    pass


def num_experiment_files(**kwargs):
    """Return the number of experiment files defined.

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: number of experiment files
    :rtype: int
    """
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    return problem.getExperimentSet().size()


def get_experiment_names(**kwargs):
    """Returns the list of experiment names

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: list of experiment names defined
    :rtype: [str]
    """
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    result = []
    for i in range(problem.getExperimentSet().size()):
        experiment = problem.getExperimentSet().getExperiment(i)
        result.append(experiment.getObjectName())
    return result


def _get_experiment_keys(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    result = []
    for i in range(problem.getExperimentSet().size()):
        experiment = problem.getExperimentSet().getExperiment(i)
        result.append(experiment.getKey())
    return result


def num_validations_files(**kwargs):
    """Returns the number of cross validation experiment files

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: number of cross validation experiment files
    :rtype: int
    """
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    return problem.getCrossValidationSet().size()


def _role_to_string(role):
    names = {
        COPASI.CExperiment.time: 'time',
        COPASI.CExperiment.ignore: 'ignored',
        COPASI.CExperiment.independent: 'independent',
        COPASI.CExperiment.dependent: 'dependent',
    }
    return names.get(role, COPASI.CExperiment.ignore)


def get_experiment(experiment, **kwargs):
    """Returns the specified experiment.

    :param experiment: experiment name or index
    :type experiment: int or str or COPASI.CExperiment

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: the experiment or an error if none existent
    """
    if not isinstance(experiment, COPASI.CExperiment):
        model = kwargs.get('model', model_io.get_current_model())
        assert (isinstance(model, COPASI.CDataModel))

        task = model.getTask(TASK_PARAMETER_ESTIMATION)
        assert (isinstance(task, COPASI.CFitTask))

        problem = task.getProblem()
        assert (isinstance(problem, COPASI.CFitProblem))
        exp_set = problem.getExperimentSet()

        if type(experiment) is int and experiment >= exp_set.size():
            raise ValueError('Experiment index out of bounds')
        exp = exp_set.getExperiment(experiment)
        if exp is not None:
            experiment = exp
        else:
            raise ValueError('No experiment for: {0}'.format(experiment))
    return experiment


def get_experiment_mapping(experiment, **kwargs):
    """Retrieves a data frame of the experiment mapping.

    The resulting data frame will have the columns:
    * `column` (int): index of the column in the file
    * `type` (str): 'time', 'dependent', 'indepenent' or 'ignored'
    * 'mapping' (str): the name of the element it is mapped to
    * 'cn' (str): internal identifier

    :param experiment: the experiment to get the mapping from
    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: data frame with the mapping as described
    :rtype: pandas.DataFrame
    """
    experiment = get_experiment(experiment, **kwargs)

    obj_map = experiment.getObjectMap()
    rows = []
    for i in range(obj_map.getLastColumn() + 1):
        role = obj_map.getRole(i)
        cn = obj_map.getObjectCN(i)
        obj = ''
        if cn:
            obj = experiment.getObjectDataModel().getObject(COPASI.CCommonName(cn))
            if obj:
                obj = obj.getObjectDisplayName()

        rows.append({
            'column': i,
            'type': _role_to_string(role),
            'mapping': obj,
            'cn': cn,
        })

    return pandas.DataFrame(data=rows).set_index('column')


def _get_experiment_file(experiment):
    file_name_only = experiment.getFileNameOnly()
    model = experiment.getObjectDataModel()
    directory = os.path.dirname(model.getFileName())

    if os.path.exists(os.path.join(directory, file_name_only)):
        return os.path.join(directory, file_name_only)

    if os.path.exists(file_name_only):
        return file_name_only

    file_name = experiment.getFileName()
    if os.path.exists(file_name):
        return file_name

    raise ValueError('Experiment file {0} does not exist'.format(file_name_only))


def get_data_from_experiment(experiment, **kwargs):
    """Returns the data of the given experiment as dataframe

    :param experiment: the experiment
    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - | `rename_headers` (bool): if true (default) the columns of the headers will be renamed
      | with the names of the element it is mapped to. Also all ignored columns will be removed from the
      | dataset

    :return: dataframe with experimental data
    :rtype: pandas.DataFrame
    """
    experiment = get_experiment(experiment, **kwargs)
    experiment_file = _get_experiment_file(experiment)
    num_lines = sum(1 for line in open(experiment_file))
    header_row = experiment.getHeaderRow()
    have_headers = header_row < num_lines
    skip_idx = [x-1 for x in range(1, num_lines+1) if
                not (experiment.getFirstRow() <= x <= experiment.getLastRow())]

    if 'rename_headers' in kwargs:
        rename_headers = kwargs['rename_headers']
    else:
        rename_headers = True

    if have_headers and rename_headers:
        skip_idx.insert(0, header_row-1)

    drop_cols = []
    headers = {}
    obj_map = experiment.getObjectMap()
    if rename_headers:
        count = 0
        for i in range(obj_map.size()):
            role = obj_map.getRole(i)

            if role == COPASI.CExperiment.time:
                headers[count] = 'Time'
                count += 1

            elif role == COPASI.CExperiment.ignore:
                drop_cols.append(i)

            else:
                cn = obj_map.getObjectCN(i)
                obj = experiment.getObjectDataModel().getObject(COPASI.CCommonName(cn))
                if obj:
                    headers[count] = obj.getObjectDisplayName()
                    count += 1
                else:
                    drop_cols.append(i)

    if rename_headers or not have_headers:
        df = pandas.read_csv(experiment_file,
                             sep=experiment.getSeparator(),
                             header=None,
                             skiprows=skip_idx)
    else:
        df = pandas.read_csv(experiment_file,
                             sep=experiment.getSeparator(),
                             skiprows=skip_idx)

    if not rename_headers:
        return df

    all_columns = list(df.columns)
    for i in range(obj_map.size(), len(all_columns)):
        # drop additional columns not mapped
        drop_cols.append(all_columns[i])

    if any(drop_cols):
        df.drop(drop_cols, axis=1, inplace=True)

    df.rename(columns=headers, inplace=True)

    return df


def get_experiment_data_from_model(model=None):
    """Returns all experimental data from the model

    :param model: the model to get the data from
    :type model: COPASI.CDataModel or None
    :return: list of dataframes with experimental data (with columns renamed and unmapped columns dropped)
    :rtype: [pandas.DataFrame]
    """
    if model is None:
        model = model_io.get_current_model()
    result = []

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    num_experiments = experiments.getExperimentCount()
    if num_experiments == 0:
        return result

    for i in range(num_experiments):
        experiment = experiments.getExperiment(i)
        df = get_data_from_experiment(experiment, rename_headers=True)
        result.append(df)

    return result


def get_experiment_filenames(model=None):
    """Returns filenames of all experiments

    :param model: the model to get the data from
    :type model: COPASI.CDataModel or None
    :return: list of filenames of experimental data
    :rtype: [str]
    """
    if model is None:
        model = model_io.get_current_model()
    result = []

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    num_experiments = experiments.getExperimentCount()
    if num_experiments == 0:
        return result

    for i in range(num_experiments):
        experiment = experiments.getExperiment(i)
        result.append(_get_experiment_file(experiment))

    return result


def get_fit_item_template(include_local=False, include_global=False, default_lb=0.001, default_ub=1000, model=None):
    """Returns a template list of items to be used for the parameter estimation

    :param include_local: boolean, indicating whether to include local parameters
    :type include_local: bool

    :param include_global:  boolean indicating whether to include global parameters
    :type include_global: bool

    :param default_lb: default lower bound to be used
    :type default_lb: float

    :param default_ub: default upper bound to be used
    :type default_ub: float

    :param model: the model or None
    :type model: COPASI.CDataModel or None

    :return: List of dictionaries, with the local / global parameters in the format needed by:
             :func:`set_fit_parameters`.
    :rtype: [{}]
    """

    if model is None:
        model = model_io.get_current_model()

    result = []

    if include_global:

        for mv in model.getModel().getModelValues():
            if mv.getStatus() == COPASI.CModelEntity.Status_FIXED:
                result.append({
                    'name': mv.getInitialValueReference().getObjectDisplayName(),
                    'lower': default_lb,
                    'upper': default_ub
                })

    if include_local:

        from . import model_info
        local_params = model_info.get_reaction_parameters().reset_index()
        for name, local in zip(local_params['name'], local_params['type']):

            if local == 'local':
                result.append({
                    'name': name,
                    'lower': default_lb,
                    'upper': default_ub
                })

    return result


def get_fit_parameters(model=None):
    """Returns a data frame with all fit parameters

    The resulting dataframe will have the following columns:

    * `name`: the name of the fit parameter
    * `lower`: the lower bound of the parameter
    * `upper`: the upper bound of the parameter
    * `start`: the start value
    * | `affected`: a list of all experiments (names) the fit parameter should apply to. If empty the parameter should
      | be varied for all experiments.
    * `cn`: internal identifier

    :param model: the model to get the fit parameters from
    :type model: COPASI.CDataModel or None

    :return: data frame with the fit parameters
    :rtype: pandas.DataFrame
    """
    if model is None:
        model = model_io.get_current_model()

    pe_task = model.getTask(TASK_PARAMETER_ESTIMATION)
    problem = pe_task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    items = problem.getOptItemList()
    data = []

    for i in range(len(items)):
        item = items[i]
        obj = model.getObject(COPASI.CCommonName(item.getObjectCN())).toObject().getObjectParent()
        name = obj.getObjectDisplayName()
        data.append({
            'name': name,
            'lower': item.getLowerBound(),
            'upper': item.getUpperBound(),
            'start': item.getStartValue(),
            'affected': _get_affected_experiments(item),
            'cn': item.getObjectCN(),
        })

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def set_fit_parameters(fit_parameters, model=None):
    """Replaces all existing fit items with the ones provided

    :param fit_parameters: the fit parameters as pandas data frame of list of dictionaries with keys:

           * 'name' str: the display name of the model element to map the column to.
           * 'lower': the lower bound of the parameter
           * 'upper': the upper bound of the parameter
           * 'start' (float, optional): the start value
           * 'cn' (str, optional): internal identifier

    :type fit_parameters: pandas.DataFrame or [{}]
    :param model: the model or None
    :type model: COPASI.CDataModel or None
    :return: None
    """
    # type: (pandas.DataFrame, COPASI.CDataModel)
    if model is None:
        model = model_io.get_current_model()

    if type(fit_parameters) is list:
        fit_parameters = pandas.DataFrame(data=fit_parameters)

    pe_task = model.getTask(TASK_PARAMETER_ESTIMATION)
    problem = pe_task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    while problem.getOptItemSize() > 0:
        problem.removeOptItem(0)

    for i in range(len(fit_parameters)):
        item = fit_parameters.iloc[i]
        cn = None
        name = None

        if 'cn' in item:
            cn = COPASI.CCommonName(item.cn)

        if 'name' in item:
            name = item['name']
            if not cn:
                obj = model.findObjectByDisplayName(name)
                if obj:
                    cn = obj.getCN()
                    if _get_role_for_reference(obj.getObjectName()) == COPASI.CExperiment.ignore:
                        cn = obj.getValueReference().getCN()

        if not cn:
            logging.warning('object {0} not found'.format(name))
            continue

        fit_item = problem.addFitItem(cn)
        assert (isinstance(fit_item, COPASI.CFitItem))
        if 'lower' in item:
            fit_item.setLowerBound(COPASI.CCommonName(str(item['lower'])))
        if 'upper' in item:
            fit_item.setUpperBound(COPASI.CCommonName(str(item['upper'])))
        if 'start' in item:
            fit_item.setStartValue(float(item['start']))


def _get_name_for_key(key):
    factory = COPASI.CRootContainer.getKeyFactory()
    obj = factory.get(key)
    if not obj:
        return ''
    return obj.getObjectName()


def _get_affected_experiments(optitem):
    # type: (COPASI.CCopasiParameterGroup) -> [str]
    result = []
    affected = optitem.getGroup(AFFECTED_EXPERIMENTS)
    assert (isinstance(affected, COPASI.CCopasiParameterGroup))
    for i in range(affected.size()):
        current = affected.getParameter(i)
        result.append(_get_name_for_key(current.getStringValue()))
    return result


def get_parameters_solution(model=None):
    """Returns the solution found for the fit parameters as data frame

    The resulting data frame will have the columns:

    * `name`: the name of the parameter
    * `lower`: the parameters lower bound
    * `upper`: the parameters upper bound
    * `sol`: the solution found in the last run (or NaN, if not run yet, or no solution found)
    * `affected`: the experiments this parameter applies to (or an empty list if it applies to all)

    :param model: the model to use, or None
    :type model: COPASI.CDataModel or None
    :return: data frame as described
    :rtype: pandas.DataFrame
    """
    if model is None:
        model = model_io.get_current_model()
    pe_task = model.getTask(TASK_PARAMETER_ESTIMATION)
    problem = pe_task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    solution = problem.getSolutionVariables()
    items = problem.getOptItemList()
    assert(solution.size() == len(items))
    data = []

    for i in range(solution.size()):
        item = items[i]
        sol = solution.get(i)
        obj = model.getObject(COPASI.CCommonName(item.getObjectCN())).toObject().getObjectParent()
        name = obj.getObjectDisplayName()
        data.append({
            'name': name,
            'lower': item.getLowerBound(),
            'upper': item.getUpperBound(),
            'sol': sol,
            'affected': _get_affected_experiments(item),
        })

    if not data:
        return pandas.DataFrame()

    return pandas.DataFrame(data=data).set_index('name')


def _get_role_for_reference(reference_name):
    role_map = {
        'Concentration': COPASI.CExperiment.dependent,
        'ParticleNumber': COPASI.CExperiment.dependent,
        'ParticleNumberRate': COPASI.CExperiment.dependent,
        'InitialConcentration': COPASI.CExperiment.independent,
        'InitialParticleNumber': COPASI.CExperiment.independent,
        'InitialValue': COPASI.CExperiment.independent,
        'InitialVolume': COPASI.CExperiment.independent,
        'Rate': COPASI.CExperiment.dependent,
        'Value': COPASI.CExperiment.dependent,
        'Volume': COPASI.CExperiment.dependent,
    }
    return role_map.get(reference_name, COPASI.CExperiment.ignore)


def add_experiment(name, data, **kwargs):
    """Adds a new experiment to the model.

    This method adds a new experiment file to the parameter estimation task. The provided
    data frame will be written into the current directory as `experiment_name.txt` unless a filename
    has been provided.

    The mapping between the columns and the model elements should be done by having the columns of the data
    frame be model element names in question. So for example `[A]` to note that the transient concentrations
    of a species `A` is to be mapped as dependent variable. or `[A]_0` to note that the initial concentration of
    a species `A` is to be mapped as independent variable.

    :param name: the name of the experiment
    :type name: str
    :param data: the data frame with the experimental data
    :type data: pandas.DataFrame
    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - | `file_name` (str): the file name to save the experimental data to (otherwise it will be name.txt)

    :return: the filename of the generated data file
    :rtype: str
    """
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))
    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    exp_set = problem.getExperimentSet()
    assert (isinstance(exp_set, COPASI.CExperimentSet))
    exp = exp_set.getExperiment(name)
    if exp is not None:
        logging.error('An experiment with the name {0} already exists'.format(name))
        return None

    # save data as tsv

    file_name = os.path.abspath(os.path.join(os.path.curdir, name + '.txt'))
    if 'file_name' in kwargs:
        file_name = kwargs['file_name']

    assert (isinstance(data, pd.DataFrame))
    data.to_csv(file_name, sep='\t', header=True, index=False)
    # create experiment

    exp = COPASI.CExperiment(model)
    exp = exp_set.addExperiment(exp)
    info = COPASI.CExperimentFileInfo(exp_set)
    info.setFileName(file_name)
    info.sync()
    exp.setObjectName(name)
    exp.setFileName(file_name)
    exp.setHeaderRow(1)
    exp.setFirstRow(1)
    exp.setLastRow(len(data)+1)

    columns = data.columns.to_list()
    if 'time' in [col.lower() for col in columns]:
        exp.setExperimentType(COPASI.CTaskEnum.Task_timeCourse)
    else:
        exp.setExperimentType(COPASI.CTaskEnum.Task_steadyState)

    obj_map = exp.getObjectMap()
    num_cols = len(columns)
    obj_map.setNumCols(num_cols)
    for i in range(num_cols):
        role = COPASI.CExperiment.ignore
        current = columns[i]
        if current.lower() == 'time':
            role = COPASI.CExperiment.time
        else:
            obj = model.findObjectByDisplayName(current)
            if obj is None:
                logging.warning("Can't find model element for {0}".format(current))
            else:
                role = _get_role_for_reference(obj.getObjectName())
                obj_map.setObjectCN(i, obj.getCN())
        obj_map.setRole(i, role)

    exp.calculateWeights()
    exp_set.compile(model.getModel().getMathContainer())

    return file_name


def run_parameter_estimation(**kwargs):
    """Runs the parameter estimation task as specified:

    The following are valid methods to be used for the parameter estimation task.

        Current Solution:

            * `Current Solution Statistics`,

        Global Methods:

            * `Random Search`,
            * `Simulated Annealing`,
            * `Differential Evolution`,
            * `Scatter Search`,
            * `Genetic Algorithm`,
            * `Evolutionary Programming`,
            * `Genetic Algorithm SR`,
            * `Evolution Strategy (SRES)`,
            * `Particle Swarm`,

        Local Methods:

            * `Levenberg - Marquardt`,
            * `Hooke & Jeeves`,
            * `Nelder - Mead`,
            * `Steepest Descent`,
            * `NL2SOL`,
            * `Praxis`,
            * `Truncated Newton`,

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - | `method` (str): one of the strings from above

    - | `randomize_start_values` (bool): if true, parameters will be randomized before starting otherwise the
      | parameters starting value will be taken.

    - | `calculate_statistics` (bool): if true, the statistics will be calculated at the end of the task

    - | `create_parametersets` (bool): if true, parameter sets will be created for all experiments

    - `use_initial_values` (bool): whether to use initial values

    - `scheduled` (bool): sets whether the task is scheduled or not

    - `update_model` (bool): sets whether the model should be updated, or reset to initial conditions.

    - `settings` (dict): a dictionary with settings to use, in the same format as the ones obtained from
                         :func:`.get_task_settings`

    :return: the solution for the fit parameters see :func:`get_get_parameters_solution`.
    :rtype: pandas.DataFrame
    """
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    if problem.getOptItemSize() == 0:
        logging.warning('No fit parameters defined, skipping parameter estimation run')
        return get_parameters_solution(model)

    if 'scheduled' in kwargs:
        task.setScheduled(kwargs['scheduled'])

    if 'update_model' in kwargs:
        task.setUpdateModel(kwargs['update_model'])

    old_create_parameter_sets = problem.getCreateParameterSets()
    # old_calculate_statistics = problem.getCalculateStatistics()
    # old_randomize_start_values = problem.getRandomizeStartValues()

    problem.setCreateParameterSets(True)

    if 'method' in kwargs:
        method = kwargs['method']
        if isinstance(method, int):
            task.setMethodType(method)
        else:
            task.setMethodType(COPASI.CCopasiMethod_TypeNameToEnum(method))

    if 'randomize_start_values' in kwargs:
        problem.setRandomizeStartValues(bool(kwargs['randomize_start_values']))

    if 'calculate_statistics' in kwargs:
        problem.setCalculateStatistics(bool(kwargs['calculate_statistics']))

    if 'create_parametersets' in kwargs:
        problem.setCreateParameterSets(bool(kwargs['create_parametersets']))

    use_initial_values = kwargs.get('use_initial_values', True)

    if 'settings' in kwargs:
        basico.set_task_settings(task, kwargs['settings'])

    result = task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)
    if not result:
        logging.error("Error while initializing the simulation: " +
                      COPASI.CCopasiMessage.getLastMessage().getText())
    else:
        result = task.processRaw(use_initial_values)
        if not result:
            logging.error("Error while running the simulation: " +
                          COPASI.CCopasiMessage.getLastMessage().getText())

    problem.setCreateParameterSets(old_create_parameter_sets)

    return get_parameters_solution(model)


def get_simulation_results(values_only=False, **kwargs):
    """Runs the current solution statistics and returns result of simulation and experimental data

    :param values_only: if true, only time points at the measurements will be returned
    :type values_only: bool

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - | `solution`: a solution data frame to use, if not specified a current solution
                    statistic will be computed

    :return: tuple of lists of experiment data, and a list of simulation data
    :rtype: ([pandas.DataFrame],[pandas.DataFrame])
    """
    import basico
    dm = kwargs.get('model', model_io.get_current_model())

    task = dm.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    result = []
    num_experiments = experiments.getExperimentCount()
    if num_experiments == 0:
        return result

    if 'solution' in kwargs:
        solution = kwargs['solution']
    else:
        solution = run_parameter_estimation(method='Current Solution Statistics')

    model = dm.getModel()

    exp_data = []
    sim_data = []

    for i in range(num_experiments):
        change_set = COPASI.DataObjectSet()
        experiment = experiments.getExperiment(i)
        exp_name = experiment.getObjectName()
        df = get_data_from_experiment(experiment, rename_headers=True)
        mapping = get_experiment_mapping(experiment)

        # set independent values for that experiment
        independent = mapping[mapping.type == 'independent']
        num_independent = independent.shape[0]
        for j in range(num_independent):
            name = independent.iloc[j].mapping
            cn = independent.iloc[j].cn
            value = df.iloc[0][name]
            obj = dm.getObject(COPASI.CCommonName(cn))

            if obj is None:     # not found skip
                continue

            if obj.getObjectName() == 'InitialConcentration':
                obj.getObjectParent().setInitialConcentration(value)
            else:
                obj.getObjectParent().setInitialValue(value)

            change_set.append(obj)
            logging.debug('set independent "{0}" to "{1}"'.format(cn, value))

        params = get_fit_parameters(dm)
        for j in range(solution.shape[0]):
            name = solution.iloc[j].name
            value = solution.iloc[j].sol
            cn = params.iloc[j].cn
            if np.isnan(value):
                continue
            affected = solution.iloc[j].affected
            if any(affected) and exp_name not in affected:
                continue

            obj = dm.getObject(COPASI.CCommonName(cn))

            if obj is None:  # not found skip
                continue

            if type(obj) is COPASI.CDataObject:

                if obj.getObjectName() == 'InitialConcentration':
                    obj.getObjectParent().setInitialConcentration(value)
                elif type(obj.getObjectParent()) is COPASI.CCopasiParameter:
                    obj.setDblValue(value)
                    model.updateInitialValues(obj)
                else:
                    obj.getObjectParent().setInitialValue(value)

                change_set.append(obj)
                logging.debug('set solution value "{0}" to "{1}"'.format(cn, value))
            else:
                basico.set_reaction_parameters(name, value=value)
                logging.debug('set reaction parameter "{0}" to "{1}"'.format(name, value))

        if change_set.size() > 0:
            model.updateInitialValues(change_set)

        duration = df.iloc[-1].Time
        if values_only:
            data = basico.run_time_course(values=df.Time.to_list(), start_time=df.iloc[0].Time)
        else:
            data = basico.run_time_course(duration=duration)

        exp_data.append(df)
        sim_data.append(data)

    return exp_data, sim_data


def plot_per_experiment(**kwargs):
    """
    This function creates one figure per experiment defined, with plots of all dependent variables
    and their fit in it.

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: array of tuples (fig, ax) for the figures created
    """
    dm = kwargs.get('model', model_io.get_current_model())

    task = dm.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    result = []
    num_experiments = experiments.getExperimentCount()
    if num_experiments == 0:
        return result

    exp_data, sim_data = get_simulation_results(**kwargs)

    for i in range(num_experiments):
        fig, ax = plt.subplots()
        cycler = plt.cycler("color", plt.cm.tab20c.colors)()
        experiment = experiments.getExperiment(i)
        exp_name = experiment.getObjectName()
        mapping = get_experiment_mapping(experiment)
        ax.set_title(exp_name)

        # set independent values for that experiment
        dependent = mapping[mapping.type == 'dependent']

        num_dependent = dependent.shape[0]
        for j in range(num_dependent):
            nextval = next(cycler)['color']
            name = dependent.iloc[j].mapping
            if name not in sim_data[i].columns:
                name = name[1:-1]
            sim_data[i].reset_index().plot(x='Time', y=name,
                                           label="{0} Fit".format(name), ax=ax, color=nextval)
            name = dependent.iloc[j].mapping
            exp_data[i].plot.scatter(x='Time', y=name, ax=ax, color=nextval,
                                 label='{0} Measured'.format(name))
        result.append((fig, ax))

    return result


def plot_per_dependent_variable(**kwargs):
    """
    This function creates a figure for each dependent variable, with traces for all experiments.

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: array of tuples (fig, ax) for each figure created
    """
    dm = kwargs.get('model', model_io.get_current_model())

    task = dm.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    result = []
    num_experiments = experiments.getExperimentCount()
    if num_experiments == 0:
        return result

    exp_data, sim_data = get_simulation_results(**kwargs)

    dependent_variables = {}

    for i in range(num_experiments):
        experiment = experiments.getExperiment(i)
        mapping = get_experiment_mapping(experiment)

        # set independent values for that experiment
        dependent = mapping[mapping.type == 'dependent']
        num_dependent = dependent.shape[0]
        for j in range(num_dependent):
            name = dependent.iloc[j].mapping
            if name not in dependent_variables:
                dependent_variables[name] = []
            dependent_variables[name].append(i)

    for dependent in dependent_variables:
        fig, ax = plt.subplots()
        cycler = plt.cycler("color", plt.cm.tab20c.colors)()
        ax.set_title(dependent)
        experiment_indices = dependent_variables[dependent]

        for i in experiment_indices:
            experiment = experiments.getExperiment(i)
            exp_name = experiment.getObjectName()
            nextval = next(cycler)['color']
            name = dependent
            if name not in sim_data[i].columns:
                name = name[1:-1]

            sim_data[i].reset_index().plot(x='Time', y=name,
                                           label="{0} Fit".format(exp_name), ax=ax, color=nextval)
            exp_data[i].plot.scatter(x='Time', y=dependent, ax=ax, color=nextval,
                                     label='{0} Measured'.format(exp_name))
        result.append((fig, ax))

    return result


def prune_simulation_results(simulation_results):
    """Removes all columns & time points from the simulation set, that are not available in the measurement set

    :param simulation_results: the simulation result as obtained by get_simulation_results

    :return:
    """
    assert len(simulation_results[0]) == len(simulation_results[1])
    for i in range(len(simulation_results[0])):
        s_df = simulation_results[1][i].reset_index()
        e_df = simulation_results[0][i]
        s_df = s_df[s_df.Time.isin(e_df.Time.to_list())]
        s_df = s_df.reset_index()
        common_cols = [c for c in e_df.columns.to_list() if c in s_df.columns.to_list()]
        s_df = s_df[common_cols]
        simulation_results[1][i] = s_df

    return simulation_results
