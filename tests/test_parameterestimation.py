import unittest

import matplotlib.pyplot

import basico


class TestBasicoParamterEstimation(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_example('LM')
        self.assertTrue(self.model.getModel().getObjectName() ==
                        'Kinetics of a  Michaelian enzyme measured spectrophotometrically')

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

        set_2 = basico.get_data_from_experiment('Experiment')
        self.assertEqual(set_2.shape, (100, 3))

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


class TestBasicoParamterEstimationPK(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_example('PK')
        self.assertTrue(self.model.getModel().getObjectName() ==
                        'Pritchard2002_glycolysis')

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


class TestMultipleResults(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_model('multiple_experiments.cps')
        self.assertTrue(self.model.getModel().getObjectName() ==
                        'multiple_experiments')

    def test_current_solution(self):
        result = basico.get_simulation_results()
        self.assertTrue(len(result) == 2)
        self.assertTrue(len(result[0]) == len(result[0]))


if __name__ == '__main__':
    unittest.main()
