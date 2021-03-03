import unittest
import basico
import COPASI


class TestBasicoIO_Brus(unittest.TestCase):

    def setUp(self):
        dm = basico.load_example('brusselator')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())
        print('Running setup')

    def test_get_species(self):
        species = basico.get_species('X')
        self.assertTrue(species.shape[0] == 1)

    def test_get_reaction_parameters(self):
        parameters = basico.get_reaction_parameters('k1')
        self.assertTrue(parameters.shape[0] == 4)
        parameters = basico.get_reaction_parameters('(R1).k1')
        self.assertTrue(parameters.shape[0] == 1)

    def test_set_reaction_parameters(self):
        parameters = basico.get_reaction_parameters('(R1).k1')
        self.assertEqual(parameters.shape[0], 1)
        value = parameters.iloc[0].value
        self.assertEqual(value, 1)
        basico.set_reaction_parameters('(R1).k1', value=2)
        value = basico.get_reaction_parameters('(R1).k1').iloc[0].value
        self.assertEqual(value, 2.0)

    def test_timecourse(self):
        data = basico.run_time_course()
        self.assertTrue(data.shape[1] == 2)
        basico.set_model_unit(substance_unit=1)
        data_stoch = basico.run_time_course(method='stochastic')
        self.assertTrue(data_stoch.shape[1] == 2)

    def test_steadystate(self):
        result = basico.run_steadystate()
        self.assertTrue(result == 1)

    def test_expressions(self):
        result = basico.model_info._split_by_cn('<CN=Root,Model=model0,Vector=Compartments[compartment],'
                                                'Vector=Metabolites[P],Reference=Concentration>*<CN=Root,Model='
                                                'model0,Vector=Values[epsilon],Reference=Value>+<CN=Root,Model='
                                                'model0,Vector=Values[offset],Reference=Value>')
        self.assertTrue(len(result) == 5)
        self.assertTrue(result[0] == 'CN=Root,Model=model0,Vector=Compartments[compartment],Vector='
                                     'Metabolites[P],Reference=Concentration')
        self.assertTrue(result[1] == '*')

        result = basico.model_info._split_by_cn('sin(A + B + C)')
        self.assertTrue(len(result) == 8)


class TestBasicoIO_LM(unittest.TestCase):

    def setUp(self):
        dm = basico.load_example('LM-test1')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('Kinetics of a  Michaelian enzyme measured spectrophotometrically' in basico.model_io.overview())
        print('Running setup')

    def test_get_parameter(self):
        params = basico.get_parameters()
        self.assertEqual(params.shape[0], 3)
        params = basico.get_parameters('epsilon')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 0.78)

    def test_set_parameter(self):
        params = basico.get_parameters('epsilon')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 0.78)
        basico.set_parameters('epsilon', initial_value=2.0)
        params = basico.get_parameters('epsilon')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 2.0)


if __name__ == "__main__":
    unittest.main()
