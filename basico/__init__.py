"""BasiCO is a simplified interface to COPASI.

This module provides convenience functions to quickly get a model loaded and simulated:

Example:

    >>> from basico import *
    >>> load_biomodel(10)
    >>> run_time_course().plot()

"""

from .model_io import *
from .model_info import *

from .task_timecourse import *
from .task_parameterestimation import *
from .task_steadystate import *

from .array_tools import *
from .compartment_array_tools import *

settings = {}

from ._version import get_versions
__version__ = get_versions()['version']
del get_versions
