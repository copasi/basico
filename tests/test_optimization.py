import unittest
import basico
import COPASI


class TestOptimization(unittest.TestCase):
    def setUp(self):
        self.dm = basico.new_model(name='Himmelblau')
        self.assertTrue(self.dm is not None)
        self.assertTrue(isinstance(self.dm, COPASI.CDataModel))
        basico.add_parameter('x', initial_value=0)
        basico.add_parameter('y', initial_value=0)
        basico.add_parameter('f', type='assignment',
                             expression='({Values[x].InitialValue}^2+{Values[y].InitialValue}-11)^2+({Values[x].InitialValue}+{Values[y].InitialValue}^2-7)^2')

    def tearDown(self):
        basico.remove_datamodel(self.dm)

    def test_optitems(self):
        self.assertIsNone(basico.get_opt_parameters())
        template = basico.get_opt_item_template(include_global=True)
        basico.set_opt_parameters(template)
        items = basico.get_opt_parameters()
        self.assertIsNotNone(items)

    def test_settings(self):
        settings = basico.get_opt_settings()
        self.assertIsNotNone(settings)
        self.assertEqual(settings['expression'], '')
        basico.set_objective_function('Values[f].InitialValue', minimize=True)
        settings = basico.get_opt_settings()
        self.assertEqual(settings['expression'], 'Values[f].InitialValue')
        basico.set_opt_settings({'subtask': basico.T.TIME_COURSE})
        self.assertEqual(basico.get_opt_settings()['subtask'], basico.T.TIME_COURSE)

    def test_optimization(self):
        template = basico.get_opt_item_template(include_global=True)
        basico.set_opt_parameters(template)
        basico.set_objective_function('Values[f].InitialValue', minimize=True)
        basico.set_opt_settings(settings={
            'subtask': basico.T.TIME_COURSE,
            'method': {'name': basico.PE.LEVENBERG_MARQUARDT}})
        result = basico.run_optimization()
        self.assertIsNotNone(result)
        stat = basico.get_opt_statistic()
        self.assertIsNotNone(stat)
        self.assertLess(stat['obj'], 1e-6)

    def test_custom_output(self):
        dh, col = basico.create_data_handler([
            # # int values not supported in COPASI 4.35 and below
            # 'CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Function Evaluations',
            'CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Value'
        ])
        c_list = COPASI.ContainerList()
        c_list.append(self.dm)
        self.assertTrue(dh.compile(c_list))


if __name__ == '__main__':
    unittest.main()
