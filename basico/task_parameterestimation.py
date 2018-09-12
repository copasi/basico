import COPASI
import model_io
import pandas


def num_experiment_files(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask("Parameter Estimation")
    assert (isinstance(task, COPASI.CFitTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))

    return problem.getExperimentSet().size()


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
