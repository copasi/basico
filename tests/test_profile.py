import glob
import shutil
import tempfile
import unittest
import basico.task_profile_likelihood as pl
import basico
import pandas as pd
import os

dir_name = os.path.dirname(__file__)


class TestProfile(unittest.TestCase):
    def test_adjustments(self):
        self.assertAlmostEqual(2, pl._adjust_value(1, '200%'))
        self.assertAlmostEqual(1, pl._adjust_value(2, '-50%'))
        self.assertAlmostEqual(3, pl._adjust_value(2, '+50%'))
        self.assertAlmostEqual(0.1, pl._adjust_value(0.2, '-50%'))
        self.assertAlmostEqual(0.3, pl._adjust_value(0.2, '+50%'))
        self.assertAlmostEqual(3, pl._adjust_value(2, '150%'))
        self.assertAlmostEqual(3, pl._adjust_value(2, 1.5))
        self.assertAlmostEqual(1, pl._adjust_value(2, 0.5))
        self.assertAlmostEqual(5, pl._adjust_value(3, '=5'))
        self.assertAlmostEqual(0.3, pl._adjust_value(3, '=10%'))
        self.assertAlmostEqual(-0.3, pl._adjust_value(3, '=-10%'))
        self.assertAlmostEqual(1, pl._adjust_value(3, None, 1))
        self.assertAlmostEqual(1, pl._adjust_value(3, None, '1'))
        self.assertAlmostEqual(1, pl._adjust_value(3, 'default', '1'))
        self.assertAlmostEqual(1, pl._adjust_value(3, 'default', 1))
        self.assertAlmostEqual(1, pl._adjust_value(3, '-1SD', 1, 2))
        self.assertAlmostEqual(7, pl._adjust_value(3, '2SD', 1, 2))

    def test_reports(self):
        report_files = [
            os.path.join(dir_name, 'out__00000__update_high.txt'),
            os.path.join(dir_name, 'out__00000__update_low.txt'),
        ]

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

    def test_creation_and_run(self):
        temp_dir = tempfile.mkdtemp()
        basico.new_model(name='Schaber Example', notes="""
        The example from the supplement, originally described in

        Schaber, J. and Klipp, E. (2011) Model-based inference of biochemical parameters and
        dynamic properties of microbial signal transduction networks, Curr Opin Biotechnol, 22, 109-
        116 (https://doi.org/10.1016/j.copbio.2010.09.014)

        """)

        basico.add_function('mod. MA',
                            'k * S * T',
                            'irreversible',
                            mapping={'S': 'modifier', 'T': 'substrate'}
                            )

        basico.add_reaction('v1', 'T -> Tp; S', function='mod. MA')
        basico.add_reaction('v2', 'Tp -> T')
        basico.add_reaction('decay', 'S ->', mapping={'k1': 0.5})
        basico.set_species('Tp', initial_concentration=0)
        basico.add_species('TpFit', status='assignment', expression='{[Tp]}/0.5')
        basico.add_experiment('Data set 1', pd.DataFrame(data={
            'Time': [1, 2, 4, 6],
            '[TpFit]': [1, 0.88, 0.39, 0.22],
            # 'sd': [0.09, 0.09, 0.09, 0.09]
        }), file_name=os.path.join(temp_dir, 'data.csv')
        )

        basico.set_fit_parameters([
            {'name': '(v1).k', 'lower': 0, 'upper': 100},
            {'name': '(v2).k1', 'lower': 0, 'upper': 100},
        ])

        temp_file = os.path.join(temp_dir, 'test.cps')
        basico.save_model_and_data(temp_file)

        sol = basico.run_parameter_estimation(method=basico.PE.HOOKE_JEEVES, update_model=True)
        self.assertAlmostEqual(sol['sol'].iloc[0], 2.27, places=2)
        self.assertAlmostEqual(sol['sol'].iloc[1], 1.43, places=2)

        temp_file = os.path.join(temp_dir, 'test.cps')
        basico.save_model_and_data(temp_file)

        info = pl.prepare_files(temp_file, data_dir=temp_dir, lower_adjustment=0.1, upper_adjustment=10)
        self.assertEqual(info['num_params'], 2)
        self.assertEqual(info['num_data'], 4)
        self.assertAlmostEqual(info['obj'], 0.0059, places=4)
        generated = glob.glob(os.path.join(temp_dir, 'out__*.cps'))
        self.assertIsNotNone(generated)

        info = pl.prepare_files(temp_file, data_dir=temp_dir, lower_adjustment='-2SD', upper_adjustment='+2SD')
        self.assertEqual(info['num_params'], 2)
        self.assertTrue('param_sds' in info)
        self.assertTrue('(v1).k' in info['param_sds'])
        self.assertAlmostEqual(info['param_sds']['(v1).k'], 0.5657, places=2)

        # cleanup
        shutil.rmtree(temp_dir)


if __name__ == '__main__':
    unittest.main()
