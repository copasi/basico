import unittest
from basico.ssr import CopasiSSR
import os


@unittest.skipIf(CopasiSSR is None, "CopasiSSR is not installed")
class TestSSR(unittest.TestCase):
    def test_ssr(self):
        sim = CopasiSSR()
        model_path = os.path.join(os.path.dirname(__file__), 'model_uniform.xml')
        sim.load_model(model_path)
        results = sim.produce_results(['S', 'I', 'R', 'V'], [0, 10], 1000)
        self.assertEqual(len(results), 4)
