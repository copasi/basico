import unittest
import basico


class TestSensitivities(unittest.TestCase):
    def setUp(self):
        basico.load_example('bruss')
        self.assertIsNotNone(basico.get_species('X', exact=True))

    def test_settings(self):
        settings = basico.get_sensitivity_settings()
        self.assertDictEqual(settings,
                             {
                                 'scheduled': False,
                                 'update_model': False,
                                 'method': {'Delta factor': 0.001,
                                            'Delta minimum': 1e-12,
                                            'name': 'Sensitivities Method'},
                                 'report': {'filename': '',
                                            'report_definition': 'Sensitivities',
                                            'append': True,
                                            'confirm_overwrite': False},
                                 'sub_task': 'Steady State',
                                 'effect': 'Non-Constant Concentrations of Species',
                                 'cause': 'All Parameter Values',
                                 'secondary_cause': 'Not Set'
                              })

        basico.set_sensitivity_settings({
            'effect': basico.SENS.METAB_CONCENTRATIONS,
            'cause': basico.SENS.METAB_INITIAL_CONCENTRATIONS,
            'scheduled': True
        })

        settings = basico.get_sensitivity_settings()
        self.assertEqual(settings['scheduled'], True)
        self.assertEqual(settings['effect'], basico.SENS.METAB_CONCENTRATIONS)
        self.assertEqual(settings['cause'], basico.SENS.METAB_INITIAL_CONCENTRATIONS)

    def test_enums(self):
        self.assertEqual(basico.SENS.from_enum(1), basico.SENS.SINGLE_OBJECT)
        self.assertEqual(basico.SENS.to_enum(basico.SENS.SINGLE_OBJECT), 1)

        self.assertEqual(basico.SENS_ST.to_enum(basico.SENS_ST.Evaluation), 0)
        self.assertEqual(basico.SENS_ST.to_enum(basico.SENS_ST.SteadyState), 1)
        self.assertEqual(basico.SENS_ST.to_enum(basico.SENS_ST.TimeSeries), 2)
        self.assertEqual(basico.SENS_ST.to_enum(basico.T.TIME_COURSE), 2)
        self.assertEqual(basico.SENS_ST.to_enum(basico.T.TIME_COURSE),
                         basico.SENS_ST.to_enum(basico.SENS_ST.TimeSeries))

        self.assertEqual(basico.SENS.from_enum(3), basico.SENS.METAB_INITIAL_CONCENTRATIONS)

    def test_run(self):
        basico.run_sensitivities()
        scaled = basico.get_scaled_sensitivities()
        self.assertIsNotNone(scaled)
        unscaled = basico.get_unscaled_sensitivities()
        self.assertIsNotNone(unscaled)
        summarized = basico.get_summarized_sensitivities()
        self.assertIsNotNone(summarized)


if __name__ == '__main__':
    unittest.main()
