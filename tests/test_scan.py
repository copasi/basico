import unittest
from pathlib import Path
import COPASI

import basico

@unittest.skipIf(COPASI.CVersion.VERSION.getVersionMinor() < 42, 'Require 4.42 of COPASI')
class TestParameterSetScan(unittest.TestCase):
    def setUp(self):
        example_path = Path(__file__).parent / 'test_data' / 'oscli_ps_scan.cps'
        basico.load_model(example_path)
        self.assertEqual(basico.get_current_model().getModel().getObjectName(), 'Oscli (Heinrich model)')

    def test_setttings(self):
        items = basico.get_scan_items()
        self.assertEqual(len(items), 1)
        d = basico.task_scan._scan_item_to_dict(0)
        self.assertEqual(d['type'], 'parameter_set')
        self.assertListEqual(d['parameter_sets'], ['oscillating', 'steadystate'])

        # set parameter sets to just 'steady_state'
        basico.set_scan_items([{'type': 'parameter_set', 'parameter_sets': ['steadystate']}])
        items = basico.get_scan_items()
        self.assertEqual(len(items), 1)
        d = basico.task_scan._scan_item_to_dict(0)
        self.assertEqual(d['type'], 'parameter_set')
        self.assertListEqual(d['parameter_sets'], ['steadystate'])

