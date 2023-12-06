import logging
from math import log, isnan
import os
import tempfile

from petab_select import Criterion

from . import core
import basico
import petab_select

logger = logging.getLogger(__name__)


def copasi_aic():
    """Calculates the AIC based on the last parameter estimation run

        SSR = weighted sum of squares
        N = number of data points
        K = number of parameters being estimated (note that this is one more than the number of parameters
        in COPASI, since the SSR is also a parameter being estimated; so this is basically K = parameters + 1)
        AIC = Akaike's information criterion
        AICc= corrected Akaike's information criterion (for low N)

        AIC = N * log(SSR/N) + 2*K

        AICc = N * log(SSR/N) + 2*K*(K+1)/(N-K-1)

        :return: the aic based on above calculation
        :rtype: float
    """
    prob = basico.get_current_model().getTask("Parameter Estimation").getProblem()
    N = prob.getExperimentSet().getValidValueCount()
    K = prob.getOptItemSize() + 1
    SSR = prob.getSolutionValue()
    if isnan(SSR) or N == 0:
        return float("inf")
    return N * log(SSR / N) + 2 * K


def default_evaluation():
    """Default evaluation of current model:

    * runs particle swarm for 600 iterations followed by
    * levenberg marquardt


    :return: found parameter values
    """
    #logger.debug('running ps\n')
    #basico.run_parameter_estimation(method='Particle Swarm', update_model=True,
    #                                settings={'method': {'Iteration Limit': 600}})
    logger.debug('running ga, 30gens\n')
    basico.run_parameter_estimation(method=basico.PE.GENETIC_ALGORITHM_SR, update_model=True,
                                    settings={'method': {
                                        'Number of Generations': 30,
                                        'Population Size': 10,
                                        'Stop after # Stalled Generations': 30
                                        }})
    logger.debug('running nl, 1000 iterations')
    sol = basico.run_parameter_estimation(method=basico.PE.NL2SOL, update_model=True,
                                            settings={'method': {
                                                'Iteration Limit': 1000,
                                            }}
                                          )
    # logger.debug('running lm')
    # sol = basico.run_parameter_estimation(method='Levenberg - Marquardt', update_model=True)
    logger.debug('evaluation done')
    return sol


def _get_value_for_parameter(solution, param_id, param_name=None):
    """
    Extracts the value for the given parameter from the given solution

    :param solution: the solution to extract the parameter from (as dictionary,
        with index of COPASI opt item names, and solution in 'sol')
    :type solution: dict
    :param param_id: the id of the parameter to extract
    :type param_id: str
    :param param_name: the name of the parameter to extract
    :type param_name: str or None
    :return: the value of the parameter in the solution or None if the parameter
        was not found in the solution
    :rtype: float or None

    """

    id_to_find = 'Values[' + param_id + ']'
    name_to_find = 'Values[' + param_name + ']' if param_name is not None else None

    for entry in solution:
        if entry['name'] == id_to_find:
            return entry['sol']
        if name_to_find is not None and entry['name'] == name_to_find:
            return entry['sol']

    return None


def _get_estimated_parameters(solution, petab_problem):
    """
    Extracts the estimated parameters from the given solution and returns them
    as a dictionary just like the parameters in the petab problem

    :param solution: the solution to extract the parameters from (as returned by
        basico.get_parameters_solution)
    :type solution: pandas.DataFrame
    :param petab_problem: the petab problem to extract the parameters from
    :type petab_problem: petab.Problem

    :return: the estimated parameters as a dictionary with petab parameter ids and
    the obtained solution for the parameters to be estimated.
    :rtype: dict

    """
    params = {}
    estimated = basico.as_dict(solution, fold_list=False)
    for entry in basico.as_dict(petab_problem.parameter_df, fold_list=False):
        # skip entries not to be computed
        if 'estimate' in entry and entry['estimate'] == 0:
            continue

        param_id = entry['parameterId']
        name = entry['parameterName'] if 'parameterName' in entry else None
        value = _get_value_for_parameter(estimated, param_id, name)
        if value is not None:
            params[param_id] = value
    return params


