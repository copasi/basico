""" Utility methods for working with the Lyapunov task
"""

import logging
from math import e
import basico
import COPASI

from . import model_io

logger = logging.getLogger(__name__)


def run_lyapunov(**kwargs):
    """Runs the lyapunov task, the result is obtained

    by calling:

    * `get_lyapunov_exponents`

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `num_exponents`: number of exponents to calculate (default: 3)

         - | `calculate_divergence`: boolean flag indicating whether the divergence should be calculated (default: True)

         - | `start_averaging_after`: time after which the averaging should start (default: disabled = 0)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    Example:

    .. code-block:: python

        >>> load_example('brusselator')
        >>> exponents, sums, divergence = run_lyapunov(num_exponents=2)
        >>> print(exponents)
        [-0.0007025645113957691, -2.6051942604518477]

    :return: tuple of exponents, sum of exponents and average divergence

    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    model.getModel().compileIfNecessary()

    if 'settings' in kwargs:
        basico.set_task_settings(basico.T.LYAPUNOV_EXPONENTS, kwargs['settings'], model=model)

    task = model.getTask(basico.T.LYAPUNOV_EXPONENTS)
    assert (isinstance(task, COPASI.CLyapTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CLyapProblem))

    if 'num_exponents' in kwargs:
        problem.setExponentNumber(int(kwargs['num_exponents']))

    if 'calculate_divergence' in kwargs:
        problem.setDivergenceRequested(bool(kwargs['calculate_divergence']))

    if 'start_averaging_after' in kwargs:
        problem.setTransientTime(float(kwargs['start_averaging_after']))

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logger.error('Could not initialize Lyapunov Task: {0}'.format(COPASI.CCopasiMessage.getAllMessageText()))
        return

    use_initial_values = kwargs.get('use_initial_values', True)

    if not task.processRaw(use_initial_values):
        logger.error('Could not run Lyapunov Task: {0}'.format(COPASI.CCopasiMessage.getAllMessageText()))
        return

    task.restore()

    return get_lyapunov_exponents(model=model)


def get_lyapunov_exponents(**kwargs):
    """Returns the lyapunov exponents calclated last time `run_lyapunov` was called

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

    :return: a tuple of exponent, sum of exponents and average divergence
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(basico.T.LYAPUNOV_EXPONENTS)
    assert (isinstance(task, COPASI.CLyapTask))


    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CLyapProblem))

    num_exponents = task.numberOfExponentsCalculated()
    exponent_vec = task.exponents()
    exponents = []

    for i in range(num_exponents):
        exponents.append(exponent_vec.get(i))

    sum_exponents = task.sumOfExponents()
    
    average_divergence = task.averageDivergence()
    
    return exponents, sum_exponents, average_divergence