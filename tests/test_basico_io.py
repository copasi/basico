import os.path
import tempfile
import unittest
import basico
import basico.biomodels
import COPASI


class TestBasicoIO(unittest.TestCase):

    def test_new_model(self):
        dm = basico.new_model()
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('New Model' in basico.model_io.overview())
        basico.remove_datamodel(dm)

    def test_loading_nonexistent(self):
        dm = basico.load_model('does_not_exist.cps')
        self.assertIsNone(dm)

    def test_load_example(self):
        dm = basico.load_example('brusselator')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())

        # save model to string
        copasi = basico.save_model_to_string()
        basico.remove_datamodel(dm)

        # try to load the model from string
        dm = basico.load_model(copasi)
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())

        # save model as temp file
        sbml_name = tempfile.mktemp()
        basico.save_model(sbml_name, type='sbml')
        cps_name = tempfile.mktemp()
        basico.save_model(cps_name, type='copasi')
        sedml_name = tempfile.mktemp()
        basico.save_model(sedml_name, type='sedml')
        omex_name = tempfile.mktemp()
        basico.save_model(omex_name, type='omex')

        # model and data
        basico.save_model_and_data(cps_name, delete_data_on_exit=True)

        # export sbml
        sbml_string = basico.save_model_to_string(type='sbml')
        self.assertTrue(sbml_string is not None)
        sedml_string = basico.save_model_to_string(type='sedml', model_location='model.xml')
        self.assertTrue(sedml_string is not None)

        basico.remove_datamodel(dm)

    def test_load_biomodel(self):
        dm = basico.load_biomodel(10)
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('Kholodenko2000' in basico.model_io.overview())
        basico.remove_datamodel(dm)

        dm = basico.load_biomodel("MODEL1006230012")
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('Stewart2009' in basico.model_io.overview())
        params = basico.get_parameters()
        self.assertEqual(params.shape[0], 176)
        basico.remove_datamodel(dm)

    def test_search_biomodels(self):
        models = basico.biomodels.search_for_model('Hodgkin')
        model_ids = [model['id'] for model in models]
        curated_models = len(models)
        self.assertTrue(curated_models > 0)
        models = basico.biomodels.search_for_model('Hodgkin AND curationstatus:"Non-curated"')
        uncurated = len(models)
        self.assertTrue(uncurated > 0)
        uncurated_ids = [model['id'] for model in models]
        self.assertNotEqual(model_ids, uncurated_ids)

    def test_simulate(self):
        dm = basico.load_example('LM')
        data = basico.get_experiment_data_from_model()
        self.assertTrue(len(data) == 5)
        df = basico.run_time_course(100, automatic=False)
        self.assertTrue(df.shape == (101, 5))
        basico.remove_datamodel(dm)

    def test_omex_file(self):
        filename = os.path.join(os.path.dirname(__file__), 'test_data', 'LM.omex')
        self.assertTrue(os.path.exists(filename))
        dm = basico.load_model(filename)
        data = basico.get_experiment_data_from_model(model=dm)
        self.assertTrue(len(data) > 0)
        basico.remove_datamodel(dm)

        with open(filename, 'rb') as input_file:
            raw = input_file.read()
            dm = basico.load_model_from_string(raw)
            data = basico.get_experiment_data_from_model(model=dm)
            self.assertTrue(len(data) > 0)
            basico.remove_datamodel(dm)


if __name__ == "__main__":
    unittest.main()
