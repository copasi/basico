"""This module is concerned with brining the model to steady state.

The :func:`run_steadystate` method brings the currently loaded model to steady state
supporting a number of parameters you could set. Once done, additional calls to functions
like :func:`.get_species` or :func:`.get_reactions` will contain the steady state values.

Example:

    >>> run_steadystate()
    >>> get_species()

"""
import COPASI
from . import model_io
from . import model_info
import logging


def run_steadystate(**kwargs):
    """Brings the model to steady state.

    The function will use the :func:`.get_current_model()` unless one is provided.

    :param kwargs: optional arguments:

     - | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

     - `use_initial_values` (bool): whether to use initial values

     - `scheduled` (bool): sets whether the task is scheduled or not

     - `update_model` (bool): sets whether the model should be updated, or reset to initial conditions.

     - | `criterion` (str): specifies the acceptance criterion to be used for a steady state can be one of:
       |
       |  * `Distance and Rate`: both the Distance and the Rate criterion have to be fulfilled to accept
       |  * `Distance`: the distance criterion
       |  * `Rate`: the rate of change has to be sufficiently small


     - `settings` (dict): a dictionary with settings to use, in the same format as the ones obtained from
                         :func:`.get_task_settings`

    :return: integer status information whether the steady state was reached:

       - `0`: not found
       - `1`: steady state found
       - `2`: equillibrium steady state found
       - `3`: steady state with negative concentrations found

    :rtype: int
    """
    model = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask('Steady-State')
    assert (isinstance(task, COPASI.CSteadyStateTask))

    if 'scheduled' in kwargs:
        task.setScheduled(kwargs['scheduled'])

    if 'update_model' in kwargs:
        task.setUpdateModel(kwargs['update_model'])

    if 'criterion' in kwargs:
        method = task.getMethod()
        assert (isinstance(method, COPASI.CSteadyStateMethod))
        method.getParameter('Target Criterion').setStringValue(kwargs['criterion'])

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CSteadyStateProblem))

    use_initial_values = kwargs.get('use_initial_values', True)

    if 'settings' in kwargs:
        model_info.set_task_settings(task, kwargs['settings'])

    result = task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)
    if not result:
        logging.error("Error while initializing the simulation: " +
                      COPASI.CCopasiMessage.getLastMessage().getText())
    else:
        result = task.processRaw(use_initial_values)
        if not result:
            logging.error("Error while running the simulation: " +
                          COPASI.CCopasiMessage.getLastMessage().getText())

    return task.getResult()
