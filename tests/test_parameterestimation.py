import tempfile
import unittest
import os
import sys
import numpy as np
import pandas as pd
import basico
import COPASI

class TestBasicoParamterEstimation(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_example('LM')
        self.assertTrue(self.model.getModel().getObjectName() ==
                        'Kinetics of a  Michaelian enzyme measured spectrophotometrically')
        basico.add_parameter_set('initial_state')

    def tearDown(self):
        basico.remove_datamodel(self.model)

    def test_get_parameters(self):
        params = basico.get_parameters()
        signal = params.loc['signal']
        expression = signal.expression
        self.assertTrue(expression != '')
        conversion = basico.model_info._replace_names_with_cns(expression)
        self.assertTrue(conversion != '')
        expression = basico.model_info._replace_cns_with_names(conversion)
        self.assertTrue(expression != '')

    def test_get_data(self):
        data = basico.get_experiment_data_from_model()
        self.assertEqual(len(data), 5)
        set_1 = data[0]
        self.assertEqual(set_1.shape, (100, 3))

        names = basico.get_experiment_names()
        self.assertIn('Experiment', names)

        files = basico.get_experiment_filenames()
        self.assertEqual(len(files), len(names))

        set_2 = basico.get_data_from_experiment('Experiment')
        self.assertEqual(set_2.shape, (100, 3))

        sol_before = basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION)

        # get statstic
        stat = basico.get_fit_statistic(include_parameters=True, include_fitted=True)

        initial_fit_titems = basico.get_fit_parameters()
        # test mixed affected experiments
        names = basico.get_experiment_names()
        fit_items = [
            {'name': "Values[offset]", 'lower': 1e05, 'upper': 1e09, 'affected': ['Experiment']},
            {"name": "Values[offset]", 'lower': 1e-05, 'upper': 1e04}
        ]
        basico.set_fit_parameters(fit_items)
        items_after = basico.as_dict( basico.get_fit_parameters())
        self.assertEqual(items_after[0]['affected'], ['Experiment'])
        basico.set_fit_parameters(initial_fit_titems)

        # remove data
        basico.remove_experiments()

        files_to_delete = []
        # add data back
        for exp, name in zip(data, names):
            files_to_delete.append(basico.add_experiment(name, exp))

        # remove data
        basico.remove_experiments()

        # since we have affected experiments, reset them
        items = basico.get_fit_parameters()
        basico.set_fit_parameters(items)


        # save to temp file
        main_file = tempfile.mktemp()
        basico.save_model_and_data(main_file, delete_data_on_exit=True)

        # ensure it still works
        sol_after = basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION)
        self.assertListEqual(basico.as_dict(sol_before[['sol']]), basico.as_dict(sol_after[['sol']]))

        # delete temp files
        for file in files_to_delete:
            os.remove(file)
        os.remove(main_file)



    def test_mapping(self):
        mapping = basico.get_experiment_mapping(0)
        experiments = basico.save_experiments_to_dict()
        self.assertIsNotNone(experiments)
        # remove cns
        for entry in experiments[0]['mapping']:
            if 'cn' in entry:
                del entry['cn']

        basico.load_experiments_from_dict(experiments)
        experiments2 = basico.save_experiments_to_dict()
        self.assertIsNotNone(experiments)
        self.assertEqual(experiments[0]['mapping'][0]['object'], experiments2[0]['mapping'][0]['object'])
        self.assertEqual(experiments[0]['mapping'][2]['object'], experiments2[0]['mapping'][2]['object'])


    def test_experiment_dict(self):
        exp1 = basico.get_experiment_dict(0)
        self.assertTrue(exp1 is not None)
        # save to yaml
        yaml_str = basico.save_experiments_to_yaml()
        self.assertTrue(yaml_str is not None)
        # restore from yaml
        basico.load_experiments_from_yaml(yaml_str)
        # save again
        yaml_str2 = basico.save_experiments_to_yaml()
        self.assertEqual(yaml_str, yaml_str2)

    @unittest.skipIf(sys.version_info < (3, 6, 0), 'This test requires assertLogs which is not available before')
    def test_change_bounds(self):
        basico.set_fit_parameters([{'name': '(R1).k2', 'lower': 1, 'upper': 0.01}])
        with self.assertLogs(level='ERROR') as _:
            sol = basico.as_dict(basico.run_parameter_estimation())
        self.assertTrue(np.isnan(sol['sol']))

    def test_get_plotting_data(self):
        exp, sim = basico.get_simulation_results()
        self.assertTrue(len(exp) == len(sim))
        exp, sim = basico.get_simulation_results(values_only=True)
        self.assertListEqual(exp[0].Time.to_list(), sim[0].reset_index().Time.to_list())

    def test_get_item_template(self):
        template = basico.get_fit_item_template(include_local=True, include_global=True)
        self.assertTrue(len(template) == 5)

    def test_get_settings(self):
        settings = basico.get_task_settings('Parameter Estimation')
        self.assertTrue('method' in settings)
        self.assertTrue('Iteration Limit' in settings['method'])
        self.assertEqual(settings['method']['Iteration Limit'], 500)
        basico.set_task_settings('Parameter Estimation', {'method': {'Iteration Limit': 600}})
        settings = basico.get_task_settings('Parameter Estimation')
        self.assertTrue('method' in settings)
        self.assertTrue('Iteration Limit' in settings['method'])
        self.assertEqual(settings['method']['Iteration Limit'], 600)

    def test_run(self):
        sol = basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION)
        self.assertTrue(sol is not None)
        self.assertAlmostEqual(sol.loc['(R1).k2'].sol, 1.0, places=2)

    def test_current_solution(self):
        before = basico.get_simulation_results()
        # ensure the results are the same, even if randomize values
        # is activated
        settings = basico.get_task_settings('Parameter Estimation')
        settings['problem']['Randomize Start Values'] = True
        basico.set_task_settings('Parameter Estimation', settings)

        # now run again
        after = basico.get_simulation_results()

        # ensure that the results are the same
        self.assertTrue(np.allclose(before[1][0].values, after[1][0].values))

        # issue #54
        # Run function output, looking only at times
        function_output = basico.get_simulation_results(values_only=False)
        df_first_false = pd.concat([df for df in function_output[1]])['Time'].unique()

        # Run again, changing values_only to True
        function_output = basico.get_simulation_results(values_only=True)
        df_first_true = pd.concat([df for df in function_output[1]])['Time'].unique()

        # Run again, changing values_only back to False
        function_output = basico.get_simulation_results(values_only=False)
        df_second_false = pd.concat([df for df in function_output[1]])['Time'].unique()

        # Ensure that the results are the same
        self.assertTrue(np.allclose(df_first_false, df_second_false))


    def test_remove(self):
        fit_items = basico.get_fit_parameters()
        self.assertIsNotNone(fit_items)
        basico.remove_fit_parameters()
        fit_items_2 = basico.get_fit_parameters()
        self.assertIsNone(fit_items_2)
        basico.set_fit_parameters(fit_items)

    @unittest.skipIf(COPASI.CVersion.VERSION.getVersionMinor() < 41, 'Require 4.41 of COPASI')
    def test_constraints(self):
        constraints = basico.get_fit_constraints()
        self.assertIsNone(constraints)
        # set constraint for concentration of 'S'
        basico.set_fit_constraints([{'name': 'S', 'lower': 0.1, 'upper': 0.2}])
        constraints = basico.as_dict(basico.get_fit_constraints())
        self.assertIsNotNone(constraints)
        self.assertEqual(constraints['name'], 'S')
        self.assertEqual(constraints['lower'], '0.1')
        self.assertEqual(constraints['upper'], '0.2')

    def test_save(self):
        cps_name = tempfile.mktemp()
        basico.save_model_and_data(cps_name, delete_data_on_exit=True)
        d2 = basico.load_model(cps_name)
        self.assertIsNotNone(d2)
        basico.remove_datamodel(d2)


