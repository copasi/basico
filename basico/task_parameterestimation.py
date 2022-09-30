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
import yaml

import basico
from basico.callbacks import get_default_handler

AFFECTED_EXPERIMENTS = 'Affected Experiments'
TASK_PARAMETER_ESTIMATION = 'Parameter Estimation'


class PE:
    """Constants for Parameter estimation method names

    Convert between method names to enums

        >>> T.from_enum(0)
        'Current Solution Statistics'

        >>> T.to_enum('Current Solution Statistics')
        17


    """
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

    _names = None
    _values = None

    @classmethod
    def _create_name_map(cls):
        return {
            COPASI.CTaskEnum.Method_Statistics: PE.CURRENT_SOLUTION,
            COPASI.CTaskEnum.Method_RandomSearch: PE.RANDOM_SEARCH,
            COPASI.CTaskEnum.Method_SimulatedAnnealing: PE.SIMULATED_ANNEALING,
            COPASI.CTaskEnum.Method_DifferentialEvolution: PE.DIFFERENTIAL_EVOLUTION,
            COPASI.CTaskEnum.Method_ScatterSearch: PE.SCATTER_SEARCH,
            COPASI.CTaskEnum.Method_GeneticAlgorithm: PE.GENETIC_ALGORITHM,
            COPASI.CTaskEnum.Method_GeneticAlgorithmSR: PE.GENETIC_ALGORITHM_SR,
            COPASI.CTaskEnum.Method_SRES: PE.EVOLUTIONARY_STRATEGY_SRES,
            COPASI.CTaskEnum.Method_ParticleSwarm: PE.PARTICLE_SWARM,
            COPASI.CTaskEnum.Method_LevenbergMarquardt: PE.LEVENBERG_MARQUARDT,
            COPASI.CTaskEnum.Method_HookeJeeves: PE.HOOKE_JEEVES,
            COPASI.CTaskEnum.Method_NelderMead: PE.NELDER_MEAD,
            COPASI.CTaskEnum.Method_SteepestDescent: PE.STEEPEST_DESCENT,
            COPASI.CTaskEnum.Method_NL2SOL: PE.NL2SOL,
            COPASI.CTaskEnum.Method_Praxis: PE.PRAXIS,
            COPASI.CTaskEnum.Method_TruncatedNewton: PE.TRUNCATED_NEWTON,
        }

    @classmethod
    def _create_value_map(cls):
        return {
            PE.CURRENT_SOLUTION: COPASI.CTaskEnum.Method_Statistics,
            PE.RANDOM_SEARCH: COPASI.CTaskEnum.Method_RandomSearch,
            PE.SIMULATED_ANNEALING: COPASI.CTaskEnum.Method_SimulatedAnnealing,
            PE.DIFFERENTIAL_EVOLUTION: COPASI.CTaskEnum.Method_DifferentialEvolution,
            PE.SCATTER_SEARCH: COPASI.CTaskEnum.Method_ScatterSearch,
            PE.GENETIC_ALGORITHM: COPASI.CTaskEnum.Method_GeneticAlgorithm,
            PE.GENETIC_ALGORITHM_SR: COPASI.CTaskEnum.Method_GeneticAlgorithmSR,
            PE.EVOLUTIONARY_STRATEGY_SRES: COPASI.CTaskEnum.Method_SRES,
            PE.PARTICLE_SWARM: COPASI.CTaskEnum.Method_ParticleSwarm,
            PE.LEVENBERG_MARQUARDT: COPASI.CTaskEnum.Method_LevenbergMarquardt,
            PE.HOOKE_JEEVES: COPASI.CTaskEnum.Method_HookeJeeves,
            PE.NELDER_MEAD: COPASI.CTaskEnum.Method_NelderMead,
            PE.STEEPEST_DESCENT: COPASI.CTaskEnum.Method_SteepestDescent,
            PE.NL2SOL: COPASI.CTaskEnum.Method_NL2SOL,
            PE.PRAXIS: COPASI.CTaskEnum.Method_Praxis,
            PE.TRUNCATED_NEWTON: COPASI.CTaskEnum.Method_TruncatedNewton,
        }

    @classmethod
    def from_enum(cls, int_value):
        if cls._names is None:
            cls._names = cls._create_name_map()

        return cls._names.get(int_value, PE.CURRENT_SOLUTION)

    @classmethod
    def to_enum(cls, value):
        if cls._values is None:
            cls._values = cls._create_value_map()

        return cls._values.get(value, COPASI.CTaskEnum.Method_Statistics)

    @classmethod
    def all_method_names(cls):
        if cls._names is None:
            cls._names = cls._create_name_map()

        return list(cls._names.values())


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
    model = model_io.get_model_from_dict_or_default(kwargs)
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
    model = model_io.get_model_from_dict_or_default(kwargs)
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
    model = model_io.get_model_from_dict_or_default(kwargs)
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
    model = model_io.get_model_from_dict_or_default(kwargs)
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
    return names.get(role, 'ignored')


