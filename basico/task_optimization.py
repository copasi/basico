"""Submodule with utility methods for setting up and carrying out optimization tasks.

The main function provided by this submodule is :func:`run_optimization`. Without any parameters, the
previously set up parameter estimation as stored in the file will be carried out. And the parameters found will
be returned.

Example:

    Create an optimization problem

    >>> from bascio import *
    >>> new_model(name='Square')
    >>> add_parameter('x', initial_value=0)
    >>> add_parameter('y', initial_value=0)
    >>> add_parameter('f', type='assignment',
    ...                    expression='(1+{Values[x].InitialValue})^2+(1 + {Values[y].InitialValue})^2')


    Setup the optimization

    >>> set_opt_settings({
    ...       'expression': 'Values[f].InitialValue',
    ...       'subtask': T.TIME_COURSE,
    ...       'method': {'name': PE.LEVENBERG_MARQUARDT}
    ... })

    Specifiy which paramters to vary:

    >>> set_opt_parameters(get_opt_item_template(include_global=True))

    Run the optimization

    >>> run_optimization()

    Get statistic, to see how good the fit was:

    >>> get_opt_statistic()


"""
import pandas

import basico
import COPASI
import logging

try:
    from . import model_io
except ValueError:
    import model_io


def get_opt_parameters(model=None):
    """Returns a data frame with all parameters to be varied during optimization

    The resulting dataframe will have the following columns:

    * `name`: the name of the fit parameter
    * `lower`: the lower bound of the parameter
    * `upper`: the upper bound of the parameter
    * `start`: the start value
    * `cn`: internal identifier

    :param model: the model to get the optitems from
    :type model: COPASI.CDataModel or None

    :return: data frame with the fit parameters
    :rtype: pandas.DataFrame
    """
    if model is None:
        model = model_io.get_current_model()

    pe_task = model.getTask(basico.T.OPTIMIZATION)
    problem = pe_task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))
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
            'cn': item.getObjectCN(),
        })

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def set_opt_parameters(opt_parameters, model=None):
    """Replaces all existing opt items with the ones provided

    :param opt_parameters: the optimization parameters as pandas data frame of list of dictionaries with keys:

           * 'name' str: the display name of the model element to map the column to.
           * 'lower': the lower bound of the parameter
           * 'upper': the upper bound of the parameter
           * 'start' (float, optional): the start value
           * 'cn' (str, optional): internal identifier

    :type opt_parameters: pandas.DataFrame or [{}]
    :param model: the model or None
    :type model: COPASI.CDataModel or None
    :return: None
    """
    # type: (pandas.DataFrame, COPASI.CDataModel)
    if model is None:
        model = model_io.get_current_model()

    if type(opt_parameters) is list:
        opt_parameters = pandas.DataFrame(data=opt_parameters)

    task = model.getTask(basico.T.OPTIMIZATION)
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))
    while problem.getOptItemSize() > 0:
        problem.removeOptItem(0)

    for i in range(len(opt_parameters)):
        item = opt_parameters.iloc[i]
        cn = None
        name = None

        if 'cn' in item:
            cn = COPASI.CCommonName(item.cn)

        if 'name' in item:
            name = item['name']
            if not cn:
                obj = model.findObjectByDisplayName(name)
                if obj:
                    if 'Reference' not in obj.getObjectType():
                        cn = obj.getInitialValueReference().getCN()
                    else:
                        cn = obj.getCN()

        if not cn:
            logging.warning('object {0} not found'.format(name))
            continue

        opt_item = problem.addOptItem(cn)
        assert (isinstance(opt_item, COPASI.COptItem))
        if 'lower' in item:
            opt_item.setLowerBound(COPASI.CCommonName(str(item['lower'])))
        if 'upper' in item:
            opt_item.setUpperBound(COPASI.CCommonName(str(item['upper'])))
        if 'start' in item:
            opt_item.setStartValue(float(item['start']))


def get_opt_item_template(include_local=False, include_global=False, default_lb=0.001, default_ub=1000, model=None):
    """Returns a template dictionary with optimization items

    :param include_local: boolean, indicating whether to include local parameters
    :type include_local: bool

    :param include_global: boolean indicating whether to include global parameters
    :type include_global: bool

    :param default_lb: default lower bound to be used
    :type default_lb: float

    :param default_ub: default upper bound to be used
    :type default_ub: float

    :param model: the model or None
    :type model: COPASI.CDataModel or None

    :return: List of dictionaries, with the local / global parameters in the format needed by:
             :func:`.set_opt_parameters`.
    :rtype: [{}]
    """
    return basico.get_fit_item_template(include_local, include_global, default_lb, default_ub, model)


def set_objective_function(expression, maximize=None, minimize=None, model=None):
    """Sets the objective function to be used

    :param expression: the expression to be used as objective function, it can contain any display names of model
           elements. So for example to minimize an initial value of a global parameter `x` the expression would look like
           `Values[x].InitialValue`.

    :param maximize: optional boolean indicating whether the expression should be maximized

    :param minimize: optional boolean indicating whether the expression should be minimized

    :param model: the model to be used or None

    :return: None
    """
    if model is None:
        model = model_io.get_current_model()

    task = model.getTask(basico.T.OPTIMIZATION)
    assert (isinstance(task, COPASI.COptTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))

    if not problem.setObjectiveFunction(basico.model_info._replace_names_with_cns(expression, model=model)):
        logging.error('invalid objective function: {0}'.format(expression))

    if maximize:
        problem.setMaximize(maximize)
    if minimize:
        problem.setMaximize(not minimize)


