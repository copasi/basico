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

    def test_axis(self):
        y_min = 60
        y_max = 330
        scale = pl._make_y_axis(y_min, y_max)
        self.assertEqual(scale[0], 60)
        self.assertEqual(scale[-1], 330)

        scale = pl._make_y_axis(y_min, y_max, 5)
        self.assertEqual(scale[0], 0)
        self.assertEqual(scale[-1], 360)

        y_min = 60847326
        y_max = 73425330
        scale = pl._make_y_axis(y_min, y_max)
        self.assertEqual(scale[0], 60000000)
        self.assertEqual(scale[-1], 74000000)

        scale = pl._make_y_axis(0, 12.5015)
        self.assertEqual(scale[0], 0)
        self.assertEqual(scale[-1], 14)

        scale = pl._make_y_axis(12.1, 12.5015, 3)
        self.assertEqual(scale[0], 12)
        self.assertEqual(scale[-1], 12.8)

if __name__ == '__main__':
    unittest.main()
