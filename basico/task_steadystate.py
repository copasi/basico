import COPASI
import model_io


def run_steadystate(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask('Steady-State')
    assert (isinstance(task, COPASI.CSteadyStateTask))

    if 'scheduled' in kwargs:
        task.setScheduled(kwargs['scheduled'])

    if 'update_model' in kwargs:
        task.setUpdateModel(kwargs['update_model'])

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSteadyStateProblem))

    use_initial_values = kwargs.get('use_initial_values', True)

    task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)

    task.processRaw(use_initial_values)
