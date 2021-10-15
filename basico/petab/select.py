import logging

from . import core
import basico
import petab_select
from math import log
import os
import tempfile


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
    if SSR != SSR or N == 0:
        return float("inf")
    return N * log(SSR / N) + 2 * K


def default_evaluation():
    """Default evaluation of current model:

    * runs particle swarm for 600 iterations followed by
    * levelberg marquardt


    :return: found paramter values
    """
    basico.run_parameter_estimation(method='Particle Swarm', update_model=True,
                                    settings={'method': {'Iteration Limit': 600}})
    sol = basico.run_parameter_estimation(method='Levenberg - Marquardt', update_model=True)
    return sol


def evaluate_model(test_model, evaluation=default_evaluation, temp_dir=None, delete_temp_files=True,
                   sim_dfs=None, sol_dfs=None, temp_files=None):
    """evaluates the given test model and updates it with the calculated metrics and estimated parameters

    :param test_model: the model to test
    :type test_model: petab_select.Model
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
    :return: COPASI objective value of the evaluation
    :rtype: float
    """
    # create petab problem
    pp = test_model.to_petab()[0]

    created_temp_dir = False
    if temp_dir is None:
        temp_dir = tempfile.mkdtemp()
        created_temp_dir = True

    model_id = test_model.model_id
    files = core.write_problem_to(pp, temp_dir, model_id)

    # load into basico
    out_name = 'cps_{0}'.format(model_id)
    cps_file = os.path.join(temp_dir, out_name + '.cps')
    core.load_petab(files['problem'], temp_dir, out_name)

    files = files.values()
    files.append(cps_file)

    files = files + basico.get_experiment_filenames()

    # run parameter estimation
    sol = evaluation()
    if sol_dfs:
        sol_dfs.append(sol)

    simulation_results = basico.get_simulation_results(values_only=True, solution=sol)
    basico.prune_simulation_results(simulation_results)
    sim_df = basico.petab.create_simulation_df(pp.measurement_df, simulation_results)
    if sim_dfs:
        sim_dfs.append(sim_df)

    # compute metrics
    llh = basico.petab.petab_llh(pp, sim_df)
    aic = float(petab_select.calculate_aic(pp.parameter_df.estimate.sum(), -llh))
    aicc = float(petab_select.calculate_aicc(pp.parameter_df.estimate.sum(), -llh, len(pp.measurement_df), 0))
    bic = float(petab_select.calculate_bic(pp.parameter_df.estimate.sum(), -llh, len(pp.measurement_df), 0))
    aic_copasi = copasi_aic()
    task = basico.get_current_model().getTask("Parameter Estimation")
    prob = task.getProblem()
    obj = prob.getSolutionValue()
    logging.debug(
        'AIC: {0}, AICc: {1}, BIC: {2}, Copasi AIC: {3}, LLH: {4}, OBJ: {5}, RMS: {6}'
        .format(aic, aicc, bic, aic_copasi, llh, obj, prob.getRMS())
    )
    logging.debug(sol)
    test_model.set_criterion('AIC', aic)
    test_model.set_criterion('AICc', aicc)
    test_model.set_criterion('BIC', bic)

    # update estimated parameters
    for param_id in test_model.parameters:
        value = test_model.parameters[param_id]
        if value == value:  # we only want to include what we estimated
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

    for test_model in test_models:
        try:
            evaluate_model(test_model, evaluation, temp_dir, delete_temp_files, sim_dfs, sol_dfs, temp_files)
        except:
            logging.exception("couldn't evaluate " + test_model.model_id)


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
    model_space = selection_problem.model_space

    if candidate_space is None:
        logging.info('initializing new candidate space with method: {0}'.format(selection_problem.method))
        if selection_problem.method == 'forward':
            candidate_space = petab_select.ForwardCandidateSpace(get_initial_virtual_model(selection_problem))
        elif selection_problem.method == 'brute_force':
            candidate_space = petab_select.BruteForceCandidateSpace()
        elif selection_problem.method == 'backward':
            candidate_space = petab_select.BackwardCandidateSpace(
                get_initial_virtual_model(selection_problem, initial_value=float('nan')))
        else:
            logging.error('unsupported candidate space {0} please initialize first and pass along'
                          .format(selection_problem.method))

    test_models = model_space.neighbors(candidate_space)

    if not test_models:
        logging.warning('no models to test, method: {0}'.format(selection_problem.method))
        return None

    chosen_model = None
    while test_models:
        basico.petab.evaluate_models(test_models, evaluation, temp_dir, delete_temp_files, sim_dfs, sol_dfs, temp_files)

        for model in test_models:
            logging.info('{0} = {1}'.format(model.model_id, model.criteria))

        chosen_model = selection_problem.get_best(test_models)
        if chosen_model is None:
            logging.warning('found no best model?')

        logging.debug('best model is {0}'.format(chosen_model.model_id))
        candidate_space.reset(chosen_model)
        test_models = model_space.neighbors(candidate_space)

    return chosen_model


def get_initial_virtual_model(selection_problem, initial_value=0.01):
    """Utility function returning an initial virtual model

    :param selection_problem: the selection problem
    :type selection_problem: petab_select.Problem
    :param initial_value: initial value for all parameters to use (defaults to 0.01)
    :type initial_value: float

    :return: the initial virtual model
    :rtype: petab_select.Model
    """
    model_space = selection_problem.model_space
    parameters = {
        k: initial_value
        for k in model_space.parameter_ids
    }

    initial_virtual_model = petab_select.Model(
        model_id='INITIAL_VIRTUAL_MODEL',
        petab_yaml=model_space.source_path,
        parameters=parameters,
    )

    return initial_virtual_model
