import logging
from math import exp
import sys
import unittest
import basico
import COPASI


class TestBasicoIO_Brus(unittest.TestCase):

    def setUp(self):
        self.dm = basico.load_example('brusselator')
        self.assertTrue(self.dm is not None)
        self.assertTrue(isinstance(self.dm, COPASI.CDataModel))
        self.assertTrue('The Brusselator' in basico.model_io.overview())

    def test_get_species(self):
        species = basico.get_species('X')
        self.assertTrue(species.shape[0] == 1)

    def test_species_modification(self):
        basico.add_species('speciesB');
        basico.set_species('speciesB', exact=True, initial_concentration=0.4, status='fixed');
        species = basico.as_dict(basico.get_species('speciesB', exact=True))
        self.assertIsNotNone(species)
        self.assertAlmostEqual(species['initial_concentration'], 0.4)
        self.assertEqual(species['type'], 'fixed')

        basico.add_species('speciesC', initial_concentration=0.3, status='fixed');
        species = basico.as_dict(basico.get_species('speciesC', exact=True))
        self.assertIsNotNone(species)
        self.assertAlmostEqual(species['initial_concentration'], 0.3)
        self.assertEqual(species['type'], 'fixed')

        basico.add_species('speciesD', initial_particle_number=200, status='fixed');
        species = basico.as_dict(basico.get_species('speciesD', exact=True))
        self.assertIsNotNone(species)
        self.assertAlmostEqual(species['initial_particle_number'], 200)
        self.assertEqual(species['type'], 'fixed')

    def test_reaction_modifiers(self):
        basico.add_reaction('mod_r', 'species_A -> species_B', function='Allosteric inhibition (MWC)')
        reaction = basico.as_dict(basico.get_reactions('mod_r', exact=True))
        self.assertIsNotNone(reaction)
        # this should fail, since there is no modifier mapping
        self.assertNotEqual(reaction['function'], 'Allosteric inhibition (MWC)')

        # this should fail too, since the mapping does not apply
        basico.set_reaction('mod_r', function='Allosteric inhibition (MWC)', mapping={'non_existing': 'species_A'})
        reaction = basico.as_dict(basico.get_reactions('mod_r', exact=True))
        self.assertIsNotNone(reaction)
        self.assertNotEqual(reaction['function'], 'Allosteric inhibition (MWC)')

        # now again with inhibitor, this time it should work
        basico.set_reaction('mod_r', function='Allosteric inhibition (MWC)', mapping={'Inhibitor': 'species_A'})
        reaction = basico.as_dict(basico.get_reactions('mod_r', exact=True))
        self.assertIsNotNone(reaction)
        self.assertEqual(reaction['function'], 'Allosteric inhibition (MWC)')

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
        d = events.to_dict(orient='records')[0]
        self.assertEqual(d['name'], 'e0')
        self.assertEqual(d['trigger'], 'Time > 10')
        self.assertEqual(d['assignments'][0]['target'], '[X]')
        self.assertEqual(d['assignments'][0]['expression'], '10')
        basico.model_info.add_event_assignment('e0', assignment=('[Y]', '2'))
        events = basico.get_events('e0').reset_index()
        d = events.to_dict(orient='records')[0]
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
        self.dm = basico.load_example('LM-test1')
        self.assertTrue(self.dm is not None)
        self.assertTrue(isinstance(self.dm, COPASI.CDataModel))
        self.assertTrue('Kinetics of a  Michaelian enzyme measured spectrophotometrically' in basico.model_io.overview())

    def tearDown(self):
        basico.remove_datamodel(self.dm)

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
        basico.set_parameters('Values[epsilon]', initial_value=3.0, value=5.0)
        params = basico.as_dict(basico.get_parameters('Values[epsilon]'))
        self.assertEqual(params['initial_value'], 3.0)
        self.assertEqual(params['value'], 5.0)

    def test_mapping(self):
        m = basico.get_reaction_mapping('R1')
        self.assertDictEqual(m, {'k1': 130.0, 'substrate': ['S', 'E'], 'k2': 1.0, 'product': 'ES'})
        basico.set_reaction_mapping('R1', {'k1': 10})
        m = basico.get_reaction_mapping('R1')
        self.assertEqual(m['k1'], 10)
        basico.add_reaction('R3', 'S + E + ES = C + D + F')
        m = basico.get_reaction_mapping('R3')
        self.assertListEqual(m['product'], ['C', 'D', 'F'])
        basico.set_reaction_mapping('R3', {'product': ['S', 'E']})
        m = basico.get_reaction_mapping('R3')
        self.assertListEqual(m['product'], ['S', 'E', 'F'])

        # add new reaction with hill kinetics
        basico.add_reaction('R4', 'S -> E', function='Hill Cooperativity')
        basico.add_parameter('hillcoeff')
        basico.add_parameter('K_ER_1')
        basico.add_parameter('v_ER_1')
        basico.add_species('Ca_1')
            
        m1 = basico.get_reaction_mapping('R4')
        basico.set_reaction_mapping('R4', {'h': 2.0, 'substrate': 'Ca_1', 'Shalve': 'K_ER_1', 'V': 'v_ER_1'})
        m2 = basico.get_reaction_mapping('R4')
        self.assertEqual(m2['substrate'], 'Ca_1')
        self.assertEqual(m2['Shalve'], 'K_ER_1')
        self.assertEqual(m2['V'], 'v_ER_1')
        self.assertEqual(m2['h'], 2.0)
        basico.set_reaction_mapping('R4', {'h': 2.0, 'substrate': 'Ca_1', 'Shalve': 0.1, 'V': 0.1})
        m3 = basico.get_reaction_mapping('R4')
        self.assertEqual(m3['Shalve'], 0.1)
        self.assertEqual(m3['V'], 0.1)
        basico.set_reaction_mapping('R4', {'substrate': 'Ca_1', 'Shalve': 'K_ER_1', 'V': 'v_ER_1', 'h': 'hillcoeff'})
        m4 = basico.get_reaction_mapping('R4')
        self.assertEqual(m4['Shalve'], 'K_ER_1')
        self.assertEqual(m4['V'], 'v_ER_1')
        self.assertEqual(m4['h'], 'hillcoeff')


        

    @unittest.skipIf(sys.version_info < (3, 6, 0), 'This test requires assertLogs which is not available before')
    def test_invalid_expression(self):
        self.assertLogs(
            basico.add_parameter(
                'invald', type='assignment',
                expression='Values[offset] .InitialValue + Values[signal] .InitialValue'))

        self.assertLogs(
            basico.add_parameter(
                'invald2',
                initial_expression='Values[offset] .InitialValue + Values[signal] .InitialValue'))

        # check that the interpreter did not crash
        self.assertTrue(True)