def _role_to_int(role):
    values = {
        'time': COPASI.CExperiment.time,
        'ignored': COPASI.CExperiment.ignore,
        'independent': COPASI.CExperiment.independent,
        'dependent': COPASI.CExperiment.dependent,
    }
    return values.get(role, COPASI.CExperiment.ignore)


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
        model = model_io.get_model_from_dict_or_default(kwargs)
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


def _get_experiment_mapping_dict(experiment, **kwargs):
    """ Returns the mapping of the given experiment

    :param experiment: copasi experiment, name or index
    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: list of dictionaries with the mapping for the experiment
    :rtype: [{}]
    """

    experiment = get_experiment(experiment, **kwargs)
    experiment.readColumnNames()
    names = experiment.getColumnNames()
    obj_map = experiment.getObjectMap()
    assert (isinstance(obj_map, COPASI.CExperimentObjectMap))
    rows = []

    last = obj_map.getLastColumn() + 1
    size = obj_map.size()
    max_col = min(len(names),max(last, size))
    for i in range(max_col):
        role = obj_map.getRole(i)
        cn = obj_map.getObjectCN(i)
        obj = ''
        if cn:
            obj = experiment.getObjectDataModel().getObject(COPASI.CCommonName(cn))
            if obj:
                obj = obj.getObjectDisplayName()

        current = {
            'column': i,
            'type': _role_to_string(role),
            'mapping': obj,
            'cn': cn,
            'column_name': names[i],
        }

        if role == COPASI.CExperiment.dependent:
            scale = obj_map.getScale(i)
            default_scale = obj_map.getDefaultScale(i)
            if scale != default_scale and not np.isnan(scale):
                current['weight'] = scale

        rows.append(current)

    return rows

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
    rows = _get_experiment_mapping_dict(experiment)
    return pandas.DataFrame(data=rows).set_index('column')


