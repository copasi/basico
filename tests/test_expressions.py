import unittest
import basico
import basico.expressions

class TestExpressions(unittest.TestCase):

    def test_add(self):
        dm = basico.load_example('LM')
        basico.expressions.add_parameter_for('sum_rates', 'rates', 'sum')
        d = basico.as_dict(basico.get_parameters('sum_rates', exact=True))
        self.assertIsNotNone(d)
        self.assertEqual(d['expression'], 'S.Rate + E.Rate + ES.Rate + P.Rate')
        basico.expressions.add_parameter_for('sum_squares', 'rates', 'sum_of_squares')
        d = basico.as_dict(basico.get_parameters('sum_squares', exact=True))
        self.assertIsNotNone(d)
        self.assertEqual(d['expression'], 'S.Rate ^ 2 + E.Rate ^ 2 + ES.Rate ^ 2 + P.Rate ^ 2')
        basico.remove_datamodel(dm)

    def test_objects(self):
        dm = basico.load_example('LM')
        fluxes = basico.expressions._get_objects(dm, basico.expressions.OBJ.FLUXES)
        self.assertIsNotNone(fluxes)
        rates = basico.expressions._get_objects(dm, basico.expressions.OBJ.RATES_OF_CHANGE)
        self.assertIsNotNone(rates)
        concentrations = basico.expressions._get_objects(dm, basico.expressions.OBJ.CONCENTRATIONS)
        self.assertIsNotNone(concentrations)
        basico.remove_datamodel(dm)

    def test_min(self):
        e = basico.expressions._min([])
        self.assertEqual(e, '0')
        e = basico.expressions._min(['a'])
        self.assertEqual(e, '<a>')
        e = basico.expressions._min(['a', 'b'])
        self.assertEqual(e, 'min(<a>, <b>)')
        e = basico.expressions._min(['a', 'b', 'c'])
        self.assertEqual(e, 'min(<a>, min(<b>, <c>))')

    def test_max(self):
        e = basico.expressions._max([])
        self.assertEqual(e, '0')
        e = basico.expressions._max(['a'])
        self.assertEqual(e, '<a>')
        e = basico.expressions._max(['a', 'b'])
        self.assertEqual(e, 'max(<a>, <b>)')
        e = basico.expressions._max(['a', 'b', 'c'])
        self.assertEqual(e, 'max(<a>, max(<b>, <c>))')

    def test_sum(self):
        e = basico.expressions._sum([])
        self.assertEqual(e, '0')
        e = basico.expressions._sum(['a'])
        self.assertEqual(e, '<a>')
        e = basico.expressions._sum(['a', 'b'])
        self.assertEqual(e, '<a> + <b>')
        e = basico.expressions._sum(['a', 'b', 'c'])
        self.assertEqual(e, '<a> + <b> + <c>')

    def test_sum_of_squares(self):
        e = basico.expressions._sum_of_squares([])
        self.assertEqual(e, '0')
        e = basico.expressions._sum_of_squares(['a'])
        self.assertEqual(e, '<a>^2')
        e = basico.expressions._sum_of_squares(['a', 'b'])
        self.assertEqual(e, '<a>^2 + <b>^2')
        e = basico.expressions._sum_of_squares(['a', 'b', 'c'])
        self.assertEqual(e, '<a>^2 + <b>^2 + <c>^2')

    def test_sum_of_abs(self):
        e = basico.expressions._sum_abs([])
        self.assertEqual(e, '0')
        e = basico.expressions._sum_abs(['a'])
        self.assertEqual(e, 'abs(<a>)')
        e = basico.expressions._sum_abs(['a', 'b'])
        self.assertEqual(e, 'abs(<a>) + abs(<b>)')
        e = basico.expressions._sum_abs(['a', 'b', 'c'])
        self.assertEqual(e, 'abs(<a>) + abs(<b>) + abs(<c>)')

if __name__ == '__main__':
    unittest.main()
