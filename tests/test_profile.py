import unittest
import basico.task_profile_likelihood as pl
import os

dir_name = os.path.dirname(__file__)

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

    def test_reports(self):
        report_files = [
            os.path.join(dir_name, 'out__00000__update_high.txt'),
            os.path.join(dir_name, 'out__00000__update_low.txt'),
        ]

        first = pl._get_data_from_file(report_files[0])
        second = pl._get_data_from_file(report_files[1])

        combined, obj_val, param_val = pl._combine_files(report_files)
        self.assertIsNotNone(combined)
        self.assertAlmostEqual(obj_val, 12.844)


if __name__ == '__main__':
    unittest.main()