def _get_experiment_file(experiment):
    file_name_only = experiment.getFileNameOnly()
    model = experiment.getObjectDataModel()
    directory = os.path.dirname(model.getFileName())

    if not file_name_only:
        raise ValueError('Invalid Experiment, no filename specified for ' + experiment.getObjectName())

    full_path = os.path.join(directory, file_name_only)
    if os.path.isfile(full_path):
        return full_path

    if os.path.isfile(file_name_only):
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
    header_row = experiment.getHeaderRow()
    original_headers = None
    num_lines = 0
    separator = experiment.getSeparator()
    with open(experiment_file, encoding='utf-8') as f:
        for line in f:
            num_lines +=1
            if num_lines == header_row:
                original_headers = line.strip().split(separator)
                original_headers = dict(enumerate(original_headers))
    have_headers = header_row < num_lines
    skip_idx = [x-1 for x in range(1, num_lines+1) if
                not (experiment.getFirstRow() <= x <= experiment.getLastRow())]

    if 'rename_headers' in kwargs:
        rename_headers = kwargs['rename_headers']
    else:
        rename_headers = True

    if (have_headers and rename_headers) or original_headers != None:
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
                count += 1

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
                             sep=separator,
                             header=None,
                             skiprows=skip_idx)
    elif original_headers != None and not rename_headers:
        df = pandas.read_csv(experiment_file,
                             sep=separator,
                             header=None,
                             skiprows=skip_idx)
        df.rename(columns=original_headers, inplace=True)
        return df
    else:
        df = pandas.read_csv(experiment_file,
                             sep=separator,
                             skiprows=skip_idx)

    if not rename_headers:
        return df

    all_columns = list(df.columns)
    for i in range(obj_map.size(), len(all_columns)):
        # drop additional columns not mapped
        drop_cols.append(all_columns[i])

    if any(drop_cols):
        df.drop(drop_cols, axis=1, inplace=True, errors='ignore')

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
        df = get_data_from_experiment(experiment, rename_headers=True, model=model)
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
                    'upper': default_ub,
                    'start': mv.getInitialValue()
                })

    if include_local:

        from . import model_info
        local_params = model_info.get_reaction_parameters().reset_index()
        if 'name' in local_params:
            for name, local, value in zip(local_params['name'], local_params['type'], local_params['value']):

                if local == 'local':
                    result.append({
                        'name': name,
                        'lower': default_lb,
                        'upper': default_ub,
                        'start': value
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
           * 'affected' (list[str], optional): a list of affected experiment names.
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

    experiment_keys = _get_experiment_keys(model=model)
    experiment_names = get_experiment_names(model=model)

    for i in range(len(fit_parameters)):
        item = fit_parameters.iloc[i]
        cn = None
        name = None

        if 'cn' in item:
            cn = COPASI.CCommonName(item.cn)

        elif 'name' in item:
            name = item['name']
            if not cn:
                obj = basico.model_info._get_object(name, initial=True, model=model)
                if obj:
                    cn = obj.getCN()

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
        if 'affected' in item:
            affected = item['affected']
            if type(affected) is str:
                affected = [affected]
            for name in affected:
                if not name:
                    continue

                if name not in experiment_names:
                    logging.warning('Invalid affected experiment name {0}'.format(name))
                    continue

                index = experiment_names.index(name)
                fit_item.addExperiment(experiment_keys[index])

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
        obj = model.getObject(COPASI.CCommonName(item.getObjectCN()))
        if obj is None:
            logging.debug('fit item not in model, cn: {0}'.format(item.getObjectCN()))
            continue
        obj = obj.toObject().getObjectParent()
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
    model = model_io.get_model_from_dict_or_default(kwargs)
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
        file_name = os.path.abspath(kwargs['file_name'])

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
                assert(isinstance(obj, COPASI.CDataObject))
                if obj.getObjectType() != 'Reference':
                    try:
                        obj = obj.getValueReference()
                    except AttributeError:
                        logging.warning("Cannot map the element {0}".format(current))
                role = _get_role_for_reference(obj.getObjectName())
                obj_map.setObjectCN(i, str(obj.getCN()))
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

    - `write_report` (bool): overrides the writing of a report file of filename is specified. (defaults to True)

    :return: the solution for the fit parameters see :func:`get_parameters_solution`.
    :rtype: pandas.DataFrame
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
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

    write_report = kwargs.get('write_report', True)
    report_name = task.getReport().getTarget()
    if not write_report:
        task.getReport().setTarget('')

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

    task.setCallBack(get_default_handler())
    result = task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)
    if not result:
        logging.error("Error while initializing parameter estimation: " +
                      COPASI.CCopasiMessage.getLastMessage().getText())
    else:
        result = task.processRaw(use_initial_values)
        if not result:
            logging.error("Error while running parameter estimation: " +
                          COPASI.CCopasiMessage.getLastMessage().getText())
    task.setCallBack(None)
    problem.setCreateParameterSets(old_create_parameter_sets)
    if not write_report:
        task.getReport().setTarget(report_name)

    return get_parameters_solution(model)


def get_simulation_results(values_only=False, update_parameters=True, **kwargs):
    """Runs the current solution statistics and returns result of simulation and experimental data

    :param values_only: if true, only time points at the measurements will be returned
    :type values_only: bool

    :param update_parameters: if set true, the model will be updated with the parameters
           found from the solution. (defaults to True)
    :type update_parameters: bool

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    - | `solution`: a solution data frame to use, if not specified a current solution
                    statistic will be computed

    :return: tuple of lists of experiment data, and a list of simulation data
    :rtype: ([pandas.DataFrame],[pandas.DataFrame])
    """
    import basico
    dm = model_io.get_model_from_dict_or_default(kwargs)

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

    if update_parameters:
        if 'solution' in kwargs:
            solution = kwargs['solution']
            if type(solution) is dict or type(solution) is list:
                solution = pd.DataFrame(data=solution)
        else:
            solution = run_parameter_estimation(method='Current Solution Statistics', write_report=False)

    model = dm.getModel()

    exp_data = []
    sim_data = []

    for i in range(num_experiments):
        experiment = experiments.getExperiment(i)
        exp_name = experiment.getObjectName()
        df = get_data_from_experiment(experiment, rename_headers=True)
        columns = df.columns.to_list()
        mapping = get_experiment_mapping(experiment)

        # set independent values for that experiment
        independent = mapping[mapping.type == 'independent']
        num_independent = independent.shape[0]
        is_steady_state = experiment.getExperimentType() == COPASI.CTaskEnum.Task_steadyState
        num_independent_points = df.shape[0]
        steady_state_task = dm.getTask(basico.T.STEADY_STATE)
        container = dm.getModel().getMathContainer()
        #_apply_nth_change(0, columns, df, dm, exp_name, independent, model, num_independent)
        if update_parameters:
            _update_fit_parameters_from(dm, solution, exp_name)

        container.fetchInitialState()
        container.updateInitialValues(COPASI.CCore.Framework_ParticleNumbers)
        container.applyInitialValues()
        container.updateSimulatedValues(False)
        container.updateTransientDataValues()
        experiment.updateModelWithIndependentData(0)
        container.pushAllTransientValues()
        container.pushInitialState()

        if is_steady_state:
            # run steady state
            #basico.run_steadystate(model=dm)
            steady_state_task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)
            steady_state_task.processRaw(True)
            data = basico.model_info._collect_data(cns=mapping[mapping.type == 'dependent']['cn'].to_list()).transpose()
            
            for j in range(1, num_independent_points):
                container.applyInitialValues()
                container.updateSimulatedValues(False);
                container.updateTransientDataValues();
                experiment.updateModelWithIndependentData(j)
                container.pushAllTransientValues();
                container.pushInitialState();
                #_apply_nth_change(j, columns, df, dm, exp_name, independent, model, num_independent)
                if update_parameters:
                    _update_fit_parameters_from(dm, solution, exp_name)
                steady_state_task.processRaw(True)
                #basico.run_steadystate(model=dm)
                new_row = basico.model_info._collect_data(
                    cns=mapping[mapping.type == 'dependent']['cn'].to_list()).transpose()
                data = pd.concat([data, new_row], ignore_index=True)

        else:
            # run time course (getting only the data from the experiment)
            duration = df.iloc[-1].Time
            cols = ['Time'] + mapping[mapping.type == 'dependent']['cn'].to_list()
            if values_only:
                data = basico.run_time_course_with_output(output_selection=cols, values=df.Time.to_list(), start_time=df.iloc[0].Time)
            else:
                data = basico.run_time_course_with_output(output_selection=cols,duration=duration)

        exp_data.append(df)
        sim_data.append(data)

    return exp_data, sim_data


