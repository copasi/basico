import unittest
import basico
import os

THIS_DIR = os.path.dirname(__file__)


class TestTimeCourse(unittest.TestCase):
    def setUp(self):
        basico.load_model(os.path.join(THIS_DIR, 'tellurium_sim.sbml'))

    def test_custom_output(self):
        tc = basico.run_time_course_with_output(['Time', '[S1]', '[S2]', 'Values[k1]'], 0, 5, 5)
        self.assertIsNotNone(tc)
        self.assertListEqual(tc.columns.to_list(), ['Time', '[S1]', '[S2]', 'Values[k1]'])


if __name__ == '__main__':
    unittest.main()
