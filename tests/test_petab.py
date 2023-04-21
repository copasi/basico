import sys

import unittest
import glob
import logging

import numpy as np
import pandas as pd
import os.path
import yaml

# set log level to debug
logging.basicConfig(level=logging.DEBUG)

import basico

try:
    import petab_select
    from petab import Problem
    from basico.petab import PetabSimulator, evaluate_problem
    petab_test_enabled = True
except ImportError:
    # print import error
    import traceback
    traceback.print_exc()
    petab_test_enabled = False
    pass


_dir_name = os.path.dirname(__file__)
_BENCHMARK_MODEL_DIR = os.getenv('PETAB_BENCHMARK_MODELS', None)
_PETAB_SELECT_MODEL_DIR = os.getenv('PETAB_SELECT_MODELS', None)


class PetabTestCase(unittest.TestCase):
    @unittest.skipUnless(petab_test_enabled and
                         _BENCHMARK_MODEL_DIR and
                         os.path.exists(_BENCHMARK_MODEL_DIR),
                         "require petab and benchmark models for this test")
    def test_import(self):
        files = glob.glob(_BENCHMARK_MODEL_DIR + '/*/*.yaml')
        for f in files:
            if 'Sneyd_PNAS2002' not in f:
                continue
            #if 'Lucarelli' not in f:
            #    continue
            logging.warning(f)
            pp = Problem.from_yaml(f)
            name = os.path.splitext(os.path.basename(f))[0]
            sim = PetabSimulator(pp, working_dir='./test_data/', name=name)
            sim.simulate()

    @unittest.skipUnless(petab_test_enabled, "require petab for these tests")
    def test_dataframe_convert(self):
        mes_df = pd.read_csv(os.path.join(_dir_name, 'mes_df.csv'))
        sim_df = pd.read_csv(os.path.join(_dir_name, 'sim_df.csv'))
        sim_df = sim_df.set_index('Time')

        result_df = mes_df.copy(True)
        result_df = result_df.rename(columns={"measurement": "simulation"})
        basico.petab.core._update_df_from_simulation(result_df, sim_df, 'model1_data1')
        result_df.to_csv('out_df.csv', index=False)        
        os.remove('out_df.csv')
        self.assertEqual(mes_df.shape[0], result_df.shape[0])
        self.assertEqual(mes_df.shape[1], result_df.shape[1])

    @unittest.skipUnless(petab_test_enabled, "require petab for these tests")
    def test_dataframe_convert_steady(self):
        mes_df = pd.read_csv(os.path.join(_dir_name, 'ss_mes_df.csv'))
        sim_df = pd.read_csv(os.path.join(_dir_name, 'steady_df.csv'))

        result_df = mes_df.copy(True)
        result_df = result_df.rename(columns={"measurement": "simulation"})
        basico.petab.core._update_df_from_simulation(result_df, sim_df, 'control')
        result_df.to_csv('ss_out_df.csv', index=False)
        os.remove('ss_out_df.csv')
        self.assertEqual(mes_df.shape[0], result_df.shape[0])
        self.assertEqual(mes_df.shape[1], result_df.shape[1])

    @unittest.skipUnless(petab_test_enabled, "require petab for these tests")
    def test_dataframe_multiple_times(self):
        mes_df = pd.read_csv(os.path.join(_dir_name, 'ex_0008.tsv'), sep='\t')
        sim_df = pd.read_csv(os.path.join(_dir_name, '0008.tsv'), sep='\t', index_col='Time')

        result_df = mes_df.copy(True)
        result_df = result_df.rename(columns={"measurement": "simulation"})
        basico.petab.core._update_df_from_simulation(result_df, sim_df, 'c0')
        result_df.to_csv('out0008.csv', index=False)
        os.remove('out0008.csv')
        self.assertEqual(mes_df.shape[0], result_df.shape[0])
        self.assertEqual(mes_df.shape[1], result_df.shape[1])


    @unittest.skipUnless(petab_test_enabled, "require petab for these tests")
    def test_model_selection(self):
        problem = petab_select.Problem.from_yaml(os.path.join(_dir_name, 'model_selection', 'petab_select_problem.yaml'))
        best = evaluate_problem(problem, temp_dir=os.path.join(_dir_name, 'temp_selection'), delete_temp_files=False)
        self.assertIsNotNone(best)

    @unittest.skipUnless(petab_test_enabled and
                         _PETAB_SELECT_MODEL_DIR and
                         os.path.exists(_PETAB_SELECT_MODEL_DIR),
                         "require petab for these tests")
    def test_model_selection_suite(self):
        logging.basicConfig(level=logging.DEBUG)

        files = sorted(glob.glob(_PETAB_SELECT_MODEL_DIR+'/*/peta*.yaml'))
        self.assertTrue(len(files) > 0)
        for f in files:
            if '0009' in f:
                # skip test #9, because it is taking too long
                continue

            problem = petab_select.Problem.from_yaml(f)
            best = evaluate_problem(problem,
                                    temp_dir=os.path.join(_dir_name, 'temp_selection'),
                                    delete_temp_files=False)
            self.assertIsNotNone(best)
            # print(os.path.dirname(f), best.model_subspace_id, best.criteria)

            # read expected file
            expected_file = os.path.join(os.path.dirname(f), 'expected.yaml')
            # parse yaml file
            with open(expected_file, 'r') as stream:
                expected = yaml.safe_load(stream)
            self.assertEqual(expected['model_subspace_id'], best.model_subspace_id)
            self.assertListEqual(expected['model_subspace_indices'], best.model_subspace_indices)
            for p in best.estimated_parameters:
                self.assertAlmostEqual(expected['estimated_parameters'][p], best.estimated_parameters[p], 5)


if __name__ == '__main__':
    unittest.main()

