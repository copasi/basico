import unittest
import basico
import os

THIS_DIR = os.path.dirname(__file__)


class TestTimeCourse(unittest.TestCase):
    def setUp(self):
        basico.load_model(os.path.join(THIS_DIR, 'tellurium_sim.sbml'))

    def test_custom_output(self):
        tc = basico.run_time_course_with_output(['Time', '[S1]', '[S2]', 'Values[k1]'], 0, 5, 5)
        self.assertIsNotNone(tc)
        self.assertListEqual(tc.columns.to_list(), ['Time', '[S1]', '[S2]', 'Values[k1]'])

    def test_stochastic(self):
        basico.new_model(name='Simple Model')
        basico.add_reaction('R1', 'A ->')
        basico.add_reaction('R2', 'B -> B + C')
        basico.set_species('A', initial_particle_number=50)
        basico.set_species('B', initial_particle_number=10)
        basico.set_species('C', initial_particle_number=0)
        basico.set_reaction_parameters('(R1).k1', value=1)
        basico.set_reaction_parameters('(R2).k1', value=1)
        basico.add_event('E1', 'A <= 10', [('B', '50')])
        result = basico.run_time_course(duration=10, method='stochastic', use_numbers=True)
        self.assertIsNotNone(result)

        # test that we can set hybrid methods
        result = basico.run_time_course(duration=1, method='hybrid', use_numbers=True)
        self.assertIsNotNone(result)
        settings = basico.get_task_settings(basico.T.TIME_COURSE)
        self.assertEqual(settings['method']['name'], 'Hybrid (Runge-Kutta)')

    def test_stoch2(self):
        basico.new_model(name='Simple Model', substance_unit='1')
        basico.add_reaction('R1', 'A ->')
        basico.set_species('A', initial_particle_number=50)
        basico.set_reaction_parameters('(R1).k1', value=1)
        basico.add_event('E1', 'A.ParticleNumber <= 1', [('A.ParticleNumber', '50')])

        result = basico.run_time_course(duration=20, method='directMethod', use_numbers=True)
        self.assertIsNotNone(result)

    def test_general_run(self):
        dm = basico.load_example('bruss')
        basico.run_task(basico.T.TIME_COURSE, model=dm)
        basico.remove_datamodel(dm)


if __name__ == '__main__':
    unittest.main()