def _apply_nth_change(change, columns, df, dm, exp_name, independent, model, num_independent):
    change_set = COPASI.DataObjectSet()
    for j in range(num_independent):
        name = independent.iloc[j].mapping
        cn = independent.iloc[j].cn

        if name not in columns:
            # independent value is not found in df
            continue

        value = df.iloc[change][name]
        obj = dm.getObject(COPASI.CCommonName(cn))

        if obj is None:  # not found skip
            logging.debug('independent object not found for cn: {0}'.format(cn))
            continue

        if obj.getObjectName() == 'InitialConcentration':
            obj.getObjectParent().setInitialConcentration(value)
        else:
            obj.getObjectParent().setInitialValue(value)

        change_set.append(obj)
        logging.debug('set independent "{0}" to "{1}"'.format(cn, value))
    if change_set.size() > 0:
        model.updateInitialValues(change_set)

def _get_value_from_bound(bound):
    """

    :param bound: the bound for the fit item (a float value as string, or name of another reference)
    :return: the value of the bound
    :rtype: float
    """
    try:
        value = float(bound)
    except ValueError:
        value = basico.get_value(bound)
    return value

def _update_fit_parameters_from(dm, solution, exp_name=''):
    """ Utility function that updates the models fit parameters for the given solution

    :param dm: the current model
    :param solution: the computed solution dataframe
    :param exp_name: the affected experiment or empty for all
    :return: None
    """
    change_set = COPASI.DataObjectSet()
    model = dm.getModel()
    params = get_fit_parameters(dm)
    for j in range(solution.shape[0]):
        name = solution.iloc[j].name
        value = solution.iloc[j].sol
        lower= _get_value_from_bound(solution.iloc[j].lower)
        upper = _get_value_from_bound(solution.iloc[j].upper)

        cn = params.iloc[j].cn
        if np.isnan(value):
            continue
        affected = solution.iloc[j].affected
        if any(affected) and exp_name not in affected:
            continue

        # ensure that values is within the constraint
        if value < lower:
            value = lower
        if value > upper:
            value = upper

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


