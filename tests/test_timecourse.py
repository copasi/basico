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

    def test_values(self):
        tc = basico.run_time_course(values=[10, 20, 30])
        tc2 = basico.run_time_course(values=[10, 20, 30], start_time=10)
        self.assertIsNotNone(tc)
        # we decided that both should have the same shape
        # see issue #61
        self.assertEqual(tc.shape[0], 3 )
        self.assertEqual(tc2.shape[0], 3 )


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
        result = basico.run_time_course(duration=10, method='directMethod', use_numbers=True)
        self.assertIsNotNone(result)

        # test that we can set hybrid methods
        result = basico.run_time_course(duration=1, method='hybrid', use_numbers=True)
        self.assertIsNotNone(result)
        settings = basico.get_task_settings(basico.T.TIME_COURSE)
        self.assertEqual(settings['method']['name'], 'Hybrid (Runge-Kutta)')

        # test that we cannot run the time course with too many particles
        # and that the error message is correct:
        basico.set_species('A', initial_particle_number=1e+24)
        with self.assertLogs('basico', level='ERROR') as cm:
            basico.run_time_course(duration=10, method='directMethod', use_numbers=True)
            self.assertTrue(len(cm.output) > 0)
            error_message = cm.output[0]
            self.assertTrue('At least one particle number in the initial state is too big' in error_message)

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
        plots = []
        basico.run_task(basico.T.TIME_COURSE, model=dm, plots=plots)
        self.assertEqual(len(plots), 2)
        basico.remove_datamodel(dm)

    def test_general_run_sedml(self):
        dm = basico.load_model(os.path.join(THIS_DIR, 'sedml.xml'))
        plots = []
        basico.run_scheduled_tasks(include_plots=False, include_general_plots=True, plots=plots, model=dm)
        self.assertEqual(len(plots), 1)

    def test_datahandler_for_fluxes_with_parenthesis(self):
        basico.new_model(name='Simple Model')
        basico.add_reaction('R1 (step 1)', 'A ->')
        basico.set_species('A', initial_concentration=10)
        
        result = basico.run_time_course_with_output(['Time', 
                                                     '(R1 (step 1)).Flux',
                                                     '(R1 (step 1)).k1'], 0, 5, 5)    
        
        self.assertIsNotNone(result)
        self.assertEqual(result.shape, (6, 3))


    def test_issue_61(self):
        dm = basico.import_sbml(os.path.join(THIS_DIR, 'test_data','issue61.xml'), annotations_to_remove=[
            ('initialValue', 'http://copasi.org/initialValue')], ensure_unique_names=True)

        desired_values = [10.0, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15, 15.5, 
                        16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20]
        
        problem = {
                        "AutomaticStepSize": True,   # should be ignored
                        "Duration": 200.0,           # should be ignored
                        "OutputStartTime": 100.0,    # should be ignored
                        "Use Values": True,
                        "Values": desired_values
                    }

        method = {'name': 'Deterministic (LSODA)'}

        settings = {
            "problem": problem,
            "method": method
        }

        basico.set_task_settings('Time-Course', settings)

        output_elements = ['Time', '[A]', '[C]', '[DA]']
        dh, columns = basico.create_data_handler(output_elements, model=dm)

        df1 = basico.run_time_course_with_output(output_elements, model=dm)
        self.assertListEqual(df1['Time'].to_list(), desired_values)

        dm.addInterface(dh)
        df2 = basico.run_time_course(**{"use_inital_values": True}).reset_index()
        data = basico.get_data_from_data_handler(dh, columns)
        dm.removeInterface(dh)
        self.assertListEqual(data['Time'].to_list(), desired_values)
        self.assertListEqual(df2['Time'].to_list(), desired_values)


        # run some more tests white different values for duration and output start time
        # ensuring that the requested values are still returned
        desired_values = [ 0, 10, 15, 20]
        df1 = basico.run_time_course_with_output(output_elements, values=desired_values, model=dm)
        self.assertListEqual(df1['Time'].to_list(), desired_values)
        df2 = basico.run_time_course(**{"use_inital_values": True}).reset_index()
        self.assertListEqual(df2['Time'].to_list(), desired_values)

        desired_values = [ 15, 20 ]
        df1 = basico.run_time_course_with_output(output_elements, values=desired_values, model=dm)
        self.assertListEqual(df1['Time'].to_list(), desired_values)
        df2 = basico.run_time_course(**{"use_inital_values": True, "values":desired_values}).reset_index()
        self.assertListEqual(df2['Time'].to_list(), desired_values)



        basico.remove_datamodel(dm)


if __name__ == '__main__':
    unittest.main()
