import petab
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
            for i in range(num_expected-num_values):
                values.append(values[0])

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

    :return:
    """
    # convert to COPASI file
    converter = copasi_petab_importer.PEtabConverter.from_yaml(yaml_file, out_dir=output_dir, out_name=out_name)
    converter.convert()

    # load into basico
    basico.load_model(os.path.join(output_dir, converter.out_name + '.cps'))
    