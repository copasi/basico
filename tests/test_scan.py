import unittest
import basico


class TestScan(unittest.TestCase):
    def setUp(self):
        basico.load_example('brusselator')
        self.assertEqual(basico.get_current_model().getModel().getObjectName(), 'The Brusselator')

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

    def test_run_scan(self):
        result = basico.run_scan(settings=
                                 {
                                     'subtask': basico.T.STEADY_STATE,
                                     'output_during_subtask': False
                                 },
                                 scan_items=[{'item': '[A]_0', 'values': [0.5, 1, 2, 10]}],
                                 output=['[X]', '[Y]'])
        self.assertTrue(result is not None)


if __name__ == '__main__':
    unittest.main()
