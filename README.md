![Python package](https://github.com/copasi/basico/workflows/Python%20package/badge.svg) [![Documentation Status](https://readthedocs.org/projects/basico/badge/?version=latest)](https://basico.readthedocs.io/en/latest/?badge=latest) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=copasi_basico&metric=alert_status)](https://sonarcloud.io/dashboard?id=copasi_basico) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/copasi/basico.git/HEAD?filepath=docs/notebooks/index.ipynb) [![DOI](https://zenodo.org/badge/148472105.svg)](https://zenodo.org/badge/latestdoi/148472105) [![codecov](https://codecov.io/gh/copasi/basico/branch/master/graph/badge.svg?token=MG54YU29JQ)](https://codecov.io/gh/copasi/basico) [![DOI](https://joss.theoj.org/papers/10.21105/joss.05553/status.svg)](https://doi.org/10.21105/joss.05553)


## BasiCO
This project hosts a simplified python interface to COPASI. While all functionality from COPASI
is exposed via automatically generated SWIG wrappers, this package aims to add a layer on top of
that, to hide most of the complexity away when calling COPASI functions.   

![COPASI Logo](./docs/_static/COPASI_Conly_176x176.png)  

### Installation
The package works with python 3.7+, provided the following packages are installed: 

* python-copasi
* pandas
* numpy
* matplotlib
* PyYAML

that are freely available on pypi, they will be automatically installed when installing via setup.py.

Once done, just have the `basico` directory 
in the `PYTHONPATH` or `sys.path`.

Or you could directly install everything you need right from pypi 

    pip install copasi-basico

from this git repo:

    pip install git+https://github.com/copasi/basico.git

### Usage

The following modules are available: 

* `model_io`: functionality, for creating / loading / saving models.
* `model_info`: functionality to getting / setting model elements from pandas dataframes  
* `task_timecourse`: a wrapper for running time course simulations
* `task_parameter_estimation`: a wrapper for parameter estimation
* `task_optimization`: a wrapper for computing optimizations with arbitrary objective functions
* `task_steadystate`: a wrapper for computing steady states
* `task_scan`: a wrapper for parameter scans / repeats
* `task_sensitivities`: a wrapper for computing sensitivities
* `compartment_array_tools`: utility for plotting and the like

Documentation is continually updated at: <https://basico.readthedocs.org/>. 

Please use the [issue tracker](https://github.com/copasi/basico/issues) for bug reports and feature requests.

### Run the tests

basico comes with a number of unit tests based on pytest. To run them, change to the 
root directory of this project and run: 

    python3 -m pytest

that will ensure that `basico` is in the python path, and the test run as expected. Some 
tests require more data, that is not included in the repository, such as tests for PEtab 
and petab select, for those, specify the environment variables to the directories where
the files are for example: 

    PETAB_BENCHMARK_MODELS=/path/to/petab/benchmark/models
    PETAB_SELECT_MODELS=/path/to/petab/select/models

for example: 

    PETAB_BENCHMARK_MODELS=../Benchmark-Models-PEtab/Benchmark-Models PETAB_SELECT_MODELS=../petab_select/test_cases  python3 -m pytest

### Acknowledgements
This project has been possible thanks to the BMBF funded de.NBI initiative (031L0104A):

![de.NBI logo](./docs/_static/deNBI_logo.jpg)

### License

The packages available on this page are provided under the 
[Artistic License 2.0](http://copasi.org/Download/License/), 
which is an [OSI](http://www.opensource.org/) approved license. This license 
allows non-commercial and commercial use free of charge.
 
