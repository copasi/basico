"""BasiCO is a simplified interface to COPASI.

This module provides convenience functions to quickly get a model loaded and simulated:

Example:

    >>> from basico import *
    >>> load_biomodel(10)
    >>> run_time_course().plot()

"""

from .model_io import *
from .model_info import *
from .logging import *

from .task_timecourse import *
from .task_parameterestimation import *
from .task_steadystate import *
from .task_scan import *
from .task_optimization import *
from .task_sensitivities import *
from .task_mca import *
from .task_lyapunov import *

from .compartment_array_tools import *

settings = {}

from . import _version
__version__ = _version.get_versions()['version']
