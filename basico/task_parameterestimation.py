import pandas
import COPASI

try:
    from . import model_io, open_copasi
except:
    import model_io


def num_experiment_files(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask("Parameter Estimation")
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    return problem.getExperimentSet().size()


def pe_get_experiment_names(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask("Parameter Estimation")
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    result = []
    for i in range(problem.getExperimentSet().size()):
        experiment = problem.getExperimentSet().getExperiment(i)
        result.append(experiment.getObjectName())
    return result


def num_validations_files(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask("Parameter Estimation")
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    return problem.getCrossValidationSet().size()


def get_data_from_experiment(experiment):
    # type: (COPASI.CExperiment) -> pandas.DataFrame
    num_lines = sum(1 for l in open(experiment.getFileNameOnly()))
    header_row = experiment.getHeaderRow()
    skip_idx = [x for x in range(1, num_lines) if
                not (experiment.getFirstRow() <= x < experiment.getLastRow())]

    if header_row > num_lines:
        df = pandas.read_csv(experiment.getFileNameOnly(),
                             sep=experiment.getSeparator(),
                             header=None,
                             skiprows=skip_idx)
    else:
        df = pandas.read_csv(experiment.getFileNameOnly(),
                             sep=experiment.getSeparator(),
                             skiprows=skip_idx)
    return df


def get_experiment_data_from_model(model=None):
    # type: (COPASI.CDataModel) -> [pandas.DataFrame]
    if model is None:
        model = model_io.get_current_model()
    result = []

    task = model.getTask("Parameter Estimation")
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
        df = get_data_from_experiment(experiment)
        result.append(df)

    return result


def get_fit_parameters(model=None):
    # type: (COPASI.CDataModel) -> [pandas.DataFrame]
    if model is None:
        model = model_io.get_current_model()

    pe_task = model.getTask('Parameter Estimation')
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


def _get_affected_experiments(optitem):
    # type: (COPASI.CCopasiParameterGroup) -> [str]
    result = []
    affected = optitem.getGroup('Affected Experiments')
    assert (isinstance(affected, COPASI.CCopasiParameterGroup))
    for i in range(affected.size()):
        current = affected.getParameter(i)
        result.append(current.getStringValue())
    return result


def get_parameters_solution(model=None):
    # type: (COPASI.CDataModel) -> pandas.DataFrame
    if model is None:
        model = model_io.get_current_model()
    pe_task = model.getTask('Parameter Estimation')
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
    old_calculate_statistics = problem.getCalculateStatistics()
    old_randomize_start_values = problem.getRandomizeStartValues()

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


if __name__ == "__main__":
    print(COPASI.CVersion.VERSION.getVersion())
    m = model_io.load_example("LM-test1")
    print(get_fit_parameters())
    print(get_parameters_solution())
    run_parameter_estimation(method='LevenbergMarquardt')
    print(get_parameters_solution())
    model_io.open_copasi()
    pass