def evaluate_model(test_model, evaluation=default_evaluation, temp_dir=None, delete_temp_files=True,
                   sim_dfs=None, sol_dfs=None, temp_files=None):
    """evaluates the given test model and updates it with the calculated metrics and estimated parameters

    :param test_model: the model to test
    :type test_model: petab_select.Model
    :param evaluation: optional function to evaluate the test model with. defaults to func:`.default_evaluation`
    :type evaluation: () -> pandas.DataFrame
    :param temp_dir: optional temp directory to store the files in (otherwise the os temp dir will be used)
    :type temp_dir: str or None
    :param delete_temp_files: boolean indicating whether temp files should be deleted
    :type delete_temp_files: bool
    :param sim_dfs: optional array, in which simulation data frames will be returned
    :type sim_dfs: [] or None
    :param sol_dfs: optional array in which found parameters will be returned
    :type sol_dfs: [] or None
    :param temp_files: optional array that returns filenames of temp files created during the run
    :type temp_files: [] or None
    :return: COPASI objective value of the evaluation
    :rtype: float
    """
    # create petab problem
    pp = test_model.to_petab()['petab_problem']

    created_temp_dir = False
    if temp_dir is None:
        temp_dir = tempfile.mkdtemp()
        created_temp_dir = True

    if not os.path.exists(temp_dir):
        os.makedirs(temp_dir, exist_ok=True)

    model_id = test_model.model_id
    files = core.write_problem_to(pp, temp_dir, model_id)

    logger.debug(f'\n\n\nsubspace: {test_model.model_subspace_id}, params: {test_model.parameters}, indices: {test_model.model_subspace_indices}, model_id: {model_id}')
    # load into basico
    out_name = 'cps_{0}'.format(model_id)
    cps_file = os.path.join(temp_dir, out_name + '.cps')
    core.load_petab(files['problem'], temp_dir, out_name)

    files = list(files.values())
    files.append(cps_file)

    files = files + basico.get_experiment_filenames()

    # run parameter estimation
    sol = evaluation()
    if sol_dfs:
        sol_dfs.append(sol)

    # set estimated parameters
    params = _get_estimated_parameters(sol, pp)
    test_model.set_estimated_parameters(params)

    simulation_results = basico.get_simulation_results(values_only=True, solution=sol)
    basico.prune_simulation_results(simulation_results)
    sim_df = basico.petab.create_simulation_df(pp.measurement_df, simulation_results)
    sim_df = basico.petab.transform_simulation_df(sim_df, pp.observable_df)
    if sim_dfs:
        sim_dfs.append(sim_df)

    # compute metrics
    llh = float(basico.petab.petab_llh(pp, sim_df))
    test_model.set_criterion(Criterion.LLH, llh)

    task = basico.get_current_model().getTask("Parameter Estimation")
    prob = task.getProblem()
    obj = prob.getSolutionValue()
    logger.debug(f'obj: {obj}, llh: {llh}, si: {test_model.model_subspace_id}\n\n')

    test_model.compute_criterion(Criterion.AIC)
    test_model.compute_criterion(Criterion.AICC)
    test_model.compute_criterion(Criterion.BIC)
    test_model.compute_criterion(Criterion.NLLH)

    # update estimated parameters
    for param_id in test_model.parameters:
        value = test_model.parameters[param_id]
        if str(value) != 'estimate':  # not isnan(value):  # we only want to include what we estimated
            continue
        name = 'Values[{0}]'.format(param_id)
        if name in sol.index:
            test_model.estimated_parameters[param_id] = sol.loc[name].sol

    # write result for testing
    result_file = os.path.join(temp_dir, 'result_{0}.yaml'.format(model_id))
    files.append(result_file)
    test_model.to_yaml(result_file)

    # delete temp files if needed
    if delete_temp_files:
        for file in files:
            os.remove(file)
        if created_temp_dir:
            # since we created the temp dir, lets get rid of it
            os.rmdir(temp_dir)
    elif temp_files is not None:
        # add temp files to the list of temp files:
        temp_files = temp_files + files

    return obj