def plot_per_experiment(**kwargs):
    """
    This function creates one figure per experiment defined, with plots of all dependent variables
    and their fit in it.

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: array of tuples (fig, ax) for the figures created
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

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
    dm = model_io.get_model_from_dict_or_default(kwargs)

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


def get_fit_statistic(include_parameters=False, include_experiments=False, include_fitted=False, **kwargs):
    """Return information about the last fit.

    :param include_parameters: whether to include information about the parameters in a result entry
                               with key `parameters`
    :type include_parameters: bool

    :param include_experiments: whether to include information about the experiments in a result entry
                               with key `experiments`
    :type include_experiments: bool

    :param include_fitted: whether to include information about the fitted values in a result entry
                               with key `fitted`
    :type include_fitted: bool

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: dictionary with the fit statistic
    :rtype: {}
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

    task = dm.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    result = {
        'obj': problem.getSolutionValue(),
        'rms': problem.getRMS(),
        'sd': problem.getStdDeviation(),
        'f_evals': problem.getFunctionEvaluations(),
        'failed_evals_exception': problem.getFailedEvaluationsExc(),
        'failed_evals_nan': problem.getFailedEvaluationsNaN(),
        'cpu_time': problem.getExecutionTime(),
        'data_points': experiments.getDataPointCount(),
        'valid_data_points': experiments.getValidValueCount(),
    }
    result['evals_per_sec'] = result['cpu_time'] / result['f_evals']

    items = problem.getOptItemList()
    sol = problem.getSolutionVariables()
    grad = problem.getVariableGradients()
    std = problem.getVariableStdDeviations()

    if include_parameters:
        parameters = []
        for i in range(problem.getOptItemSize()):
            current = problem.getOptItem(i)
            assert (isinstance(current, COPASI.COptItem))
            obj = dm.getObject(current.getObjectCN())
            name = obj.getObjectDisplayName() if obj is not None else 'Not Found'
            parameters.append({
                'name':  name,
                'lower': current.getLowerBound(),
                'start': current.getLastStartValue(),
                'value': sol.get(i),
                'upper': current.getUpperBound(),
                'std_dev': std.get(i),
                'coeff_of_variation': abs(100 * std.get(i) / sol.get(i)),
                'gradient': grad.get(i)
            })
        result['parameters'] = parameters

    if include_experiments:
        if COPASI.CVersion.VERSION.getVersionDevel() < 263:
            raise ValueError("Newer COPASI version required to return experiment statistic")

        experiment_stats = []
        for i in range(experiments.getExperimentCount()):
            exp = experiments.getExperiment(i)

            validValueCount = exp.getValidValueCount()
            totalValueCount = exp.getTotalValueCount()
            print(f'  datapoints: {validValueCount} of {totalValueCount}')

            item = {
                'name': exp.getObjectName(),
                'valid_points': validValueCount,
                'total_points': totalValueCount,
                'obj': exp.getObjectiveValue(),
                'rms': exp.getRMS(),
                'error_mean': exp.getErrorMean(),
                'error_mean_sd': exp.getErrorMeanSD(),
                'dependent_data': []
            }

            objects = experiments.getDependentObjects()

            for j in range(objects.size()):
                obj = experiments.getDependentObjects().get(j)
                count = exp.getColumnValidValueCount(obj)
                if not count:
                    continue
                item['dependent_data'].append(
                    {
                        'name': obj.getObjectDisplayName(),
                        'data_points': count,
                        'obj': exp.getObjectiveValue(obj),
                        'rms': exp.getRMS(obj),
                        'error_mean': exp.getErrorSum(obj) / count,
                    }
                )
            experiment_stats.append(item)

        result['experiments'] = experiment_stats

    if include_fitted:
        dependent = experiments.getDependentObjects()
        num_dependent = dependent.size()
        if problem.getFunctionEvaluations() == 0:
            num_dependent = 0
        values = []
        for i in range(num_dependent):
            current = dependent.get(i)
            name = current.getObjectDisplayName() if current is not None else 'Not Found'
            values.append({
                'name': name,
                'data_points': experiments.getDependentDataCount().get(i),
                'obj': experiments.getDependentObjectiveValues().get(i),
                'rms': experiments.getDependentRMS().get(i),
                'error_mean': experiments.getDependentErrorMean().get(i),
                'error_mean_sd': experiments.getDependentErrorMeanSD().get(i)
            })

        result['variables'] = values

    return result


