import unittest
import basico
from  basico.callbacks import TqmdCallback
import COPASI

class TestCallbacks(unittest.TestCase):
    @unittest.skipIf(COPASI.CVersion.VERSION.getVersionMinor() < 37 or not TqmdCallback.is_available(), 'Require 4.37 of COPASI')
    def test_something(self):
        dm = basico.load_example('LM')
        self.assertIsNotNone(dm)
        basico.run_time_course(100, 100)
        t = dm.getTask(basico.T.TIME_COURSE)
        prob = t.getProblem()
        prob.setStepNumber(100000)
        p = TqmdCallback()
        t.setCallBack(p)
        t.processRaw(True)
        t.setCallBack(None)
        basico.remove_datamodel(dm)

    @unittest.skipIf(COPASI.CVersion.VERSION.getVersionMinor() < 37  or not TqmdCallback.is_available(), 'Require 4.37 of COPASI')
    def test_default(self):
        basico.callbacks.create_default_handler(delay=0)
        dm = basico.load_example('LM')
        self.assertIsNotNone(dm)
        data = basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION)
        self.assertIsNotNone(data)
        basico.remove_datamodel(dm)
        basico.callbacks.set_default_handler(None)


if __name__ == '__main__':
    unittest.main()
