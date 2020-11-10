import unittest
import basico


class TestBasicoModelManipulation(unittest.TestCase):

    def setUp(self):
        self.model = basico.new_model(name='Test Model')
        self.assertTrue(self.model.getModel().getObjectName() == 'Test Model')

    def test_add_compartment(self):
        basico.add_compartment('c', 1.0)
        c = basico.get_compartments('c')
        self.assertEqual(float(c.initial_size), 1)
        basico.set_compartment('c', initial_size=2)
        c = basico.get_compartments('c')
        self.assertEqual(float(c.initial_size), 2)

    def test_add_species(self):
        basico.add_species('X')
        s = basico.get_species('X')
        self.assertEqual(float(s.initial_concentration), 1)
        c = basico.get_compartments('compartment')
        self.assertEqual(float(c.initial_size), 1)
        basico.set_species('X', initial_concentration=2)
        s = basico.get_species('X')
        self.assertEqual(float(s.initial_concentration), 2)

    def test_add_event(self):
        basico.add_event('e0', 'Time > 10', [['X', '0']])
        e = basico.get_events('e0')
        self.assertEqual(str(e.iloc[0]['trigger']), 'Time > 10')

    def test_add_reaction(self):
        basico.add_reaction('r0', 'X -> Y')
        r = basico.get_reactions('r0')
        self.assertEqual(str(r.iloc[0]['scheme']), 'X -> Y')

    def test_add_parameter(self):
        basico.add_parameter('sin_time', type='assignment', expression='sin({Time})')
        p = basico.get_parameters('sin_time')
        self.assertEqual('assignment', str(p.iloc[0]['type']))
        self.assertEqual('sin ( {Time} )', str(p.iloc[0]['expression']))


if __name__ == '__main__':
    unittest.main()
