import unittest
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

    def test_set_fit_items(self):
        old_fit_items = basico.get_fit_parameters().reset_index()
        basico.set_fit_parameters(old_fit_items)
        fit_items = basico.get_fit_parameters().reset_index()
        old_first = old_fit_items.iloc[0].to_dict()
        new_first = fit_items.iloc[0].to_dict()
        self.assertEqual(old_first['name'], new_first['name'])
        self.assertEqual(old_first['lower'], new_first['lower'])
        self.assertEqual(old_first['upper'], new_first['upper'])


if __name__ == '__main__':
    unittest.main()
