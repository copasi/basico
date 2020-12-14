![Python package](https://github.com/copasi/basico/workflows/Python%20package/badge.svg) [![Documentation Status](https://readthedocs.org/projects/basico/badge/?version=latest)](https://basico.readthedocs.io/en/latest/?badge=latest) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=copasi_basico&metric=alert_status)](https://sonarcloud.io/dashboard?id=copasi_basico)

## BasiCO
This project hosts a simplified python interface to COPASI. While all functionality from COPASI is exposed via automatically generated SWIG wrappers, this package aims to add a layer on top of that, to hide most of the complexity away when calling COPASI functions.   

![COPASI Logo](./docs/_static/COPASI_Conly_176x176.png)  

### Installation
The package works with python 2.x and python 3.x, provided the following packages are installed: 

* python-copasi
* pandas

`pandas` and `python-copasi` are freely available on pypi. Once done, just have the `basico` directory in the `PYTHONPATH` or `sys.path`.

Or you could directly install everything you need right from this git repo:

    pip install git+https://github.com/copasi/basico.git

### Usage

The following modules are available: 

* `model_io`: functionality, for creating / loading / saving models.
* `model_info`: functionality to getting / setting model elements from pandas dataframes  
* `task_timecourse`: a wrapper for running time course simulations
* `array_tools`: utility for plotting and the like

Documentation is work in progress, but you can find the start under: 
<https://basico.readthedocs.org/>

### Acknowledgements
This project has been possible thanks to the BMBF funded de.NBI initiative (031L0104A):

![de.NBI logo](./docs/_static/deNBI_logo.jpg)

### License

The packages available on this page are provided under the 
[Artistic License 2.0](http://copasi.org/Download/License/), 
which is an [OSI](http://www.opensource.org/) approved license. This license 
allows non-commercial and commercial use free of charge.
 
