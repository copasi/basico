import unittest
import basico
import COPASI


class TestBasicoIO(unittest.TestCase):

    def setUp(self):
        dm = basico.load_example('brusselator')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())
        print('Running setup')

    def test_get_species(self):
        species = basico.get_species('X')
        self.assertTrue(species.shape[0] == 1)

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


if __name__ == "__main__":
    unittest.main()