class TestBasicoParamterEstimationPK(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_example('PK')
        self.assertTrue(self.model.getModel().getObjectName() ==
                        'Pritchard2002_glycolysis')

    def tearDown(self):
        basico.remove_datamodel(self.model)

    def test_get_data(self):

        # without renaming data should remain as is
        experiment = basico.get_data_from_experiment(0, rename_headers=False)
        self.assertEqual(['# Time', 'Values[F16BP_obs]', 'Values[Glu_obs]', 'Values[Pyr_obs]',
                         '[Glc(ext)]_0', 'Unnamed: 5'], list(experiment.columns))
        self.assertEqual((101, 6), experiment.shape)

        # data should be renamed as expected, and unassigned columns dropped
        experiment = basico.get_data_from_experiment(0, rename_headers=True)
        self.assertEqual(['Time', '[Fru1,6-P2]', '[Glc(int)]', '[pyruvate]', '[Glc(ext)]_0'],
                         list(experiment.columns))
        self.assertEqual((101, 5), experiment.shape)
        self.assertEqual(0, experiment.iloc[0][0])
        self.assertEqual(2, experiment.iloc[100][0])

        # now simulate
        exp, sim = basico.get_simulation_results()
        self.assertTrue(len(exp) == len(sim) == 2)

        # ensure that simulations are different
        self.assertGreater(float(((sim[0][['Fru1,6-P2']] - sim[1][['Fru1,6-P2']]) ** 2).sum()), 10)

        # plotting is tested manually only
        # basico.plot_per_experiment()
        # basico.plot_per_dependent_variable()
        # matplotlib.pyplot.show()

    def test_set_fit_items(self):
        old_fit_items = basico.get_fit_parameters().reset_index()
        basico.set_fit_parameters(old_fit_items)
        fit_items = basico.get_fit_parameters().reset_index()
        old_first = old_fit_items.iloc[0].to_dict()
        new_first = fit_items.iloc[0].to_dict()
        self.assertEqual(old_first['name'], new_first['name'])
        self.assertEqual(old_first['lower'], new_first['lower'])
        self.assertEqual(old_first['upper'], new_first['upper'])

    def test_statistic(self):
        # when no fit is performed, the statistic should not crash
        result = basico.get_fit_statistic(include_parameters=True)
        self.assertTrue(result is not None)
        self.assertEqual(result['f_evals'], 0)

        # now get actual fit
        basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION)
        result = basico.get_fit_statistic()
        self.assertTrue(result is not None)
        self.assertTrue(result['obj'] < 0.2)

    def test_get_data(self):
        # contains all experimental data
        data = basico.get_experiment_data_from_model()
        self.assertTrue(data is not None)

        # to get data only from one experiment, you'd call
        for name in basico.get_experiment_names():
            data = basico.get_data_from_experiment(name)
            self.assertTrue(data is not None)
            # can be renamed
            data = basico.get_data_from_experiment(name, rename_headers=True)
            self.assertTrue(data is not None)

class TestMultipleResults(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_model(
            os.path.join(os.path.dirname(__file__), 'multiple_experiments.cps')
        )
        self.assertTrue(self.model.getModel().getObjectName() ==
                        'multiple_experiments')

    def tearDown(self):
        basico.remove_datamodel(self.model)

    def test_current_solution(self):
        result = basico.get_simulation_results()
        self.assertTrue(len(result) == 2)
        self.assertTrue(len(result[0]) == len(result[0]))


if __name__ == '__main__':
    unittest.main()