def remove_experiments(**kwargs):
    """Removes all experiments from the model

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

    task = dm.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    experiments = problem.getExperimentSet()
    assert (isinstance(experiments, COPASI.CExperimentSet))

    for _ in range(experiments.size()):
        experiments.removeExperiment(0)


def remove_fit_parameters(**kwargs):
    """Removes all fit items

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

    pe_task = dm.getTask(TASK_PARAMETER_ESTIMATION)
    problem = pe_task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    while problem.getOptItemSize() > 0:
        problem.removeOptItem(0)

def _weight_method_to_string(weight_method):
    """ Convenience function converting a weight method to string

    :param weight_method: the weight method
    :type weight_method: int
    :return: name of the weight method
    :rtype: str
    """
    weight_map = {
        COPASI.CExperiment.MEAN: 'Mean',
        COPASI.CExperiment.MEAN_SQUARE: 'Mean Square',
        COPASI.CExperiment.SD: 'Standard Deviation',
        COPASI.CExperiment.VALUE_SCALING: 'Value Scaling'
    }
    return weight_map.get(weight_method, 'Mean Square')

def _weight_method_to_int(weight_method):
    """ Convenience function converting a weight method to int

    :param weight_method: the weight method
    :type weight_method: str
    :return: type of the weight method
    :rtype: int
    """
    weight_map = {
        'Mean': COPASI.CExperiment.MEAN,
        'Mean Square': COPASI.CExperiment.MEAN_SQUARE,
        'Standard Deviation': COPASI.CExperiment.SD,
        'Value Scaling': COPASI.CExperiment.VALUE_SCALING
    }
    return weight_map.get(weight_method, COPASI.CExperiment.MEAN_SQUARE)


def get_experiment_dict(experiment, **kwargs):
    """ Returns all information about the experiment as dictionary

    :param experiment: copasi experiment, experiment name or index
    :param kwargs: optional arguments

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: all information about the experiment as dictionary
    """
    experiment = get_experiment(experiment, **kwargs)

    filename = _get_experiment_file(experiment)

    result = {
        'name': experiment.getObjectName(),
        'filename': filename,
        'type': basico.T.STEADY_STATE if experiment.getExperimentType() == COPASI.CTaskEnum.Task_steadyState else
                basico.T.TIME_COURSE,
        'separator': experiment.getSeparator(),
        'first_row': experiment.getFirstRow(),
        'last_row': experiment.getLastRow(),
        'weight_method': _weight_method_to_string(experiment.getWeightMethod()),
        'normalize_per_experiment': experiment.getNormalizeWeightsPerExperiment()
    }

    if experiment.getHeaderRow() < experiment.getLastRow():
        result['header_row'] = experiment.getHeaderRow()

    mapping = _get_experiment_mapping_dict(experiment, **kwargs)

    # rename / clear up things
    for entry in mapping:
        if 'column_name' in entry:
            if entry['column_name']:
                entry['column'] = entry['column_name']
            del entry['column_name']
        if entry['cn'] == '':
            del entry['cn']
        if entry['mapping'] == '':
            del entry['mapping']

        if 'mapping' in entry:
            entry['object'] = entry['mapping']
            del entry['mapping']

    result['mapping'] = mapping

    return result


def save_experiments_to_dict(**kwargs):
    """Returns a list of dictionaries with the parameter estimation experiments

    :param kwargs: optional arguments

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: the parameter estimation experimetns as list of dictionary
    :rtype: [{}]
    """
    experiments = []
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    exp_set = problem.getExperimentSet()

    for i in range (exp_set.size()):
        experiments.append(get_experiment_dict(exp_set.getExperiment(i)))

    return experiments

