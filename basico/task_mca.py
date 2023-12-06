"""Utility methods for working with the mca task

"""
import logging

import basico
import COPASI

from . import model_io

logger = logging.getLogger(__name__)

def run_mca(**kwargs):
    """Runs the mca task, the result is obtained

    by calling:

    * `get_elasticities`
    * `get_flux_control_coefficients` or
    * `get_concentration_control_coefficients`

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    model.getModel().compileIfNecessary()

    if 'settings' in kwargs:
        basico.set_task_settings(basico.T.MCA, kwargs['settings'], model=model)

    task = model.getTask(basico.T.MCA)
    assert (isinstance(task, COPASI.CMCATask))

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logger.error('Could not initialize Sensitivity Task: {0}'.format(COPASI.CCopasiMessage.getAllMessageText()))
        return

    use_initial_values = kwargs.get('use_initial_values', True)

    if not task.processRaw(use_initial_values):
        logger.error('Could not run Sensitivity Task: {0}'.format(COPASI.CCopasiMessage.getAllMessageText()))
        return

    task.restore()



def get_mca_matrix(matrix, scaled=True, run_first=False, **kwargs):
    """Returns the specified mca matrix as pandas data frame

    :param matrix: the matrix to be returned, as string, one of `elasticities`,
                   `flux_control_coefficients` or `concentration_control_coefficients`
    :param scaled: boolean flag indicating whether the scaled matrix should be returned
                   defaults to True

    :param run_first: boolean flag indicating that the task should be run first (defaults to false)

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the selected mca matrix
    :rtype: pd.DataFrame
    """

    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    if run_first:
        run_mca(**kwargs)

    task = model.getTask(basico.T.MCA)
    assert (isinstance(task, COPASI.CMCATask))
    method = task.getMethod()
    assert (isinstance(method, COPASI.CMCAMethod))

    if matrix == 'elasticities':
        return basico.model_info._annotated_matrix_to_df(
            method.getScaledElasticitiesAnn() if scaled else method.getUnscaledElasticitiesAnn()
        )

    if matrix == 'concentration_control_coefficients':
        return basico.model_info._annotated_matrix_to_df(
            method.getScaledConcentrationCCAnn() if scaled else method.getUnscaledConcentrationCCAnn()
        )

    if matrix == 'flux_control_coefficients':
        return basico.model_info._annotated_matrix_to_df(
            method.getScaledFluxCCAnn() if scaled else method.getUnscaledFluxCCAnn()
        )

    return None



def get_elasticities(scaled=True, run_first=False, **kwargs):
    """Returns the elasticity matrix as pandas data frame

    :param scaled: boolean flag indicating whether the scaled matrix should be returned
                   defaults to True

    :param run_first: boolean flag indicating that the task should be run first (defaults to false)

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the elasticity matrix
    :rtype: pd.DataFrame
    """
    return get_mca_matrix('elasticities', scaled, run_first, **kwargs)

def get_flux_control_coefficients(scaled=True, run_first=False, **kwargs):
    """Returns the flux control coefficient matrix as pandas data frame

    :param scaled: boolean flag indicating whether the scaled matrix should be returned
                   defaults to True

    :param run_first: boolean flag indicating that the task should be run first (defaults to false)

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the flux control coefficient matrix
    :rtype: pd.DataFrame
    """
    return get_mca_matrix('flux_control_coefficients', scaled, run_first, **kwargs)

def get_concentration_control_coefficients(scaled=True, run_first=False, **kwargs):
    """Returns the concentration control coefficient matrix as pandas data frame

    :param scaled: boolean flag indicating whether the scaled matrix should be returned
                   defaults to True

    :param run_first: boolean flag indicating that the task should be run first (defaults to false)

    :param kwargs: optional arguments

         - | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)

         - | `settings`: a dictionary with the settings to apply first

         - | `use_initial_values`: boolean flag indicating whether initial values should be used (true by default)

    :return: the concentration control coefficient matrix
    :rtype: pd.DataFrame
    """
    return get_mca_matrix('concentration_control_coefficients', scaled, run_first, **kwargs)