def evaluate_models(test_models, evaluation=default_evaluation, temp_dir=None, delete_temp_files=True,
                    sim_dfs=None, sol_dfs=None, temp_files=None):
    """Evaluates all temp models iteratively

    :param test_models: the models to evaluate
    :param evaluation: optional function to evaluate the test model with. defaults to func:`.default_evaluation`
    :type evaluation: () -> pandasDataFrame
    :param temp_dir: optional temp directory to store the files in (otherwise the os temp dir will be used)
    :type temp_dir: str or None
    :param delete_temp_files: boolean indicating whether temp files should be deleted
    :type delete_temp_files: bool
    :param sim_dfs: optional array, in which simulation data frames will be returned
    :type sim_dfs: [] or None
    :param sol_dfs: optional array in which found parameters will be returned
    :type sol_dfs: [] or None
    :param temp_files: optional array that returns filenames of temp files created during the run
    :type temp_files: [] or None
    :return:
    """

    obj_values = []
    for test_model in test_models:
        try:
            obj = evaluate_model(test_model, evaluation, temp_dir, delete_temp_files, sim_dfs, sol_dfs, temp_files)
            obj_values.append({'obj': obj,
                               'id': test_model.model_subspace_id,
                               'params:, test_model.parameters, '
                               'indices': test_model.model_subspace_indices})
        except Exception as e:
            logger.exception("couldn't evaluate " + test_model.model_id)
            logger.critical(e, exc_info=True)

    logger.debug(f'obj_values: {obj_values}')


def evaluate_problem(selection_problem, candidate_space=None, evaluation=default_evaluation, temp_dir=None,
                     delete_temp_files=True, sim_dfs=None, sol_dfs=None, temp_files=None):
    """Evaluates the given selection problem with the specified candidate space returning the best model found

    :param selection_problem: the selection problem
    :type selection_problem: petab_select.Problem
    :param candidate_space: optional the candidate space to use (otherwise the one from the problem method will be used)
    :type candidate_space: petab_select.CandidateSpace or None
    :param evaluation: optional function to evaluate the test model with. defaults to func:`.default_evaluation`
    :type evaluation: () -> pandasDataFrame
    :param temp_dir: optional temp directory to store the files in (otherwise the os temp dir will be used)
    :type temp_dir: str or None
    :param delete_temp_files: boolean indicating whether temp files should be deleted
    :type delete_temp_files: bool
    :param sim_dfs: optional array, in which simulation data frames will be returned
    :type sim_dfs: [] or None
    :param sol_dfs: optional array in which found parameters will be returned
    :type sol_dfs: [] or None
    :param temp_files: optional array that returns filenames of temp files created during the run
    :type temp_files: [] or None
    :return: the best model found
    :rtype: petab_select.Model
    """
    if candidate_space is None:
        logger.info('initializing new candidate space with method: {0}'.format(selection_problem.method))

        candidate_space = petab_select.ui.candidates(
            problem=selection_problem
        )
        candidate_space.set_predecessor_model(selection_problem.candidate_space_arguments.get('predecessor_model', None))

    test_models = candidate_space.models

    if not test_models:
        logger.warning('no models to test, method: {0}'.format(selection_problem.method))
        return None

    # Calibrated and newly calibrated models should be tracked between iterations.
    calibrated_models = {}

    while test_models:
        basico.petab.evaluate_models(test_models, evaluation, temp_dir, delete_temp_files, sim_dfs, sol_dfs, temp_files)
        for model in test_models:
            logger.info('{0} = {1}'.format(model.model_id, model.criteria))

        chosen_model = selection_problem.get_best(test_models)
        if chosen_model is None:
            logger.warning('found no best model?')

        logger.debug('best model is {0}'.format(chosen_model.model_id))

        newly_calibrated_models = {
            model.get_hash(): model for model in test_models
        }

        calibrated_models.update(newly_calibrated_models)
        selection_problem.exclude_models(newly_calibrated_models.values())

        petab_select.ui.candidates(
            problem=selection_problem,
            candidate_space=candidate_space,
            newly_calibrated_models=newly_calibrated_models
        )

        test_models = candidate_space.models

    # pick the best one found overall
    chosen_model = selection_problem.get_best(calibrated_models.values())
    return chosen_model
