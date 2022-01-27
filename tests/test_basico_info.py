import unittest
import basico
import COPASI


class TestBasicoIO_Brus(unittest.TestCase):

    def setUp(self):
        dm = basico.load_example('brusselator')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())

    def test_get_species(self):
        species = basico.get_species('X')
        self.assertTrue(species.shape[0] == 1)

    def test_get_reaction_parameters(self):
        parameters = basico.get_reaction_parameters('k1')
        self.assertTrue(parameters.shape[0] == 4)
        parameters = basico.get_reaction_parameters('(R1).k1')
        self.assertTrue(parameters.shape[0] == 1)

    def test_set_reaction_parameters(self):
        parameters = basico.get_reaction_parameters('(R1).k1')
        self.assertEqual(parameters.shape[0], 1)
        value = parameters.iloc[0].value
        self.assertEqual(value, 1)
        basico.set_reaction_parameters('(R1).k1', value=2)
        value = basico.get_reaction_parameters('(R1).k1').iloc[0].value
        self.assertEqual(value, 2.0)

    def test_timecourse(self):
        data = basico.run_time_course()
        self.assertTrue(data.shape[1] == 2)
        basico.set_model_unit(substance_unit=1)
        data_stoch = basico.run_time_course(method='stochastic')
        self.assertTrue(data_stoch.shape[1] == 2)

    def test_steadystate(self):
        result = basico.run_steadystate()
        self.assertTrue(result == 1)

    def test_expressions(self):
        result = basico.model_info._split_by_cn('<CN=Root,Model=model0,Vector=Compartments[compartment],'
                                                'Vector=Metabolites[P],Reference=Concentration>*<CN=Root,Model='
                                                'model0,Vector=Values[epsilon],Reference=Value>+<CN=Root,Model='
                                                'model0,Vector=Values[offset],Reference=Value>')
        self.assertTrue(len(result) == 5)
        self.assertTrue(result[0] == 'CN=Root,Model=model0,Vector=Compartments[compartment],Vector='
                                     'Metabolites[P],Reference=Concentration')
        self.assertTrue(result[1] == '*')

        result = basico.model_info._split_by_cn('sin(A + B + C)')
        self.assertTrue(len(result) == 8)

    def test_notes(self):
        notes = basico.model_info.get_notes()
        self.assertTrue('The famous Brusselator' in notes)
        basico.model_info.set_notes("""
        
        New Multiline Comment
        
        """)
        new_notes = basico.model_info.get_notes()
        self.assertTrue('Multiline' in new_notes)

        metab_notes = basico.model_info.get_notes(name='[X]')
        self.assertTrue(metab_notes.strip() == '')
        basico.model_info.set_notes('Notes on the species X',  name='[X]')
        new_metab_notes = basico.model_info.get_notes(name='[X]')
        self.assertTrue('species X' in new_metab_notes)

    def test_events(self):
        events = basico.model_info.get_events()
        self.assertIsNone(events)
        basico.add_event('e0', trigger='Time > 10', assignments=[('[X]', '10')])
        events = basico.get_events('e0').reset_index()
        self.assertIsNotNone(events)
        d = events.to_dict(orient='record')[0]
        self.assertEqual(d['name'], 'e0')
        self.assertEqual(d['trigger'], 'Time > 10')
        self.assertEqual(d['assignments'][0]['target'], '[X]')
        self.assertEqual(d['assignments'][0]['expression'], '10')
        basico.model_info.add_event_assignment('e0', assignment=('[Y]', '2'))
        events = basico.get_events('e0').reset_index()
        d = events.to_dict(orient='record')[0]
        self.assertEqual(len(d['assignments']), 2)

    def test_matrices(self):
        jac = basico.model_info.get_jacobian_matrix(True)
        self.assertIsNotNone(jac)
        red = basico.model_info.get_reduced_jacobian_matrix()
        self.assertIsNotNone(red)
        stoich = basico.model_info.get_stoichiometry_matrix()
        self.assertIsNotNone(stoich)
        red_s = basico.model_info.get_reduced_stoichiometry_matrix()
        self.assertIsNotNone(red_s)

    def test_new_getter(self):
        tasks = basico.model_info.get_scheduled_tasks()
        self.assertEqual(len(tasks), 0)
        basico.set_scheduled_tasks(basico.T.TIME_COURSE)
        tasks = basico.model_info.get_scheduled_tasks()
        self.assertEqual(len(tasks), 1)
        cn = basico.model_info.get_cn('[X]')
        self.assertTrue('Metabolite' in cn)
        val = basico.model_info.get_value('[X]')
        self.assertIsNotNone(val)

    def test_amount(self):
        params = basico.get_parameters(type='assignment')
        self.assertIsNone(params)
        basico.add_amount_expressions()
        params2 = basico.get_parameters(type='assignment')
        self.assertIsNotNone(params2)
        basico.remove_amount_expressions()
        param3 = basico.get_parameters(type='assignment')
        self.assertIsNone(param3)

    def test_get_plots(self):
        result = basico.model_info.get_plots()
        self.assertEqual(len(result), 3)

    def test_add_plot(self):
        basico.model_info.add_plot('test', curves=[{'color': '#FF0000', 'channels': ['Time', '[X]']}])
        result = basico.model_info.get_plots()
        self.assertEqual(len(result), 4)
        plot = basico.model_info.get_plot_dict('test')
        self.assertTrue(len(plot['curves']) == 1)
        self.assertTrue(len(plot['curves'][0]['channels']) == 2)
        self.assertEqual(plot['curves'][0]['color'], '#FF0000')
        basico.model_info.remove_plot('test')
        result = basico.model_info.get_plots()
        self.assertEqual(len(result), 3)

    def test_collect_data(self):
        basico.add_parameter('quantity', initial_value=1)
        mod = basico.get_current_model().getModel()
        assert (isinstance(mod, COPASI.CModel))
        mod.applyInitialValues()
        data = basico.model_info._collect_data(cns=[
            'CN=Root,Model=The Brusselator,Reference=Time',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Reference=InitialVolume',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Reference=Rate',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Reference=Volume',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Vector=Metabolites[X],Reference=InitialParticleNumber',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Vector=Metabolites[X],Reference=ParticleNumber',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Vector=Metabolites[X],Reference=ParticleNumberRate',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Vector=Metabolites[X],Reference=Rate',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Vector=Metabolites[X],Reference=Concentration',
            'CN=Root,Model=The Brusselator,Vector=Compartments[compartment],Vector=Metabolites[X],Reference=InitialConcentration',
            'CN=Root,Model=The Brusselator,Vector=Values[quantity],Reference=Value',
            'CN=Root,Model=The Brusselator,Vector=Values[quantity],Reference=InitialValue',
            'CN=Root,Model=The Brusselator,Vector=Values[quantity],Reference=Rate',
            'CN=Root,Model=The Brusselator,Vector=Reactions[R1],Reference=Flux',
            'CN=Root,Model=The Brusselator,Vector=Reactions[R1],Reference=ParticleFlux',
            'CN=Root,Model=The Brusselator,Vector=Reactions[R1],ParameterGroup=Parameters,Parameter=k1,Reference=Value'
        ])

        data2 = basico.model_info._collect_data(names=[
            'Time',
            'Compartments[compartment].InitialVolume',
            'Compartments[compartment].Rate',
            'Compartments[compartment].Volume',
            'X.InitialParticleNumber',
            'X.ParticleNumber',
            'X.InitialParticleNumberRate',
            'X.ParticleNumberRate',
            'X.Rate',
            '[X]',
            '[X]_0',
            'Values[quantity]',
            'Values[quantity].InitialValue',
            'Values[quantity].Rate',
            '(R1).Flux',
            '(R1).ParticleFlux',
            '(R1).k1'
        ])
        self.assertTrue(data2 is not None)


class TestBasicoIO_LM(unittest.TestCase):

    def setUp(self):
        dm = basico.load_example('LM-test1')
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))
        self.assertTrue('Kinetics of a  Michaelian enzyme measured spectrophotometrically' in basico.model_io.overview())
        print('Running setup')

    def test_get_parameter(self):
        params = basico.get_parameters()
        self.assertEqual(params.shape[0], 3)
        params = basico.get_parameters('epsilon')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 0.78)

    def test_set_parameter(self):
        params = basico.get_parameters('epsilon')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 0.78)
        basico.set_parameters('epsilon', initial_value=2.0)
        params = basico.get_parameters('epsilon')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 2.0)
        basico.set_parameters('Values[epsilon]', initial_value=3.0)
        params = basico.get_parameters('Values[epsilon]')
        self.assertEqual(params.shape[0], 1)
        value = params.iloc[0].initial_value
        self.assertEqual(value, 3.0)


if __name__ == "__main__":
    unittest.main()
