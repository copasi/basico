import petab
import petab.simulate
import basico
import pandas as pd
import copasi_petab_importer
import os


def create_simulation_df(measurement_df, simulation_results):
    """Creates a simulation data frame

    :param measurement_df: the measurement data frame of the petab problem
    :type measurement_df: pd.DataFrame
    :param simulation_results: the simulation results as obtained from basico.get_simulation_results()
    :type simulation_results: []
    :return: simulation data frame with simulation results in the same format as the measurement data frame
    :rtype: pd.DataFrame
    """
    sim = measurement_df.copy(True)
    sim = sim.rename(columns={"measurement": "simulation"})
    exp_names = basico.get_experiment_names()
    for i in range(len(exp_names)):
        cond_id = exp_names[i]
        s_df = simulation_results[1][i]
        for obs in s_df.columns.to_list():
            obs_id = obs
            if obs == 'Time':
                continue
            if 'Values[' in obs:
                obs_id = obs[len('Values['):-1]

            values = s_df[obs].to_list()

            # deal with duplicates
            num_values = len(values)
            num_expected = len(sim.loc[(sim.observableId == obs_id) & (sim.simulationConditionId == cond_id), 'simulation'])
            for j in range(num_expected-num_values):
                values.append(values[-1])

            sim.loc[(sim.observableId == obs_id) & (sim.simulationConditionId == cond_id), 'simulation'] = values
    return sim


def petab_llh(pp, sim):
    """Computes the llh based on the simulation data frame

    :param pp: petab problem
    :type pp: petab.Problem

    :param sim: simulation data frame
    :type sim: pd.DataFrame

    :return: the llh as calculated by petab

    """
    return petab.calculate_llh(pp.measurement_df, sim, pp.observable_df, pp.parameter_df)


def petab_chi2(pp, sim):
    """Computes the chi2 based on the simulation data frame

    :param pp: petab problem
    :type pp: petab.Problem

    :param sim: simulation data frame
    :type sim: pd.DataFrame

    :return: the chi2 as calculated by petab

    """
    return petab.calculate_chi2(pp.measurement_df, sim, pp.observable_df, pp.parameter_df)


def petab_residuals(pp, sim):
    """Computes the residuals based on the simulation data frame

    :param pp: petab problem
    :type pp: petab.Problem

    :param sim: simulation data frame
    :type sim: pd.DataFrame

    :return: the residuals as calculated by petab

    """
    return petab.calculate_residuals(pp.measurement_df, sim, pp.observable_df, pp.parameter_df)


def write_problem_to(problem, output_dir, model_name):
    """Writes the given petab problem to the output directory with the given model_name

    :param problem: the petab problem
    :type problem: petab.Problem
    :param output_dir: the output directory where the files should be written to
    :type output_dir: str
    :param model_name: the common model name that all files will have
    :type model_name: str
    :return: dictionary of all the files created
    :rtype: {}
    """
    yaml_file = os.path.join(output_dir, 'problem_{0}.yaml'.format(model_name))
    model_file = os.path.join(output_dir, 'model_{0}.xml'.format(model_name))
    cond_file = os.path.join(output_dir, 'experimentalCondition_{0}.tsv'.format(model_name))
    data_file = os.path.join(output_dir, 'measurementData_{0}.tsv'.format(model_name))
    param_file = os.path.join(output_dir, 'parameters_{0}.tsv'.format(model_name))
    obs_file = os.path.join(output_dir, 'observables_{0}.tsv'.format(model_name))
    files = {
        'model': model_file,
        'conditions': cond_file,
        'measurements': data_file,
        'parameters': param_file,
        'observables': obs_file,
        'problem': yaml_file,
    }
    # write to files
    problem.to_files(
        sbml_file=model_file,
        condition_file=cond_file,
        measurement_file=data_file,
        parameter_file=param_file,
        observable_file=obs_file,
        yaml_file=yaml_file
    )
    return files


