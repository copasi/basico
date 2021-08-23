import unittest
import basico


class TestBasicoModelManipulation(unittest.TestCase):

    def setUp(self):
        self.model = basico.new_model(name='Test Model')
        self.assertTrue(self.model.getModel().getObjectName() == 'Test Model')

    def test_add_compartment(self):
        basico.add_compartment('c', 1.0)
        c = basico.get_compartments('c')
        self.assertAlmostEqual(float(c.initial_size), 1)
        basico.set_compartment('c', initial_size=2)
        c = basico.get_compartments('c')
        self.assertAlmostEqual(float(c.initial_size), 2)

    def test_add_species(self):
        basico.add_species('X')
        s = basico.get_species('X')
        self.assertAlmostEqual(float(s.initial_concentration), 1)
        c = basico.get_compartments('compartment')
        self.assertAlmostEqual(float(c.initial_size), 1)
        basico.set_species('X', initial_concentration=2)
        s = basico.get_species('X')
        self.assertAlmostEqual(float(s.initial_concentration), 2)

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

        species = basico.get_species().reset_index()
        self.assertEqual(species[species.name == 'PG'].type.any(), 'ode')
        self.assertEqual(species[species.name == 'PG'].expression.any(), '[E] / ( Values[k_4] * [7-ADCA] / Values[K_n] + Values[k_5] * [7-ADCA] / Values[K_n] + Values[k_6] * [PGME] / Values[K_si] + Values[k3] ) * ( Values[k_2] * [PGME] / Values[K_s] + Values[k_4b] * [CEX] / Values[K_p] ) * ( Values[k_3] + Values[k_5] * [7-ADCA] / Values[K_n] + Values[k_6] * [PGME] / Values[K_si] )')
        self.assertEqual(species[species.name == 'E'].type.any(), 'assignment')
        self.assertEqual(species[species.name == 'E'].expression.any(), '[EA]_0 * exp ( - Values[k_d] * Time ) / ( 1 + [PGME] / Values[K_s] + Values[k_2] * [PGME] / ( Values[K_s] * ( Values[k_4] * [7-ADCA] / Values[K_n] + Values[k_5] * [7-ADCA] / Values[K_n] + Values[k_6] * [PGME] / Values[K_si] + Values[k3] ) ) * ( 1 + [7-ADCA] / Values[K_n] + [PGME] / Values[K_si] ) + [CEX] / Values[K_p] + [PG] / Values[K_p2i] )')

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


if __name__ == '__main__':
    unittest.main()
