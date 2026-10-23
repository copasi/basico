import unittest
import basico

class TestEFM(unittest.TestCase):
    def test_efm(self):
        dm = basico.load_example('brusselator')
        self.assertIsNotNone(dm)
        flux_modes  = basico.get_elementary_flux_modes()
        self.assertIsNotNone(flux_modes)
        self.assertEqual(len(flux_modes), 2)
        self.assertEqual(len(flux_modes[0]['reaction_name']), 2)
        self.assertEqual(flux_modes[0]['reversible'], False)
        self.assertEqual(flux_modes[1]['reversible'], False)
        basico.remove_datamodel(dm)

if __name__ == '__main__':
    unittest.main()
