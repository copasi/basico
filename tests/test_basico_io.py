import unittest
import basico
import COPASI


class TestBasicoIO(unittest.TestCase):

    def test_new_model(self):
        dm = basico.new_model()
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('New Model' in basico.model_io.overview())
        basico.remove_datamodel(dm)

    def test_load_example(self):
        dm = basico.load_example('brusselator')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())
        basico.remove_datamodel(dm)

    def test_load_biomodel(self):
        dm = basico.load_biomodel(10)
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('Kholodenko2000' in basico.model_io.overview())
        basico.remove_datamodel(dm)

    def test_simulate(self):
        basico.load_example('LM')
        data = basico.get_experiment_data_from_model()
        self.assertTrue(len(data) == 5)
        df = basico.run_time_course(100, automatic=False)
        self.assertTrue(df.shape == (101, 5))


if __name__ == "__main__":
    unittest.main()