def get_opt_settings(model=None, basic_only=True):
    """Returns a dictionary with the optimization setup

       The result int dictionary includes the objective function, and the subtask.

    :param model: the model or None for the current one
    :param basic_only: boolean flag indicating whether only basic settings should be returned
    :type basic_only: bool
    :return: dictionary with settings
    """
    if model is None:
        model = model_io.get_current_model()

    task = model.getTask(basico.T.OPTIMIZATION)
    assert (isinstance(task, COPASI.COptTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))

    settings = basico.get_task_settings(basico.T.OPTIMIZATION, model=model, basic_only=basic_only)
    settings['expression'] = basico.model_info._replace_cns_with_names(problem.getObjectiveFunction(), model=model)

    subtype = problem.getSubtaskType()
    if subtype == 15:
        st = model.getObject(problem.getParameter('Subtask').getCNValue())
        if st:
            subtask = st.getObjectName()
        else:
            subtask = basico.T.STEADY_STATE
    else:
        subtask = basico.T.from_enum(subtype)

    settings['subtask'] = subtask

    return settings


def set_opt_settings(settings, model=None):
    """Changes the optimization setup

    :param settings: a dictionary as returned by :func:`.get_opt_parameters`
    :param model: the model to be used, nor None
    :return:
    """
    if model is None:
        model = model_io.get_current_model()

    basico.set_task_settings(basico.T.OPTIMIZATION, settings, model=model)

    task = model.getTask(basico.T.OPTIMIZATION)
    assert (isinstance(task, COPASI.COptTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))

    if 'expression' in settings:
        set_objective_function(settings['expression'], model=model)

    if 'subtask' in settings:
        problem.setSubtaskType(basico.T.to_enum(settings['subtask']))


def get_opt_solution(model=None):
    """Returns the solution found for the optimization parameters as data frame

    The resulting data frame will have the columns:

    * `name`: the name of the parameter
    * `lower`: the parameters lower bound
    * `upper`: the parameters upper bound
    * `sol`: the solution found in the last run (or NaN, if not run yet, or no solution found)

    :param model: the model to use, or None
    :type model: COPASI.CDataModel or None
    :return: data frame as described
    :rtype: pandas.DataFrame
    """
    if model is None:
        model = model_io.get_current_model()
    task = model.getTask(basico.T.OPTIMIZATION)
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))
    solution = problem.getSolutionVariables()
    items = problem.getOptItemList()
    assert(solution.size() == len(items))
    data = []

    for i in range(solution.size()):
        item = items[i]
        sol = solution.get(i)
        obj = model.getObject(COPASI.CCommonName(item.getObjectCN()))
        if obj is None:
            logging.debug('opt item not in model, cn: {0}'.format(item.getObjectCN()))
            continue
        obj = obj.toObject().getObjectParent()
        name = obj.getObjectDisplayName()
        data.append({
            'name': name,
            'lower': item.getLowerBound(),
            'upper': item.getUpperBound(),
            'sol': sol,
        })

    if not data:
        return pandas.DataFrame()

    return pandas.DataFrame(data=data).set_index('name')


def run_optimization(expression=None, output=None, settings=None, **kwargs):
    """Runs the optimization

    :param expression: optional objective function to be used
    :param settings: optional settings dictionary
    :param output: optional list of output to collect
    :param kwargs: optional arguments
    :return: pandas data frame of the specified output, or the resulting solution for the parameters
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    task = model.getTask(basico.T.OPTIMIZATION)
    assert (isinstance(task, COPASI.COptTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))

    if 'method' in kwargs:
        method = kwargs['method']
        if isinstance(method, dict):
            set_opt_settings({method}, model=model)
        elif isinstance(method, int):
            task.setMethodType(method)
        else:
            set_opt_settings({'method': {'name': method}}, model=model)
    if settings:
        set_opt_settings(settings, model)

    if expression:
        set_objective_function(expression, model)

    dh = None
    cols = []
    if output:
        dh, cols = basico.task_timecourse.create_data_handler(output, after=output, model=model)
        model.addInterface(dh)

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logging.warning("Couldn't initialize optimization task")

    use_initial_values = kwargs.get('use_initial_values', True)
    if not task.processRaw(use_initial_values):
        logging.warning("Couldn't process optimization task")

    if dh:
        model.removeInterface(dh)
        data = basico.task_timecourse.get_data_from_data_handler(dh, cols)
        del dh
        dh = None
        return data

    return get_opt_solution(model=model)


def get_opt_statistic(**kwargs):
    """Return information about the last optimization run.

    :param kwargs:

    - | `model`: to specify the data model to be used (if not specified
      | the one from :func:`.get_current_model` will be taken)

    :return: dictionary with the statistic
    :rtype: {}
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

    task = dm.getTask(basico.T.OPTIMIZATION)
    assert (isinstance(task, COPASI.COptTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.COptProblem))

    result = {
        'obj': problem.getSolutionValue(),
        'f_evals': problem.getFunctionEvaluations(),
        'failed_evals_exception': problem.getFailedEvaluationsExc(),
        'failed_evals_nan': problem.getFailedEvaluationsNaN(),
        'cpu_time': problem.getExecutionTime(),
    }
    result['evals_per_sec'] = result['cpu_time'] / result['f_evals']
    return result
