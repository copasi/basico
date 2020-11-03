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

    def test_steadystate(self):
        result = basico.run_steadystate()
        self.assertTrue(result == 1)


if __name__ == "__main__":
    unittest.main()
