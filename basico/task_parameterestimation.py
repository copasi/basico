import pandas
import COPASI
import matplotlib.pyplot as plt
import numpy as np
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


def get_data_from_experiment(experiment, **kwargs):
    # type: (COPASI.CExperiment) -> pandas.DataFrame
    experiment = get_experiment(experiment, **kwargs)
    num_lines = sum(1 for line in open(experiment.getFileNameOnly()))
    header_row = experiment.getHeaderRow()
    skip_idx = [x-1 for x in range(0, num_lines+1) if
                not (experiment.getFirstRow() <= x <= experiment.getLastRow())]

    if 'rename_headers' in kwargs:
        rename_headers = kwargs['rename_headers']
    else:
        rename_headers = True

    if rename_headers:
        headers = {}
        drop_cols = []
        obj_map = experiment.getObjectMap()
        count = 0
        for i in range(obj_map.getLastColumn()+1):
            role = obj_map.getRole(i)

            if role == COPASI.CExperiment.time:
                headers[count] = 'Time'
                count += 1
                continue
            elif role == COPASI.CExperiment.ignore:
                drop_cols.append(i)
                continue
            else:
                cn = obj_map.getObjectCN(i)
                obj = experiment.getObjectDataModel().getObject(COPASI.CCommonName(cn))
                if obj:
                    headers[count] = obj.getObjectDisplayName()
                    count += 1
                else:
                    drop_cols.append(i)
                continue

    if header_row > num_lines:
        df = pandas.read_csv(experiment.getFileNameOnly(),
                             sep=experiment.getSeparator(),
                             header=None,
                             skiprows=skip_idx)
    else:
        df = pandas.read_csv(experiment.getFileNameOnly(),
                             sep=experiment.getSeparator(),
                             skiprows=skip_idx)

    if not rename_headers:
        return df

    if any(drop_cols):
        df.drop(drop_cols, axis=1)

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


def plot_per_dependent_variable(**kwargs):
    """
    This function creates a figure that plots all experimental data for a given dependent variable

    :return: figure
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

    solution = run_parameter_estimation(method='Statistics')

    model = dm.getModel()

    fig, ax = plt.subplots()
    cycler = plt.cycler("color", plt.cm.tab20c.colors)()

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
        dependent = mapping[mapping.type == 'dependent']
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
        num_dependent = dependent.shape[0]
        for j in range(num_dependent):
            nextval = next(cycler)['color']
            data.reset_index().plot(x='Time', y=dependent.iloc[j].mapping, label="Fitted", ax=ax, color=nextval)
            df.plot.scatter(x='Time', y=dependent.iloc[j].mapping, ax=ax, color=nextval, label='Measured')

        exp_data.append(df)
        sim_data.append(data)

    return exp_data, sim_data


if __name__ == "__main__":
    print(COPASI.CVersion.VERSION.getVersion())
    m = model_io.load_example("LM-test1")
    print(get_fit_parameters())
    print(get_parameters_solution())
    run_parameter_estimation(method='LevenbergMarquardt')
    print(get_parameters_solution())
    model_io.open_copasi()
