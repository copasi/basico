---
title: 'BASICO: A simplified Python interface to COPASI'
tags:
  - Python
  - systems biology
  - computational modeling
  - simulation
  - COPASI
authors:
  - name: Frank T. Bergmann
    orcid: 0000-0001-5553-4702
    affiliation: 1

affiliations:
 - name: BioQUANT/COS, Heidelberg University, Heidelberg, Germany
   index: 1
date: 29 March 2023
bibliography: paper.bib

---

# Summary
Biological systems are highly complex and dynamic, whose behavior in response 
to changed conditions or perturbations cannot be predicted easily. Thus computational 
modeling can serve as a valuable analysis tool which allows an understanding of 
these systems that cannot be achieved with wet lab experiments alone. It can be 
used to gain a deeper understanding of the system or to answer more applied 
questions such as predicting drug targets. `COPASI` is a powerful environment 
for creating, editing, simulating and analyzing computational models. It provides 
a user-friendly GUI that is easy to use even by people who are not experts in the 
field. At the same time, its broad range of tasks makes it attractive for more 
advanced computational biologists. By using a scripting language in conjunction with 
COPASI, scientists can automate tasks such as parameter estimation, sensitivity analysis, 
optimization, and model fitting. They can also create custom scripts to perform complex 
operations or analyses that are not available in COPASI's GUI, such as  model identification.
Scripting languages can also facilitate the communication. documentation and reproducibility
of computational models, by allowing scientists to share their code and results with others. 

Here we introduce `BASICO`, a simplified Python interface to `COPASI`. It provides
a set of functions that allow to create, edit, simulate and analyze models in a
more automated way. `BASICO` can be easily installed using: `pip install copasi-basico`.



# Statement of need

COmplex PAthway SImulator [`COPASI`; @hoops_2006; @bergmann_2017] is a widely used
program for analyzing and generating systems biology models. Its graphic user 
interface (GUI) makes it a quick and easy to learn tool. Since its operation requires
little knowledge about mathematical backgrounds, it is very attractive for biologists. 
It incorporates very powerful methods ranging from basic time series for both 
deterministic and stochastic simulations, parameter estimation with a broad range 
of implemented local and global optimization algorithms, to more complex tasks such 
as time scale separation analysis, and Lyapunov exponent calculations. 
SBML import and export are supported and allow a quick exchange of models with other 
modeling environments [@Hucka_2003; @keating_sbml_2020].

To further the powerful application range of COPASI, files prepared in the GUI can be
scheduled in cluster environments. This is extremely helpful for running time 
consuming tasks such as optimization runs or parameter estimations. Generating 
these files for different parameterizations or versions of models and synchronizing 
is a very tedious task. That is where it is extremely helpful to use Python scripting 
to handle several model versions with different parameterizations, as it is often 
required in systems biology. Here, task parameters can be pre-defined, along with which 
task to run. The `COPASI` project uses SWIG [@SWIG] to automatically generate language 
bindings for a variety of programming languages. These bindings however, require deep
knowledge of `COPASI`'s architecture, which makes them hard to use. 

`BASICO` is a pure Python package, building on top of these automatically generated 
language bindings, in order to simplify using all of the features of `COPASI`. Thanks 
to being hosted on [GitHub](https://github.com/copasi/basico) with its automated 
processes, modifications and improvements of the software can be easily integrated, 
and published to the community.

Being an easily installable module, `BASICO` can readily integrated with other packages 
or pipelines to create new functionality. For example, it would be difficult to use COPASI
directly for approximate Bayesian computation (ABC), but through using `BASICO` in the 
pyABC package [@pyABC] it can be done.

As scripting module `BASICO` lends itself for constructing large networks, as is for example 
done in the reproducibility study in @mendes2023reproducibility.

Documentation for `BASICO` along with many examples, in the form of Jupyter Notebooks
can be found at [https://basico.readthedocs.io/](https://basico.readthedocs.io/). `BASICO`
can be readily used in the cloud using [Google Colab](https://colab.research.google.com/github/copasi/basico/blob/master/docs/notebooks/index.ipynb), 
or [mybinder.org](https://mybinder.org/v2/gh/copasi/basico.git/HEAD?filepath=docs/notebooks/index.ipynb).

# Features & Functionality
`BASICO` provides a set of functions that allow to create, edit, simulate and analyze
biochemical reaction networks. It is easy installed using: 

```bash
    pip install copasi-basico
```

From there, models can be created from scratch, or loaded from COPASI, SBML / SED-ML or COMBINE Archive files [@bergmann2014combine]. Support for
SED-ML and COMBINE Archive files is provided through libSEDML [@libSEDML] and libCOMBINE [@libCombine] that are used by the SWIG generated
COPASI bindings.

We also provide functions, to directly access and search models from the 
BioModels Database [@BioModels2015b] or JWS Online [@JWS]. 

```python

    load_model(filename)    # loads CPS, SBML, SED-ML or COMBINE Archive files
    load_biomodel(model_id) # loads models from the BioModels Database

```

Of course the wrappers for the REST API to JWS Online or the BioModels Database can also be readily used by other Python packages to
obtain the SBML models. This is done for example by SBMLtoODEjax [@sbmltoodejax]

Once a model is loaded all of `COPASI`'s analysis methods can be used. Running simulations are a core feature of COPASI, 
so we started `BASICO` with implementing time course simulations and steady state analysis. 

```python

    load_example('brusselator')       # load an example model 
    df = run_time_course(duration=10) # simulate the model for 10 time units

```

Here, `run_time_course` returns a `pandas.DataFrame` [@pandas] with the results of the simulation. We 
quickly received feature requests to add further analysis methods, and so we added parameter estimation,
optimizations, sensitivity analysis and parameter scans. 

Most recently we added the automation of profile likelihood calculations, that for a given
parameter estimation result, automatically generates [profile likelihood plots](https://basico.readthedocs.io/en/latest/notebooks/Profile_likelihood.html). 
This is another example, that would have been quite cumbersome to do without `BASICO`. Following the 
approach of Schaber [@SCHABER2012183] `BASICO` generates parameter scans (running a local optimization 
method) for each parameter to be estimated, can run these individual models in parallel, and generate 
the likelihood plots from the generated data. 


# Target Audience
This package is intended for researchers in the field of systems biology, who are
interested in either creating and understanding new computational models, or to 
automate the analysis of existing models. The package is also very useful as teaching
tool. 

# Acknowledgements

We acknowledge contributions from Lilija, Aprupe-Wehling, Katharina Beuke, and
Pedro Mendes as well as the COPASI developers, currently Hasan Baig, Stefan Hoops, 
Brian Klahn, Ursula Kummer, Jürgen Pahle, and Sven Sahle; and the members of the 
[COPASI user forum](https://groups.google.com/g/copasi-user-forum/). This work has 
has been possible thanks to the BMBF funded de.NBI initiative (031L0104A).

# References