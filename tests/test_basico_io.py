import unittest
import basico
import COPASI


class TestBasicoIO(unittest.TestCase):

    def test_new_model(self):
        dm = basico.new_model()
        self.assertTrue(dm is not None)
        self.assertTrue(isinstance(dm, COPASI.CDataModel))


if __name__ == "__main__":
    unittest.main()
