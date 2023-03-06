import sys
import unittest
import basico
import basico.compartment_array_tools as cat
import COPASI


class TestArrayTools(unittest.TestCase):
    def test_create_arrays(self):
        dm = basico.load_example('brusselator')
        basico.create_rectangular_array(4, 4, ['X', 'Y'], [0.16, 0.8], delete_template=True)
        compartments = basico.as_dict(basico.get_compartments())
        self.assertEqual(len(compartments), 16)

        names = [c['name'] for c in compartments]
        x_range, y_range, prefixes = cat._split_ranges(names)
        self.assertEqual(x_range, [0, 1, 2, 3])
        self.assertEqual(y_range, [0, 1, 2, 3])
        self.assertEqual(prefixes, ['compartment'])

        # remove some of the generated grid
        cat.delete_compartments(selection=[(0,1), (2,3)])
        compartments = basico.as_dict(basico.get_compartments())
        self.assertEqual(len(compartments), 14)

        names = [c['name'] for c in compartments]
        x_range, y_range, prefixes = cat._split_ranges(names)
        # ensure elements are still sorted
        self.assertEqual(x_range, [0, 1, 2, 3])
        self.assertEqual(y_range, [0, 1, 2, 3])
        self.assertEqual(prefixes, ['compartment'])
        # and that removed elements are not in the list
        self.assertNotIn('compartment[0,1]', names)
        self.assertNotIn('compartment[2,3]', names)
        basico.remove_datamodel(dm)

        dm = basico.load_example('brusselator')
        basico.create_linear_array(4, ['X', 'Y'], [0.16, 0.8], delete_template=True)
        compartments = basico.as_dict(basico.get_compartments())
        self.assertEqual(len(compartments), 4)
        basico.remove_datamodel(dm)

if __name__ == "__main__":
    unittest.main()
