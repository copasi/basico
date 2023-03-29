---
title: 'BASICO: A simplified python interface to COPASI'
tags:
  - Python
  - systems biology
  - computational modeling
  - simulation
  - COPASI
authors:
  - name: Frank T. Bergmann
    orcid: 0000-0001-5553-4702
    equal-contrib: true
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
field. At the same time its broad range of tasks, makes it attractive for more 
advanced computational biologists. However, sometimes a more automated approach 
is necessary for example for model identification. 

Here we introduce `BASICO`, a simplified python interface to `COPASI`. It provides
a set of functions that allow to create, edit, simulate and analyze models in a
more automated way. `BASICO` can be easily installed using: `pip install copasi-basico`.



# Statement of need

COmplex PAthway SImulator (`COPASI`; `@hoops_2006`; `@bergmann_2017`) is a widely used
program for analyzing and generating systems biology models. Its graphic user 
interface (GUI) makes it a quick and easy to learn tool. Since its operation requires
little knowledge about mathematical backgrounds, it is very attractive for biologists. 
It incorporates very powerful methods ranging from basic time series for both 
deterministic and stochastic simulations, parameter estimation with a broad range 
of implemented local and global optimization algorithms, to more complex tasks such 
as time scale separation analysis, and lyapunov exponent calculations. 
SBML import and export are supported and allow a quick exchange of models with other modeling environments [@Hucka_2003; @keating_sbml_2020].
To further the powerful application range of COPASI, files prepared in the GUI can be
scheduled in cluster environments. This is extremely helpful for running time 
consuming tasks such as optimization runs or parameter estimations. Generating 
these files for different parameterizations or versions of models and synchronizing 
is a very tedious task. That is where it is extremely helpful to use python scripting 
to handle several model versions with different parameterizations, as it is often 
required in systems biology. Here, task parameters ca be pre-defined, along with which 
task to run. The language bindings offer a formalized way of modifying a COPASI 
file through the same means the GUI modifies the model. This ensures that the files 
remain intact and machine readable.

# Acknowledgements

We acknowledge contributions from Lilija, Aprupe-Wehling, Katharina Beuke, and
Pedro Mendes as well as the COPASI developers, currently Stefan Hoops, Brian Klahn, Ursula Kummer, J\"urgen Pahle, and  Sven Sahle; and the members of the COPASI 
user group. This work has has been possible thanks to the BMBF funded de.NBI initiative (031L0104A).

# References