class TestScan(unittest.TestCase):
    def setUp(self):
        self.dm = basico.load_example('brusselator')
        self.assertEqual(basico.get_current_model().getModel().getObjectName(), 'The Brusselator')

    def tearDown(self):
        basico.remove_datamodel(self.dm)

    def test_simulation(self):
        result = basico.run_time_course(duration=10)
        self.assertIsNotNone(result)
        result2 = basico.run_time_course_with_output(output_selection=['Time', '[X]', 'Y'], duration=10)
        self.assertIsNotNone(result2)

    def test_scan_items(self):
        items = basico.get_scan_items()
        self.assertEqual(len(items), 1)
        d = basico.task_scan._scan_item_to_dict(0)
        self.assertEqual(d['type'], 'scan')
        d = basico.task_scan._scan_item_to_dict(1)
        self.assertTrue(d is None)

    def test_get_scan_settings(self):
        s = basico.get_scan_settings()
        self.assertTrue(s is not None)
        self.assertDictEqual(s,
                             {
                                 'scheduled': False,
                                 'update_model': False,
                                 'subtask': 'Steady-State',
                                 'output_during_subtask': False,
                                 'output_specification': [],
                                 'continue_from_current_state': False,
                                 'continue_on_error': False,
                                 'scan_items':
                                     [
                                         {
                                            'type': 'scan',
                                            'num_steps': 10,
                                            'log': False,
                                            'min': 0.5,
                                            'max': 2.0,
                                            'values': '',
                                            'use_values': False,
                                            'item': '(R1).k1',
                                            'cn': 'CN=Root,Model=The Brusselator,Vector=Reactions[R1],ParameterGroup=Parameters,Parameter=k1,Reference=Value'
                                         }
                                     ]
                             })

    def test_change_task_settings(self):
        basico.set_scan_settings(subtask=basico.T.TIME_COURSE)
        self.assertEqual(basico.get_scan_settings()['subtask'], basico.T.TIME_COURSE)
        basico.set_scan_settings(output_during_subtask=True)
        self.assertEqual(basico.get_scan_settings()['output_during_subtask'], True)
        basico.set_scan_settings(continue_from_current_state=True)
        self.assertEqual(basico.get_scan_settings()['continue_from_current_state'], True)
        basico.set_scan_settings(continue_on_error=True)
        self.assertEqual(basico.get_scan_settings()['continue_on_error'], True)
        basico.set_scan_settings(scan_items=[
            {
                'type': 'scan',
                'num_steps': 10,
                'min': 0.5,
                'max': 2.0,
                'item': '(R1).k1',
            }
        ])

        items = basico.get_scan_items()
        self.assertTrue(len(items), 1)
        basico.add_scan_item(item='(R2).k1', values=[0.1, 1, 2, 10])
        basico.add_scan_item(type='repeat', num_steps=10)
        basico.add_scan_item(type='random', distribution='normal', item='(R3).k1')
        items = basico.get_scan_items()
        self.assertTrue(len(items), 4)

    def test_output_specification(self):
        s = basico.get_scan_settings()
        self.assertTrue(s is not None)
        self.assertListEqual(s['output_specification'], [])
        self.assertEqual(s['output_during_subtask'], False)
        s2 = basico.get_task_settings(basico.T.SCAN)
        self.assertTrue(s2 is not None)
        self.assertEqual(s2['problem']['Subtask Output'], 'none')


        # during only 
        s['output_specification'] = ['During']
        basico.set_scan_settings(settings=s)
        s = basico.get_scan_settings()
        self.assertTrue(s is not None)
        self.assertListEqual(s['output_specification'], ['During'])
        self.assertEqual(s['output_during_subtask'], True)
        s2 = basico.get_task_settings(basico.T.SCAN)
        self.assertTrue(s2 is not None)
        self.assertEqual(s2['problem']['Subtask Output'], 'subTaskDuring')


        # before
        s['output_specification'] = 'before'
        basico.set_scan_settings(settings=s)
        s = basico.get_scan_settings()
        self.assertTrue(s is not None)
        self.assertListEqual(s['output_specification'], ['Before'])        
        self.assertEqual(s['output_during_subtask'], False)
        s2 = basico.get_task_settings(basico.T.SCAN)
        self.assertTrue(s2 is not None)
        self.assertEqual(s2['problem']['Subtask Output'], 'subTaskBefore')

        # during and after
        s['output_specification'] = ['During', 'After']
        basico.set_scan_settings(settings=s)
        s = basico.get_scan_settings()
        self.assertTrue(s is not None)
        self.assertListEqual(s['output_specification'], ['During', 'After'])
        self.assertEqual(s['output_during_subtask'], False)
        s2 = basico.get_task_settings(basico.T.SCAN)
        self.assertTrue(s2 is not None)
        self.assertEqual(s2['problem']['Subtask Output'], 'subTaskDuring|subTaskAfter')
        

    def test_run_scan(self):
        result = basico.run_scan(settings=
                                 {
                                     'subtask': basico.T.STEADY_STATE,
                                     'output_during_subtask': False
                                 },
                                 scan_items=[{'item': '[A]_0', 'values': [0.5, 1, 2, 10]}],
                                 output=['[X]', '[Y]'])
        self.assertTrue(result is not None)

    def test_setting_with_none(self):
        basico.set_scan_items([{'type': 'repeat', 'num_steps': 500, 'log': None, 'min': None, 'max': None}])
        items = basico.get_scan_items()
        self.assertIsNotNone(items)
        items[0]['num_steps'] = 1000
        basico.set_scan_items(items)
        items2 = basico.get_scan_items()
        self.assertDictEqual(items[0], items2[0])

    def test_set_parameter(self):
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_CN)
        basico.task_scan._set_parameter_from_value(p, 'test')
        self.assertTrue(p.getCNValue().getString(), 'test')
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_STRING)
        basico.task_scan._set_parameter_from_value(p, 'test')
        self.assertTrue(p.getStringValue(), 'test')
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_FILE)
        basico.task_scan._set_parameter_from_value(p, 'test')
        self.assertTrue(p.getFileValue(), 'test')
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_EXPRESSION)
        basico.task_scan._set_parameter_from_value(p, 'test')
        self.assertTrue(p.getStringValue(), 'test')
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_UDOUBLE)
        basico.task_scan._set_parameter_from_value(p, 1)
        self.assertTrue(p.getUDblValue(), 1)
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_DOUBLE)
        basico.task_scan._set_parameter_from_value(p, 1)
        self.assertTrue(p.getDblValue(), 1)
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_UINT)
        basico.task_scan._set_parameter_from_value(p, 1)
        self.assertTrue(p.getUIntValue(), 1)
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_INT)
        basico.task_scan._set_parameter_from_value(p, 1)
        self.assertTrue(p.getIntValue(), 1)
        p = COPASI.CCopasiParameter('test', COPASI.CCopasiParameter.Type_BOOL)
        basico.task_scan._set_parameter_from_value(p, True)
        self.assertTrue(p.getBoolValue(), True)


if __name__ == '__main__':
    unittest.main()
