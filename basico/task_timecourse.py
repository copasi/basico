"""This module encapsulates methods for running time course simulations.

main method provided is the :func:`run_time_course` method, that will
simulate the given model (or the current :func:`.get_current_model`).

Examples:

    To run a time course for the duration of 10 time units use

    >>> run_time_course(10)

    To run a time course for the duration of 10 time units, in 50 simulation steps use

    >>> run_time_course(10, 50)

    To run a time course from 0, for the duration of 10 time units, in 50 simulation steps use:

    >>> run_time_course(0, 10, 50)

    all parameters can also be given as key value pairs.

"""


import COPASI
from . import model_io
from . import model_info
import pandas
import numpy
import logging


def __build_result_from_ts(time_series, use_concentrations=True, use_sbml_id=False, model=None):
    # type: (COPASI.CTimeSeries) -> pandas.DataFrame
    col_count = time_series.getNumVariables()
    row_count = time_series.getRecordedSteps()

    if use_sbml_id and model is None:
        model = model_io.get_current_model()

    column_names = []
    column_keys = []
    for i in range(col_count):
        column_keys.append(time_series.getKey(i))
        name = time_series.getTitle(i)

        if use_sbml_id and name != 'Time':
            sbml_id = time_series.getSBMLId(i, model)
            if sbml_id:
                name = sbml_id

        column_names.append(name)

    concentrations = numpy.empty([row_count, col_count])
    for i in range(row_count):
        for j in range(col_count):
            if use_concentrations: 
                concentrations[i, j] = time_series.getConcentrationData(i, j)
            else:
                concentrations[i, j] = time_series.getData(i, j)

    df = pandas.DataFrame(data=concentrations, columns=column_names)
    df = df.set_index('Time')

    return df


def __method_name_to_type(method_name):
    methods = {
        'deterministic': COPASI.CTaskEnum.Method_deterministic,
        'lsoda': COPASI.CTaskEnum.Method_deterministic,
        'hybridode45': COPASI.CTaskEnum.Method_hybridODE45,
        'hybridlsoda': COPASI.CTaskEnum.Method_hybridLSODA,
        'adaptivesa': COPASI.CTaskEnum.Method_adaptiveSA,
        'tauleap': COPASI.CTaskEnum.Method_tauLeap,
        'stochastic': COPASI.CTaskEnum.Method_stochastic,
        'directmethod': COPASI.CTaskEnum.Method_directMethod,
        'radau5': COPASI.CTaskEnum.Method_RADAU5,
        'sde': COPASI.CTaskEnum.Method_stochasticRunkeKuttaRI5,
    }
    return methods.get(method_name.lower(), COPASI.CTaskEnum.Method_deterministic)


