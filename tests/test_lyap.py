from math import exp
import unittest
import basico

class TestLyap(unittest.TestCase):
    def test_lyap(self):
        dm = basico.load_example('brusselator')
        self.assertIsNotNone(dm)
        exponents, sums, divergence = basico.run_lyapunov(num_exponents=2)
        self.assertIsNotNone(len(exponents), 2)
        self.assertAlmostEqual(sums, (exponents[0] + exponents[1]))
        basico.remove_datamodel(dm)

if __name__ == '__main__':
    unittest.main()
