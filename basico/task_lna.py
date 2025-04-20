""" Utility methods for working with the Linear Noise Approximation task
"""

import logging
import basico
import COPASI


from . import model_io

logger = logging.getLogger(__name__)

# LNA is available since COPASI 4.45.295+
_have_lna_method = int(COPASI.__version__.split('.')[-1]) > 295

def run_lna(return_results=False, **kwargs):
    """ Runs the LNA task

    :param return_results: if True the results are returned (by call `get_lna_solution`), otherwise only the status is returned
    :param kwargs: optional arguments

            - | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)   
     
            - `settings`: a dictionary with settings for the LNA task

            - `use_initial_values`: if True the initial values are used, otherwise the current state is used

    :return: the status of the LNA task and the results (if `return_results` is True), otherwise only
             the status is returned 
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    model.getModel().compileIfNecessary()

    if 'settings' in kwargs:
        basico.set_task_settings(basico.T.LNA, kwargs['settings'], model=model)

    task = model.getTask(basico.T.LNA)
    assert (isinstance(task, COPASI.CLNATask))

    # remember messages before running the task
    num_messages_before = COPASI.CCopasiMessage.size()

    use_initial_values = kwargs.get('use_initial_values', True)

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logger.error('Could not initialize LNA Task: {0}'.format(
            basico.model_info.get_copasi_messages(num_messages_before, 'No output')))
        return get_lna_solution() if return_results else get_lna_status()

    task.processRaw(use_initial_values)
    task.restore(True)

    return get_lna_solution() if return_results else get_lna_status()


def _get_lna_status(**kwargs):
    """ Returns the status of the last run of the LNA task
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    task = model.getTask(basico.T.LNA)
    assert (isinstance(task, COPASI.CLNATask))

    if not _have_lna_method:
        logger.warning('LNA method not available in this version of COPASI!')
        return model.getTask('Steady-State').getResult(), 0

    method = task.getMethod()
    assert (isinstance(method, COPASI.CLNAMethod))

    status = method.getSteadyStateStatus()
    e_status = method.getEigenValueStatus()

    return status, e_status


def get_lna_status(**kwargs):
    """ Returns the status of the last run of the LNA task

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

    :return: a tuple of the status of the LNA task and the eigenvalue status
    """
    
    status, e_status = _get_lna_status(**kwargs)
    
    if status == COPASI.CSteadyStateMethod.found and e_status == COPASI.CLNAMethod.allNeg:
        status = 'Steady State found.'
    elif status == COPASI.CSteadyStateMethod.foundEquilibrium and e_status == COPASI.CLNAMethod.allNeg:
        status = 'Equilibrium steady state.'
    elif status == COPASI.CSteadyStateMethod.foundNegative:
        status = 'Invalid steady state (negative concentrations). No LNA calculated!'
    elif status == COPASI.CSteadyStateMethod.notFound:
        status = 'No steady state found. No LNA calculated!'
    elif e_status == COPASI.CLNAMethod.nonNegEigenvaluesExist:
        status = 'The reduced system has non-negative Eigen values! No LNA calculated!'

    return status


def get_lna_solution(**kwargs):
    """ Returns the LNA solution calculated last time `run_lna` was called

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

    :return: a tuple of the LNA solution
    """

    return get_lna_status(**kwargs), get_lna_covariance_matrix(False, **kwargs), get_lna_reduced_covariance_matrix(False, **kwargs), get_lna_reduced_b_matrix(False, **kwargs)


def get_lna_covariance_matrix(scaled=False, **kwargs):
    """ Returns the LNA covariance matrix calculated last time `run_lna` was called
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    matrix = model.getObject(COPASI.CCommonName('CN=Root,Vector=TaskList[Linear Noise Approximation],Method=Linear Noise Approximation,Array=Covariance matrix'))
    if not _have_lna_method and matrix is not None:
        return basico.model_info._annotated_matrix_to_df(matrix)

    task = model.getTask(basico.T.LNA)
    assert (isinstance(task, COPASI.CLNATask))

    method = task.getMethod()
    assert (isinstance(method, COPASI.CLNAMethod))    

    return basico.model_info._annotated_matrix_to_df(
            method.getScaledCovarianceMatrixAnn() if bool(scaled) else method.getUnscaledCovarianceMatrixAnn()
        )



def get_lna_reduced_covariance_matrix(scaled=False, **kwargs):
    """ Returns the LNA covariance matrix calculated last time `run_lna` was called
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    matrix = model.getObject(COPASI.CCommonName('CN=Root,Vector=TaskList[Linear Noise Approximation],Method=Linear Noise Approximation,Array=Covariance matrix (reduced)'))
    if not _have_lna_method and matrix is not None:
        return basico.model_info._annotated_matrix_to_df(matrix)

    task = model.getTask(basico.T.LNA)
    assert (isinstance(task, COPASI.CLNATask))

    method = task.getMethod()
    assert (isinstance(method, COPASI.CLNAMethod))    

    return basico.model_info._annotated_matrix_to_df(
            method.getScaledCovarianceMatrixReducedAnn() if bool(scaled) else method.getUnscaledCovarianceMatrixReducedAnn()
        )


def get_lna_reduced_b_matrix(scaled=False, **kwargs):
    """ Returns the LNA covariance matrix calculated last time `run_lna` was called
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    matrix = model.getObject(COPASI.CCommonName('CN=Root,Vector=TaskList[Linear Noise Approximation],Method=Linear Noise Approximation,Array=B matrix (reduced)'))
    if not _have_lna_method and matrix is not None:
        return basico.model_info._annotated_matrix_to_df(matrix)

    task = model.getTask(basico.T.LNA)
    assert (isinstance(task, COPASI.CLNATask))

    method = task.getMethod()
    assert (isinstance(method, COPASI.CLNAMethod))    

    return basico.model_info._annotated_matrix_to_df(
            method.getScaledBMatrixReducedAnn() if bool(scaled) else method.getUnscaledBMatrixReducedAnn()
        )