def run_time_course(*args, **kwargs):
    """Simulates the current or given model, returning a data frame with the results

    :param args: positional arguments

     * 1 argument: the duration to simulate the model
     * 2 arguments: the duration and number of steps to take
     * 3 arguments: start time, duration, number of steps

    :param kwargs: additional arguments

     - | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

     - `use_initial_values` (bool): whether to use initial values

     - `scheduled` (bool): sets whether the task is scheduled or not

     - `update_model` (bool): sets whether the model should be updated, or reset to initial conditions.

     - | `method` (str): sets the simulation method to use (otherwise the previously set method will be used)
       | support methods:
       |
       |   * `deterministic` / `lsoda`: the LSODA implementation
       |   * `stochastic`: the Gibson & Bruck Gillespie implementation
       |   * `directMethod`: Gillespie Direct Method
       |   * others: `hybridode45`, `hybridlsoda`, `adaptivesa`, `tauleap`, `radau5`, `sde`

     - `duration` (float): the duration in time units for how long to simulate

     - `automatic` (bool): whether to use automatic determined steps (True), or the specified interval / number of steps

     - `output_event` (bool): if true, output will be collected at the time a discrete event occurs.

     - | `start_time` (float): the output start time. If the model is not at that start time, a simulation
       |  will be performed in one step, to reach it before starting to collect output.

     - | `step_number` or `intervals` (int): the number of output steps. (will only be used if `automatic`
       | or `stepsize` is not used.

     - | `stepsize` (float): the output step size (will only be used if `automatic` is False).

     - | `seed` (int): set the seed that will be used if `use_seed` is true, using this stochastic trajectories can
       | be repeated

     - | 'use_seed' (bool): if true, the specified seed will be used.

     - | `a_tol` (float): the absolute tolerance to be used

     - | `r_tol` (float): the relative tolerance to be used

     - | `max_steps` (int): the maximum number of internal steps the integrator is allowed to use.

     - | `use_concentrations` (bool): whether to return just the concentrations (default)

     - | `use_numbers` (bool): return all elements collected

    :return: data frame with simulation results
    :rtype: pandas.DataFrame
    """
    num_args = len(args)
    model = kwargs.get('model', model_io.get_current_model())
    use_initial_values = kwargs.get('use_initial_values', True)

    if 'model' not in kwargs:
        model = model_io.get_current_model()

    task = model.getTask('Time-Course')
    assert (isinstance(task, COPASI.CTrajectoryTask))

    if 'scheduled' in kwargs:
        task.setScheduled(kwargs['scheduled'])

    if 'update_model' in kwargs:
        task.setUpdateModel(kwargs['update_model'])

    if 'method' in kwargs:
        task.setMethodType(__method_name_to_type(kwargs['method']))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CTrajectoryProblem))

    if 'duration' in kwargs:
        problem.setDuration(kwargs['duration'])
        problem.setUseValues(False)

    if 'automatic' in kwargs:
        problem.setAutomaticStepSize(kwargs['automatic'])

    if 'output_event' in kwargs:
        problem.setOutputEvent(kwargs['output_event'])

    if 'start_time' in kwargs:
        problem.setOutputStartTime(kwargs['start_time'])

    if 'step_number' in kwargs:
        problem.setStepNumber(kwargs['step_number'])

    if 'intervals' in kwargs:
        problem.setStepNumber(kwargs['intervals'])

    if 'stepsize' in kwargs:
        problem.setStepSize(kwargs['stepsize'])

    if 'values' in kwargs:
        vals = kwargs['values']
        if type(vals) != str:
            new_vals = ''
            for val in vals:
                new_vals += ' ' + str(val)
            vals = new_vals.strip()
        problem.setValues(vals)
        problem.setUseValues(True)

    if 'use_values' in kwargs:
        problem.setUseValues(kwargs['use_values'])

    if num_args == 3:
        problem.setOutputStartTime(args[0])
        problem.setDuration(args[1])
        problem.setStepNumber(args[2])
    elif num_args == 2:
        problem.setDuration(args[0])
        problem.setStepNumber(args[1])
    elif num_args > 0:
        problem.setDuration(args[0])

    problem.setTimeSeriesRequested(True)

    method = task.getMethod()
    if 'seed' in kwargs and method.getParameter('Random Seed'):
        method.getParameter('Random Seed').setIntValue(int(kwargs['seed'])) 
    if 'use_seed' in kwargs and method.getParameter('Random Seed'):
        method.getParameter('Use Random Seed').setBoolValue(bool(kwargs['use_seed'])) 
    if 'a_tol' in kwargs and method.getParameter('Absolute Tolerance'):
        method.getParameter('Absolute Tolerance').setDblValue(float(kwargs['a_tol'])) 
    if 'r_tol' in kwargs and method.getParameter('Relative Tolerance'):
        method.getParameter('Relative Tolerance').setDblValue(float(kwargs['r_tol'])) 
    if 'max_steps' in kwargs and method.getParameter('Max Internal Steps'):
        method.getParameter('Max Internal Steps').setIntValue(int(kwargs['max_steps']))

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

    use_concentrations = kwargs.get('use_concentrations', True)
    if 'use_numbers' in kwargs and kwargs['use_numbers']:
        use_concentrations = False

    use_sbml_id = kwargs.get('use_sbml_id', False)
    
    return __build_result_from_ts(task.getTimeSeries(), use_concentrations, use_sbml_id, model)