def load_petab(yaml_file, output_dir, out_name=None):
    """Loads the petab file as specified in the yaml file

    This file will be converted using the petab_copasi_importer, and serialized to the specified
    output directory.

    :param yaml_file: the yaml file of the petab description
    :type yaml_file: str
    :param output_dir: the output directory to write the files in
    :type output_dir: str
    :param out_name: optional base name of the copasi file. if it is not specified ith will be
        the basename of the yaml file
    :type out_name: str or None

    :return: the full path to the cps file loded
    """
    # convert to COPASI file
    converter = copasi_petab_importer.PEtabConverter.from_yaml(yaml_file, out_dir=output_dir, out_name=out_name)
    converter.convert()

    # load into basico
    cps_file = os.path.join(output_dir, converter.out_name + '.cps')
    basico.load_model(cps_file)
    return cps_file


class PetabSimulator(petab.simulate.Simulator):
    """ Implementation of a COPASI simulator with the petab simulation interface

        Examples:

        To instantiate the simulatior, just give it the problem and the settings you would like
        to use

        >>> sim = PetabSimulator(pp, settings= {'method' : {'name': PE.EVOLUTIONARY_STRATEGY_SRES}})
        >>> sim.simulate()

    """

    def __init__(self, petab_problem, working_dir=None, settings=None, name='', **kwargs):
        """ Inititializes the simulator

        :param petab_problem: A PEtab problem.
        :type petab_problem: petab.Problem

        :param working_dir: optional working dir (temp directory will be taken if it does not exist
        :type working_dir: Optional[Union[pathlib.Path, str]]

        :param settings: the settings to use for the parameter estimation (by default the converter will
               setup 'Current Solution Statistic', i.e: no parameter estimation will actually be carried out
               and just the values are returned.
        :type settings: {} or None

        :param name: an optional name that will be passed as model specific suffix to use while creating temp
               files (since the petab_problem will be serialized to files in order to be imported)s
        :type name: str

        :param kwargs: will be passed to base class. If it contains an argument:

            * 'cps_file' (str): this COPASI file will be loaded,
        """
        super().__init__(petab_problem, working_dir, **kwargs)
        self.settings = settings
        self.name = name
        self.cps_file = None
        self.load_model(**kwargs)

    def load_model(self, **kwargs):
        """Loads the model into basico

        If the `cps_file` is in the arguments, then this will be loaded. otherwise this instances
        petab_problem, will be written to files, converted to COPASI and then loaded (at which point
        the cps_file generated will be set).

        :param kwargs:

            - 'cps_file' (str): if present this file will be loaded rather than the petab problem

        :return: None
        """
        if 'cps_file' in kwargs:
            self.cps_file = kwargs['cps_file']
            basico.load_model(self.cps_file)
        else:
            files = write_problem_to(self.petab_problem, self.working_dir, self.name)
            self.cps_file = load_petab(files['problem'], self.working_dir)

    def evaluate(self):
        if self.settings is not None:
            basico.set_task_settings('Parameter Estimation', self.settings)
        return basico.run_parameter_estimation()

    def simulate_without_noise(self):
        """Simulate the PEtab problem.

        This is an abstract method that should be implemented with a simulation
        package. Examples of this are referenced in the class docstring.

        :return:
            Simulated data, as a PEtab measurements table, which should be
            equivalent to replacing all values in the `petab.C.MEASUREMENT`
            column of the measurements table (of the PEtab problem supplied to
            the `__init__` method), with simulated values.

        :rtype: pandas.DataFrame

        """

        simulation_results = basico.get_simulation_results(values_only=True, solution=self.evaluate())

        return create_simulation_df(self.petab_problem.measurement_df, simulation_results)

    def __getstate__(self):
        """Return state for pickling"""
        state = self.__dict__.copy()

        # maybe save cps file to omex? and add to state?

        return state

    def __setstate__(self, state):
        """Set state after unpickling"""
        self.__dict__.update(state)
        # initialize from 'cps_file' in state, otherwise we'd initialize from the settings
        self.load_model()
