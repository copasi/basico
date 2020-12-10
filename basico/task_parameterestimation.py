import pandas
import COPASI
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os
import logging

AFFECTED_EXPERIMENTS = 'Affected Experiments'
TASK_PARAMETER_ESTIMATION = 'Parameter Estimation'

try:
    from . import model_io
except ValueError:
    import model_io

try:
    from builtins import ValueError
except ImportError:
    pass


def num_experiment_files(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(TASK_PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    return problem.getExperimentSet().size()


def pe_get_experiment_names(**kwargs):
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


def pe_get_experiment_keys(**kwargs):
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
    # type: (COPASI.CDataModel) -> [pandas.DataFrame]
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


def get_fit_parameters(model=None):
    # type: (COPASI.CDataModel) -> [pandas.DataFrame]
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
    # type: (COPASI.CDataModel) -> pandas.DataFrame
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
        return None

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
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))
    task = model.getTask('Parameter Estimation')
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
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask('Parameter Estimation')
    assert (isinstance(task, COPASI.CFitTask))

    if 'scheduled' in kwargs:
        task.setScheduled(kwargs['scheduled'])

    if 'update_model' in kwargs:
        task.setUpdateModel(kwargs['update_model'])

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

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

    task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)

    task.processRaw(use_initial_values)

    problem.setCreateParameterSets(old_create_parameter_sets)

    return get_parameters_solution(model)


def get_simulation_results(**kwargs):
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
            if obj is not None:
                if cn.endswith('InitialConcentration'):
                    obj.getObjectParent().setInitialConcentration(value)
                else:
                    obj.getObjectParent().setInitialValue(value)
                change_set.append(obj)

        if change_set.size() > 0:
            model.updateInitialValues(change_set)

        for j in range(solution.shape[0]):
            name = solution.iloc[j].name
            value = solution.iloc[j].sol
            if np.isnan(value):
                continue
            affected = solution.iloc[j].affected
            if any(affected) and exp_name not in affected:
                continue

            basico.set_reaction_parameters(name, value=value)

        duration = df.iloc[-1].Time
        data = basico.run_time_course(duration=duration)

        exp_data.append(df)
        sim_data.append(data)

    return exp_data, sim_data


def plot_per_experiment(**kwargs):
    """
    This function creates one figure per experiment defined, with plots of all dependent variables and their fit

    :param kwargs:
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
    This function creates a figure that plots all experimental data for a given dependent variable

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


if __name__ == "__main__":
    print(COPASI.CVersion.VERSION.getVersion())
    m = model_io.load_example("LM-test1")
    print(get_fit_parameters())
    print(get_parameters_solution())
    run_parameter_estimation(method='LevenbergMarquardt')
    print(get_parameters_solution())
    model_io.open_copasi()
