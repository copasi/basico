import unittest
import basico
import os
import COPASI

class TestLNA(unittest.TestCase):
    @unittest.skipIf(COPASI.CVersion.VERSION.getVersionMinor() < 45, 'Require 4.45 of COPASI')
    def test_lna(self):
        dm = basico.load_example('brusselator')
        self.assertIsNotNone(dm)
        status = basico.run_lna()

        self.assertEqual(status, 'The reduced system has non-negative Eigen values! No LNA calculated!')

        basico.remove_datamodel(dm)

        dm = basico.load_example('Yeast')
        self.assertIsNotNone(dm)
        status, cv, cv_red, b = basico.run_lna(return_results=True)

        # this model has reversible reactions, so the LNA should not be calculated
        # and the matrices should be empty
        self.assertEqual(status, 'No steady state found. No LNA calculated!')
        self.assertEqual(len(cv), 0)
        self.assertEqual(len(cv_red), 0)
        self.assertEqual(len(b), 0)
        basico.remove_datamodel(dm)
        


        dm = basico.load_model(os.path.join(os.path.dirname(__file__), 'test_data', 'BM11.cps'))
        self.assertIsNotNone(dm)
        status, cv, cv_red, b = basico.run_lna(return_results=True)
        self.assertEqual(status, 'Steady State found.')

        # ensure matrices are not empty
        self.assertTrue(len(cv) > 0)
        self.assertTrue(len(cv_red) > 0)
        self.assertTrue(len(b) > 0)

        basico.remove_datamodel(dm)


if __name__ == '__main__':
    unittest.main()