def save_experiments_to_yaml(filename=None, **kwargs):
    """Saves the experiment to yaml

    :param filename: optional filename to write to
    :param kwargs: optional arguments

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: the yaml string
    """
    experiments = save_experiments_to_dict(**kwargs)
    yaml_str = yaml.safe_dump(experiments, indent=2, sort_keys=False, default_flow_style=False )
    if not filename:
         return yaml_str

    with open(filename, 'w', encoding='utf-8') as out_file:
        out_file.write(yaml_str)

    return yaml_str


def load_experiments_from_yaml(experiment_description, **kwargs):
    """ Loads all experiments from the specified experiment description

    All existing experiments will be replaced with the ones from the specified file.

    :param experiment_description: filename or yamlstring
    :param kwargs: optional arguments

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return:
    """
        
    if os.path.exists(experiment_description):
        with open(experiment_description, 'r') as stream:
            experiments = yaml.safe_load(stream)
    else:
        experiments = yaml.safe_load(experiment_description)

    return load_experiments_from_dict(experiments, **kwargs)

def load_experiments_from_dict(experiments, **kwargs):
    """ Loads all experiments from the specified experiment description

    All existing experiments will be replaced with the ones from the specified file.

    :param experiments: list of experiment dictionaries
    :param kwargs: optional arguments

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    # remove existing experiments
    remove_experiments(**kwargs)

    if type(experiments) is dict:
        experiments = [experiments]

    for exp_dict in experiments:
        add_experiment_from_dict(exp_dict,**kwargs)

def _get_nth_line_from_file(filename, n, max_line=None):
    with open(filename, 'r') as stream:
        for i, line in enumerate(stream):
            if i + 1 == n:
                return line.strip()
            if max_line and i == max_line:
                break
    return None


def _get_first_column(mappings, column):
    for entry in mappings:
        if entry['column'] == column:
            return entry
    return None

def add_experiment_from_dict(exp_dict, **kwargs):
    """ Adds an experiment from dictionary

    :param exp_dict:
    :return:
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    exp_set = problem.getExperimentSet()
    assert (isinstance(exp_set, COPASI.CExperimentSet))

    experiment = COPASI.CExperiment(model, exp_dict['name'])
    experiment.setFirstRow(exp_dict['first_row'])
    experiment.setLastRow(exp_dict['last_row'])
    if 'header_row' in exp_dict:
        experiment.setHeaderRow(exp_dict['header_row'])
    experiment.setFileName(exp_dict['filename'])
    experiment.setNormalizeWeightsPerExperiment(exp_dict['normalize_per_experiment'])
    experiment.setExperimentType(basico.T.to_enum(exp_dict['type']))
    experiment.setSeparator(exp_dict['separator'])
    experiment.setWeightMethod(_weight_method_to_int(exp_dict['weight_method']))
    columnNumber = experiment.guessColumnNumber()
    experiment.setNumColumns(columnNumber)

    obj_map = experiment.getObjectMap()
    obj_map.setNumCols(columnNumber)

    ## this should not be crashing (needs new COPASI release)
    #
    # experiment.readColumnNames()
    # names = experiment.getColumnNames()
    #
    ## instead we use:

    names = None
    if  'header_row' in exp_dict:
        names = _get_nth_line_from_file(exp_dict['filename'], int(exp_dict['header_row']), int(exp_dict['last_row']))
    if names is not None:
        names = names.split(exp_dict['separator'])
    else: 
        names = [i for i in range(columnNumber)]

    max_col = min(len(names), len(exp_dict['mapping']))
    obj_map.setNumCols(max_col)
    experiment.setNumColumns(max_col)
    for i in range(max_col):
        mapping = _get_first_column(exp_dict['mapping'], names[i])
        if mapping is None:
            obj_map.setRole(i, COPASI.CExperiment.ignore)
            continue
        role = _role_to_int(mapping['type'])
        obj_map.setRole(i, role)
        need_initial = True if mapping['type'] == 'independent' else False
        cn = mapping['cn'] if 'cn' in mapping else \
                basico.model_info.get_cn(mapping['object'], initial=need_initial ) if 'object' in mapping else \
                None
        if cn is not None:
            obj_map.setObjectCN(i, str(cn))
        if role == COPASI.CExperiment.dependent and 'weight' in mapping:
            obj_map.setScale(i, float(mapping['weight']))

    exp_set.addExperiment(experiment)
    #experiment.compile(model.getModel().getMathContainer())
    #experiment.calculateWeights()
    #experiment.updateFittedPoints()


