import unittest
import basico.task_profile_likelihood as pl

class TestProfile(unittest.TestCase):
    def test_adjustements(self):
        self.assertAlmostEqual(2, pl._adjust_value(1, '200%'))
        self.assertAlmostEqual(1, pl._adjust_value(2, '-50%'))
        self.assertAlmostEqual(3, pl._adjust_value(2, '+50%'))
        self.assertAlmostEqual(0.1, pl._adjust_value(0.2, '-50%'))
        self.assertAlmostEqual(0.3, pl._adjust_value(0.2, '+50%'))
        self.assertAlmostEqual(3, pl._adjust_value(2, '150%'))
        self.assertAlmostEqual(3, pl._adjust_value(2, 1.5))
        self.assertAlmostEqual(1, pl._adjust_value(2, 0.5))

if __name__ == '__main__':
    unittest.main()
