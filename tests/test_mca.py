import unittest
import basico


class TestMCA(unittest.TestCase):
    def setUp(self):
        basico.load_example('bruss')
        self.assertIsNotNone(basico.get_species('X', exact=True))

    def test_settings(self):
        settings = basico.get_task_settings(basico.T.MCA)
        self.assertIsNotNone(settings)
        self.assertTrue(settings['method']['Use Reder'])
        self.assertTrue(settings['method']['Use Smallbone'])


    def test_run(self):
        basico.run_mca()
        elasticities = basico.get_elasticities()
        self.assertIsNotNone(elasticities)
        concentration_control_coefficients = basico.get_concentration_control_coefficients()
        self.assertIsNotNone(concentration_control_coefficients)
        flux_control_coefficients = basico.get_flux_control_coefficients()
        self.assertIsNotNone(flux_control_coefficients)



if __name__ == '__main__':
    unittest.main()
