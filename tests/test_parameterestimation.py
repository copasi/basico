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


if __name__ == '__main__':
    unittest.main()
