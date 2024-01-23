# coding: utf-8
import unittest
import basico
import basico.model_info


class TestBasicoModelManipulation(unittest.TestCase):

    def setUp(self):
        self.model = basico.new_model(name='Test Model')
        self.assertTrue(self.model.getModel().getObjectName() == 'Test Model')

    def test_add_compartment(self):
        basico.add_compartment('c', 1.0)
        c = basico.as_dict(basico.get_compartments('c'))
        self.assertAlmostEqual(c['initial_size'], 1)
        basico.set_compartment('c', initial_size=2)
        c = basico.as_dict(basico.get_compartments('c'))
        self.assertAlmostEqual(c['initial_size'], 2)

    def test_add_species(self):
        basico.add_species('X')
        s = basico.as_dict(basico.get_species('X'))
        self.assertAlmostEqual(s['initial_concentration'], 1)
        c = basico.as_dict(basico.get_compartments('compartment'))
        self.assertAlmostEqual(c['initial_size'], 1)
        basico.set_species('X', initial_concentration=2)
        s = basico.as_dict(basico.get_species('X'))
        self.assertAlmostEqual(s['initial_concentration'], 2)

    def test_add_event(self):
        basico.add_event('e0', 'Time > 10', [['X', '0']])
        e = basico.get_events('e0')
        self.assertEqual(str(e.iloc[0]['trigger']), 'Time > 10')

    def test_add_reaction(self):
        basico.add_reaction('r0', 'X -> Y')
        r = basico.get_reactions('r0')
        self.assertEqual(str(r.iloc[0]['scheme']), 'X -> Y')
        params = basico.get_reaction_parameters(reaction_name='r0')
        self.assertEqual(params.loc['(r0).k1'].value, 0.1)
        basico.set_reaction_parameters('(r0).k1', value=1)
        params = basico.get_reaction_parameters(reaction_name='r0')
        self.assertEqual(params.loc['(r0).k1'].value, 1)

    def test_add_parameter(self):
        basico.add_parameter('sin_time', type='assignment', expression='sin({Time})')
        p = basico.get_parameters('sin_time')
        self.assertEqual('assignment', str(p.iloc[0]['type']))
        self.assertEqual('sin ( Time )', str(p.iloc[0]['expression']))
        basico.remove_parameter('sin_time')

    def test_set_annotation(self):
        if not basico.have_miriam_resources():
            basico.update_miriam_resources()

        basico.set_miriam_annotation(
            creators=[
                {
                    'first_name': 'Frank',
                    'last_name': 'Bergmann',
                    'email': 'fbergman@caltech.edu',
                    'organization': 'Heidelberg University'}
            ],

        )

        self.assertTrue(basico.have_miriam_resources())

        annotations = basico.get_miriam_annotation()
        self.assertEqual(len(annotations['creators']), 1)
        self.assertEqual(annotations['creators'][0]['first_name'], 'Frank')
        self.assertEqual(annotations['creators'][0]['last_name'], 'Bergmann')
        self.assertEqual(annotations['creators'][0]['email'], 'fbergman@caltech.edu')
        self.assertEqual(annotations['creators'][0]['organization'], 'Heidelberg University')

        basico.set_miriam_annotation(descriptions=[
          {
            'qualifier': 'is',
            'resource': 'BioModels Database',
            'id': 'MODEL6623915522',
          }
        ])

        annotations = basico.get_miriam_annotation()
        self.assertEqual(len(annotations['descriptions']), 1)
        self.assertEqual(annotations['descriptions'][0]['qualifier'], 'is')
        self.assertEqual(annotations['descriptions'][0]['resource'], 'BioModels Database')
        self.assertEqual(annotations['descriptions'][0]['id'], 'MODEL6623915522')

        basico.set_miriam_annotation(references=[
          {
            'id': '10951190',
            'resource': 'PubMed',
          }
        ])

        annotations = basico.get_miriam_annotation()
        self.assertEqual(len(annotations['references']), 1)
        self.assertEqual(annotations['references'][0]['id'], '10951190')
        self.assertEqual(annotations['references'][0]['resource'], 'PubMed')

    def test_add_ode(self):
        basico.add_equation('d[PG]/dt=([E]/((k_4 [7-ADCA])/K_n +(k_5 [7-ADCA])/K_n +(k_6 [PGME])/K_si +k3))((k_2 [PGME])/K_s   +(k_4b [CEX])/K_p )(k_3+(k_5 [7-ADCA])/K_n   +(k_6 [PGME])/K_si )')
        basico.add_equation(
            'd[CEX]/dt=(k_2 [E][PGME])/K_s -([E]/((k_4 [7-ADCA])/K_n +(k_5 [7-ADCA])/K_n +(k_6 [PGME])/K_si +k3))((k_2 [PGME])/K_s   +(k_4b [CEX])/K_p )(k_3+(k_5 [7-ADCA])/K_n )')
        basico.add_equation(
            '[E]=([EA]_0 exp(-k_d t))/(1+([PGME])/K_s + ((k_2 [PGME])/(K_s ((k_4 [7-ADCA])/K_n +(k_5 [7-ADCA])/K_n +(k_6 [PGME])/K_si +k3) ))(1+([7-ADCA])/K_n +([PGME])/K_si )+([CEX])/K_p +([PG])/K_p2i )')
        basico.add_equation('d[S1]/dt=-r_s1*w_1*[B]')
        species = basico.get_species()
        self.assertEqual(species.loc['PG'].type, 'ode')
        self.assertEqual(species.loc['S1'].type, 'ode')
        self.assertEqual(species.loc['PG'].expression, '[E] / ( Values[k_4] * [7-ADCA] / Values[K_n] + Values[k_5] * [7-ADCA] / Values[K_n] + Values[k_6] * [PGME] / Values[K_si] + Values[k3] ) * ( Values[k_2] * [PGME] / Values[K_s] + Values[k_4b] * [CEX] / Values[K_p] ) * ( Values[k_3] + Values[k_5] * [7-ADCA] / Values[K_n] + Values[k_6] * [PGME] / Values[K_si] )')
        self.assertEqual(species.loc['E'].type, 'assignment')
        self.assertEqual(species.loc['E'].expression, '[EA]_0 * exp ( - Values[k_d] * Time ) / ( 1 + [PGME] / Values[K_s] + Values[k_2] * [PGME] / ( Values[K_s] * ( Values[k_4] * [7-ADCA] / Values[K_n] + Values[k_5] * [7-ADCA] / Values[K_n] + Values[k_6] * [PGME] / Values[K_si] + Values[k3] ) ) * ( 1 + [7-ADCA] / Values[K_n] + [PGME] / Values[K_si] ) + [CEX] / Values[K_p] + [PG] / Values[K_p2i] )')

        basico.add_equation('obs=sin(t)')
        self.assertEqual(basico.get_parameters().loc['obs'].type, 'assignment')
        self.assertEqual(basico.get_parameters().loc['obs'].expression, 'sin ( Time )')

        # encountered an odd issue when pasting in equations with unicode characters
        tokens = basico.model_info._tokenize_eqn(u'[E]=([E]_0  exp⁡(-k_d t))/(1+[PGME]/K_s +[PGME]^2/(K_s K_si )+[7-ADCA]/K_n +((k_2 [PGME])/(K_s ((k_4 [7-ADCA])/K_n +(k_5 [7-ADCA])/K_n +k3) ))((k_2 [PGME])/K_s   +(k_7 [PGME]^2)/(K_s K_si )+(k_4b [CEX])/K_p )(1+[7-ADCA]/K_n +[PGME]/K_si )+[CEX]/K_p +[PG]/K_p2i )')
        self.assertTrue(tokens is not None)
        self.assertEqual(tokens['tokens'][3], 'exp')

    def test_add_function(self):
        # add
        basico.add_function('MA KD', 'vr*(K_d-1)')
        funs = basico.get_functions('MA KD')
        self.assertTrue(funs is not None)
        fun = funs.iloc[0]
        self.assertEqual(fun.reversible, False)
        self.assertEqual(fun.formula, 'vr*(K_d-1)')
        self.assertEqual(fun.general, True)
        # remove
        basico.remove_function('MA KD')
        funs = basico.get_functions('MA KD')
        self.assertTrue(funs is None)

    def test_change_mapping(self):
        basico.add_function('MA Keq', 'vr*(Keq-1)')
        basico.add_parameter('K_d', initial_value=1)
        basico.add_reaction('r1 ma keq', scheme='A -> B', function='MA KD', mapping={'vr': 1000, 'Keq': 'K_d'})

    def test_expressions(self):
        basico.new_model(name='Model 4', volume_unit='ml', quantity_unit='mmol')

        basico.add_species('PGME', initial_concentration=20)
        basico.add_species('7-ADCA', initial_concentration=10)
        basico.add_species('CEX', initial_concentration=0)
        basico.add_species('PG', initial_concentration=2)

        params = ['K_s', 'k2',  'K_n', 'k3',  'k4',  'k5',  'k6',   'K_si', 'K_p', 'k_4b',  'e0', 'kd', 'K_p2i']
        values = [14,25920,290,25020,4416000,29460,99600,20,39,547560,0.000198000000000000,0.0385800000000000,12]
        for k, v in zip(params, values):
            basico.add_parameter(k, initial_value=v)

        basico.add_equation('A = k4 * [7-ADCA] / K_n + k5 * [7-ADCA] / K_n + k6 * [PGME] / K_si + k3')
        basico.add_equation('e = e0 /(1 + [PGME]^2/ (K_s * K_si) + [7-ADCA] / K_n + ( k2 * [PGME] /(K_s * A))*( 1 + [7-ADCA]/K_n + [PGME]/K_si)+[CEX]/K_p+[PG]/K_p2i)*exp(-kd*t)')
        basico.add_equation('B = (k2 * e * [PGME]/K_s)*(1/A) + (k_4b * e * [CEX]/K_p)*(1/A)')

        dxdt_1 = '-k2 * e * [PGME]/K_s - k6 * B * [PGME]/K_si'
        dxdt_4 = 'B * (k3 + k5*[7-ADCA]/K_n + k6* [PGME]/K_si)'
        dxdt_3 = '-({0}) - ({1})'.format(dxdt_1, dxdt_4)
        dxdt_2 = '-({0})'.format(dxdt_3)
        basico.add_equation('d[PGME]/dt=' + dxdt_1)
        basico.add_equation('d[PG]/dt=' + dxdt_4)
        basico.add_equation('d[CEX]/dt=' + dxdt_3)
        basico.add_equation('d[7-ADCA]/dt=' + dxdt_2)

        template = basico.get_fit_item_template(include_global=True, default_lb=1e-2, default_ub=1e6)
        to_remove = None
        for d in template:
            # set lower bound for the equilibrium constants
            if 'Values[K_si' in d['name']:
                d['upper'] = 50
                continue
            if 'Values[K' in d['name']:
                d['upper'] = 1000
                continue
            if 'Values[k_d' in d['name']:
                d['upper'] = 0.5
                d['lower'] = 0.3

        basico.set_fit_parameters(template)

        self.assertTrue(True)

    def test_lorenz_with_spaces(self):
        dm = basico.new_model(name='Lorenz', volume_unit='ml', quantity_unit='mmol')
        basico.add_equation('d[X]/dt = sigma * ( [Y] - [X] )')
        basico.add_equation('d[Y]/dt    =   [X]  *  (  rho  -  [Z] ) - [Y]')
        basico.add_equation('d[Z]/dt =    [X]  *   [Y]    -    beta * [Z] ')
        species = basico.as_dict(basico.get_species())
        self.assertEqual(species[0]['expression'], 'Values[sigma] * ( [Y] - [X] )')
        self.assertEqual(species[1]['expression'], '[X] * ( Values[rho] - [Z] ) - [Y]')
        self.assertEqual(species[2]['expression'], '[X] * [Y] - Values[beta] * [Z]')


