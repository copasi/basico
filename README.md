## BasiCo
This project hosts a python interface to COPASI.  

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


### License

The packages available on this page are provided under the 
[Artistic License 2.0](http://copasi.org/Download/License/), 
which is an [OSI](http://www.opensource.org/) approved license. This license 
allows non-commercial and commercial use free of charge.
 