class TestBasicoModelConstruction(unittest.TestCase):

    def setUp(self):
        self.dm = basico.new_model(name='Test Model')
        basico.remove_user_defined_functions()

    def tearDown(self):
        basico.remove_datamodel(self.dm)

    def test_units(self):
        basico.set_model_unit(time_unit='s', quantity_unit='mmol', volume_unit='ml',
                              area_unit='cm*cm', length_unit='cm')
        units = basico.get_model_units()
        self.assertEqual(units['time_unit'], 's')
        self.assertEqual(basico.get_time_unit(), 's')
        self.assertEqual(units['quantity_unit'], 'mmol')
        self.assertEqual(units['volume_unit'], 'ml')

    def test_species(self):
        basico.add_species('A', initial_concentration=10)

        # set and get notes
        basico.set_notes('Notes on the species A', name='A')
        notes = basico.get_notes(name='A')
        self.assertTrue('Notes on the species A' in notes)

        a = basico.as_dict(basico.get_species('A'))
        self.assertIsNotNone(a)
        self.assertAlmostEqual(a['initial_concentration'], 10)
        basico.set_species('A', concentration=5)
        a = basico.as_dict(basico.get_species('A'))
        self.assertAlmostEqual(a['concentration'], 5.0)
        basico.set_species('A', exact=True, initial_expression=' 1 / {Time}', expression='{Time}', status='assignment')
        a = basico.as_dict(basico.get_species('A'))
        self.assertEqual(a['type'], 'assignment')
        self.assertEqual(a['expression'], 'Time')
        self.assertEqual(a['initial_expression'], '')

        basico.set_element_name('A', new_name='A0')

        basico.remove_species('A0')
        self.assertIsNone(basico.get_species('A0', exact=True))

    def test_annotation(self):
        basico.add_species('A', initial_concentration=10)
        basico.set_miriam_annotation(name='A', descriptions=[{'id': 'P09560',
   'qualifier': 'is version of',
   'uri': 'http://identifiers.org/uniprot/P09560',
   'resource': 'UniProt Knowledgebase'}])

        annot = basico.get_miriam_annotation(name='A')
        if 'unknown' in annot['descriptions'][0]['id']:
            # this means that annotations have not yet been initialized on the machine
            # this is expected to happen on CI
            self.assertTrue('P09560' in annot['descriptions'][0]['id'])
        else:
            self.assertEqual(annot['descriptions'][0]['id'], 'P09560')

    def test_compartment(self):
        basico.add_compartment('v',  initial_size=2)

        # set and get notes
        basico.set_notes('Notes on the compartment v', name='v')
        notes = basico.get_notes(name='v')
        self.assertTrue('Notes on the compartment v' in notes)

        v = basico.get_compartments('v', exact=True)
        self.assertIsNotNone(v)
        basico.set_compartment('v',  size=3)
        v = basico.as_dict(basico.get_compartments('v', exact=True))
        self.assertAlmostEqual(v['size'], 3)
        basico.set_compartment('v', exact=True, initial_expression=' 1 / {Time}',
                               expression='{Time}', status='assignment')
        v = basico.as_dict(basico.get_compartments('v'))
        self.assertEqual(v['type'], 'assignment')
        self.assertEqual(v['expression'], 'Time')
        self.assertEqual(v['initial_expression'], '')
        self.assertEqual(v['dimensionality'], 3)


        # change dimensions to two
        basico.set_compartment('v', exact=True, dimensionality=2)
        v_df = basico.get_compartments('v')
        v = basico.as_dict(v_df)
        self.assertEqual(v['dimensionality'], 2)

        basico.set_compartment('v', exact=True, dimensionality=v['dimensionality'])
        basico.set_compartment('v', exact=True, dimensionality=v_df.iloc[0]['dimensionality'])

        # apply all recorded changes
        basico.set_compartment(exact=True, **v)
        

        basico.remove_compartment('v')
        self.assertIsNone(basico.get_compartments('v', exact=True))


    def test_global_parameters(self):
        basico.add_parameter('p', initial_value=3)
        v = basico.get_parameters('p', exact=True)
        self.assertIsNotNone(v)
        basico.set_parameters('p', exact=True, initial_expression=' 1 / {Time}', expression='{Time}',
                              status='assignment')
        v = basico.as_dict(basico.get_parameters('p'))
        self.assertEqual(v['type'], 'assignment')
        self.assertEqual(v['expression'], 'Time')
        self.assertEqual(v['initial_expression'], '')
        basico.remove_parameter('p')
        self.assertIsNone(basico.get_parameters('v', exact=True))

    def test_functions(self):
        basico.add_function('fun', infix='v * S / (k + S)', mapping={'S': 'substrate'})

        # set and get notes
        basico.set_notes('Notes on the function fun', name='fun')
        notes = basico.get_notes(name='fun')
        self.assertTrue('Notes on the function fun' in notes)

        fun = basico.as_dict(basico.get_functions('fun', exact=True))
        self.assertIsNotNone(fun)
        self.assertEqual(fun['reversible'], False)
        self.assertEqual(fun['formula'], 'v * S / (k + S)')
        self.assertEqual(fun['mapping']['S'], 'substrate')
        basico.remove_function('fun')
        fun = basico.as_dict(basico.get_functions('fun', exact=True))
        self.assertIsNone(fun)

    def test_events(self):
        basico.add_parameter('p0', initial_value=10)
        basico.add_event('e0', trigger='Time > 10', assignments=[('Values[p0]', 1)],
                         fire_at_initial_time=True, persistent=True, delay_calculation=False)
        
        # set and get notes
        basico.set_notes('Notes on the event e0', name='e0')
        notes = basico.get_notes(name='e0')
        self.assertTrue('Notes on the event e0' in notes)

        e = basico.as_dict(basico.get_events('e0', exact=True))
        self.assertIsNotNone(e)
        self.assertEqual(e['trigger'], 'Time > 10')
        self.assertEqual(e['assignments'][0]['target'], 'Values[p0]')
        self.assertEqual(e['assignments'][0]['expression'], '1')
        self.assertEqual(e['fire_at_initial_time'], True)
        self.assertEqual(e['persistent'], True)
        self.assertEqual(e['delay_calculation'], False)
        basico.remove_event('e0', exact=True)
        e = basico.as_dict(basico.get_events('e0', exact=True))
        self.assertIsNone(e)

    def test_reactions(self):
        basico.add_reaction('r0', 'A -> B')

        # set and get notes
        basico.set_notes('Notes on the reaction r0', name='r0')
        notes = basico.get_notes(name='r0')
        self.assertTrue('Notes on the reaction r0' in notes)

        r0 = basico.as_dict(basico.get_reactions('r0', exact=True))
        self.assertIsNotNone(r0)
        self.assertEqual(r0['scheme'], 'A -> B')
        self.assertEqual(r0['function'], 'Mass action (irreversible)')
        self.assertEqual(r0['mapping']['substrate'], 'A')

        others = basico.as_dict(basico.get_functions(suitable_for='r0'))
        self.assertIsNotNone(others)
        constant = [x for x in others if 'Constant flux' in x['name']]
        self.assertIsNotNone(constant)

        basico.remove_reaction('r0')
        r0 = basico.as_dict(basico.get_reactions('r0', exact=True))
        self.assertIsNone(r0)

    def test_mapping_volumes(self):
        basico.add_function(name='Uni-molecular transport', type='irreversible',
                     infix='Vol*k1*S',
                     mapping={'Vol': 'volume', 'k1': 'parameter', 'S':
                         'substrate'})

        i = 0
        j = 0
        compname = 'cell[{},{}]'.format(i, j)
        basico.add_compartment(name=compname)
        app = '_{},{}'.format(i, j)
        vol1 = compname
        ngb = app
        basico.add_parameter('T0.r_MxferWG')
        basico.add_reaction(name=f'R31_1{app}', scheme=f'EWG1{app} -> EWG4{ngb}', function='Uni-molecular transport',
                     mapping={'Vol': vol1, 'k1':
                         'T0.r_MxferWG'})
        data = basico.as_dict(basico.get_reactions(name=f'R31_1{app}'))
        self.assertEqual(data['function'], 'Uni-molecular transport')
        self.assertDictEqual(data['mapping'], {'Vol': 'cell[0,0]', 'k1': 'T0.r_MxferWG', 'S': 'EWG1_0,0'})

        # ensure this does not crash
        vol1 = 'Compartments[cell[{},{}]].Volume'.format(i, j)
        basico.add_reaction(name=f'R32_1{app}', scheme=f'EWG1{app} -> EWG4{ngb}', function='Uni-molecular transport',
                            mapping={'Vol': vol1, 'k1':
                                'T0.r_MxferWG'})

    def test_parameter_sets(self):
        dm = basico.load_example('LM')
        sol = basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION, create_parametersets=True)
        psets = basico.get_parameter_sets()
        self.assertEqual(len(psets), 6)
        psets = basico.get_parameter_sets(name='Original')
        self.assertEqual(len(psets), 1)

        # remove a specific parameter set
        basico.remove_parameter_sets(name='Original')
        self.assertEqual(len(basico.get_parameter_sets()), 5)

        # add parameter set from model
        basico.add_parameter_set(name='Current State')
        current_state = basico.get_parameter_sets(name='Current State', exact=True);
        self.assertEqual(len(current_state), 1)


        # remove all parameter sets
        basico.remove_parameter_sets()
        self.assertEqual(len(basico.get_parameter_sets()), 0)

        # add parameter set from dictionary
        basico.add_parameter_set(name='Original', param_set_dict=psets[0])

        new_set = basico.get_parameter_sets()
        self.assertEqual(len(new_set), 1)
        self.assertDictEqual(psets[0]['Initial Time'], new_set[0]['Initial Time'])
        self.assertDictEqual(psets[0]['Initial Compartment Sizes'], new_set[0]['Initial Compartment Sizes'])
        self.assertDictEqual(psets[0]['Initial Species Values'], new_set[0]['Initial Species Values'])
        self.assertDictEqual(psets[0]['Initial Global Quantities'], new_set[0]['Initial Global Quantities'])
        self.assertDictEqual(psets[0]['Kinetic Parameters'], new_set[0]['Kinetic Parameters'])

        # apply a parameter set to model
        basico.apply_parameter_set(name='Original')

        # update parameter set from model
        basico.update_parameter_set(name='Original')

        # manually set parameter set to dictionary
        basico.set_parameter_set(name='Original', param_set_dict=psets[0])
        new_set = basico.get_parameter_sets()
        self.assertEqual(len(new_set), 1)

        self.assertDictEqual(psets[0]['Initial Time'], new_set[0]['Initial Time'])
        self.assertDictEqual(psets[0]['Initial Compartment Sizes'], new_set[0]['Initial Compartment Sizes'])
        self.assertDictEqual(psets[0]['Initial Species Values'], new_set[0]['Initial Species Values'])
        self.assertDictEqual(psets[0]['Initial Global Quantities'], new_set[0]['Initial Global Quantities'])
        self.assertDictEqual(psets[0]['Kinetic Parameters'], new_set[0]['Kinetic Parameters'])

        simple_set = basico.get_parameter_sets(values_only=True)
        basico.set_parameter_set(name='Original',param_set_dict=simple_set[0])

        # now test whether the changes actually work
        basico.remove_parameter_sets()
        basico.add_parameter_set(name='Current State')
        basico.add_parameter_set(name='ToModify')

        # try a partial set
        basico.add_parameter_set(name='Partial',
                                 param_set_dict={
                                     'Initial Compartment Sizes': {'compartment': 1},
                                     'Initial Species Values': {'S': 2, 'E': 1}})

        # try changing just the initial concentration os some species
        basico.set_parameter_set(name='ToModify',
                                 param_set_dict={'Initial Species Values': {'S': 5, 'E': 0.1, 'nonexisting': 2}},
                                 remove_others=False)
        simple_set = basico.get_parameter_sets(values_only=True)
        self.assertEqual(simple_set[1]['Initial Species Values']['S'], 5)
        self.assertEqual(simple_set[1]['Initial Species Values']['E'], 0.1)

        # apply the parameter set
        basico.apply_parameter_set(name='ToModify')

        # look at actual model state
        species_list = basico.as_dict(basico.get_species())
        specis_dict = {d['name']: d for d in species_list}
        self.assertEqual(specis_dict['S']['initial_concentration'], 5)

        basico.remove_datamodel(dm)

    def test_retrieval_from_multiple_models(self):
        dm1 = basico.load_example('bruss')
        basico.add_parameter('xy_sum', expression='[X] + [Y]', type='assignment')
        basico.add_parameter('xy_initial_half', expression='Values[xy_sum].InitialValue / 2', type='assignment')
        param1 =  basico.as_dict(basico.get_parameters())
        dm2 = basico.new_model(name='empty')
        param2 = basico.as_dict(basico.get_parameters(model=dm1))
        self.assertEqual(len(param1), len(param2))
        self.assertEqual(param1[0]['expression'], param2[0]['expression'])
        self.assertEqual(param1[1]['expression'], param2[1]['expression'])
        basico.remove_datamodel(dm1)
        basico.remove_datamodel(dm2)

    def test_expresssions(self):
        dm = basico.new_model(name='Test Model');
        basico.add_species('X');
        basico.add_species('Y');
        basico.add_parameter('a', initial_value=1);

        basico.add_parameter('b', initial_value=1);
        basico.set_parameters('b', exact=True, expression='{Values[a].InitialValue}/2', status='assignment')
        params1 = basico.as_dict(basico.get_parameters(type='assignment'))
        basico.set_parameters('b', exact=True, expression='Values[a].InitialValue/2', status='assignment')
        params2 = basico.as_dict(basico.get_parameters(type='assignment'))

        basico.add_parameter('c', initial_value=1);
        basico.set_parameters('c', exact=True, expression='{[X]}+{[Y]}', status='assignment')
        params31 = basico.as_dict(basico.get_parameters(type='assignment'))
        basico.set_parameters('c', exact=True, expression=' {[X]} + {[Y]}', status='assignment')
        params3 = basico.as_dict(basico.get_parameters(type='assignment'))
        basico.set_parameters('c', exact=True, expression=' [X] + [Y]', status='assignment')
        params4 = basico.as_dict(basico.get_parameters(type='assignment'))
        params = basico.as_dict(basico.get_parameters(type='assignment'))


        basico.remove_datamodel(dm);

    def test_multiple_elements_with_same_name(self):
        dm = basico.new_model(name='Test Model');

        basico.add_reaction('R1', ' -> "Time"')
        basico.add_compartment('Time')
        basico.add_parameter('Time', initial_value=1)

        result = basico.run_time_course()
        self.assertListEqual(result.columns.tolist(), ['Time', 'Time'])

        result2 = basico.run_time_course_with_output(['Time', '[Time]'])
        self.assertListEqual(result2.columns.tolist(), ['Time', '[Time]'])

        names = basico.model_info._get_name_map(dm)
        self.assertGreater(len(names['Time']), 1)

        did_rename = basico.ensure_unique_names()
        self.assertTrue(did_rename)

        names2 = basico.model_info._get_name_map(dm)
        self.assertEqual(len(names2['Time']), 1)

        basico.remove_datamodel(dm);

if __name__ == "__main__":
    unittest.main()
