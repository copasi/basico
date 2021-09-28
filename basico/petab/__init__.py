"""PEtab submodule

This module provides convenience functions for importing petab models and using
petab_select. it requires the petab / petab select packages from pip

"""

from .core import *

try:
    from .select import *
except ImportError:
    pass