class TestReportManipulation(unittest.TestCase):

    def setUp(self):
        self.model = basico.load_example('bruss')
        self.assertTrue(self.model.getModel().getObjectName() == 'The Brusselator')

    def test_get_report(self):
        reports = basico.get_reports()
        self.assertTrue(reports is not None)
        self.assertEqual(len(reports), 11)
        reports = basico.get_reports(ignore_automatic=True)
        self.assertTrue(reports is None)
        reports = basico.get_reports(name='Steady')
        self.assertTrue(reports is not None)
        self.assertEqual(len(reports), 1)
        reports = basico.get_reports(task=basico.T.STEADY_STATE)
        self.assertTrue(reports is not None)
        self.assertEqual(len(reports), 1)

        r = basico.get_report_dict(0)
        self.assertTrue('task' in r)
        self.assertEqual(r['task'], basico.T.STEADY_STATE)
        r = basico.get_report_dict(basico.T.STEADY_STATE)
        self.assertTrue('task' in r)
        self.assertEqual(r['task'], basico.T.STEADY_STATE)

    def test_add_report(self):
        reports = basico.get_reports()
        self.assertTrue(reports is not None)
        self.assertEqual(len(reports), 11)
        basico.add_report('Simple Report', table=['Time', '[X]', '[Y]'], print_headers=True, precision=6, separator='\t')

        r = basico.get_report_dict('Simple Report')
        self.assertTrue(r is not None)
        self.assertTrue('table' in r)
        self.assertTrue('header' not in r)
        self.assertTrue('body' not in r)
        self.assertTrue('footer' not in r)
        self.assertEqual(r['name'], 'Simple Report')
        self.assertEqual(r['print_headers'], True)
        self.assertEqual(r['separator'], '\t')
        self.assertEqual(r['precision'], 6)
        self.assertListEqual(r['table'], ['Time', '[X]', '[Y]'])

        basico.set_report_dict('Simple Report', task=basico.T.STEADY_STATE, footer=['[A]', '[B]'])
        r = basico.get_report_dict('Simple Report')
        self.assertTrue(r is not None)
        self.assertTrue('table' not in r)
        self.assertTrue('header' in r)
        self.assertTrue('body' in r)
        self.assertTrue('footer' in r)

        basico.assign_report('Simple Report', task=basico.T.STEADY_STATE, file_name='out.txt')

        basico.remove_report('Simple Report')
        r = basico.get_report_dict('Simple Report')
        self.assertTrue(r is None)

        basico.add_report('PE Report', footer=[
            'CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Function Evaluations',
            'CN=Root,Vector=TaskList[Optimization],Problem=Optimization,Reference=Best Value'
        ], comment="""Report using CN's only collected at the end""")

        r = basico.get_report_dict('PE Report')
        self.assertTrue(r is not None)

        basico.add_report('Silly Report', footer=[
            'String=test',
            'test2',
            '\n',
            'String=\\[0\\,1\\]',
            '[0,1]',
            basico.wrap_copasi_string('[S]'),
            'Separator=\t'
        ], comment="""report with strings at the end""")
        r = basico.get_report_dict('Silly Report')
        self.assertTrue(r is not None)

    def test_add_function(self):
        m = basico.new_model(name='TestModel_With_Inhibition')
        basico.add_function(name='MassAction_inhibited',
                            infix='(1-a*I)*k*A*B', type='irreversible',
                            mapping={'I': 'modifier', 'A': 'substrate', 'B': 'substrate'})
        f = basico.get_functions('MassAction_inhi')
        self.assertTrue(len(f) == 1)
        basico.add_reaction('R1', 'S1 + S2 -> S3; I', function='MassAction_inhibited')
        r = basico.get_reactions('R1')
        self.assertTrue(r is not None)
        self.assertEqual(r['function'].iloc[0], 'MassAction_inhibited')
        basico.remove_datamodel(m)

    def test_parameter_mapping(self):
        m = 'Test_global_param'
        dm = basico.new_model(name=m)
        r = 'R'
        basico.add_parameter('k_global', 1, unit='1/s')
        basico.add_reaction(r, 'A -> B', function='Mass action (irreversible)')
        params = basico.get_parameters()
        self.assertTrue(len(params) == 1)
        params2 = basico.get_reaction_parameters(r)
        self.assertTrue(len(params2) == 1)
        self.assertTrue(params2.type.iloc[0] == 'local')
        basico.set_reaction(r, mapping={'k1': 'k_global'})
        params2 = basico.get_reaction_parameters(r)
        self.assertTrue(len(params2) == 1)
        self.assertTrue(params2.type.iloc[0] == 'global')

        basico.set_reaction(r, mapping={'k1': 1.0})
        params2 = basico.get_reaction_parameters(r)
        self.assertTrue(len(params2) == 1)
        self.assertTrue(params2.type.iloc[0] == 'local')

        basico.set_reaction_parameters('(R).k1', mapped_to='k_global')
        params2 = basico.get_reaction_parameters(r)
        self.assertTrue(len(params2) == 1)
        self.assertTrue(params2.type.iloc[0] == 'global')


if __name__ == '__main__':
    unittest.main()
