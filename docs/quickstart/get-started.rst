Getting Started
===============


Installation
---------------

BasiCO is not yet available in pypi, however you can pip install it using:

.. code-block:: bash

    pip install git+https://github.com/copasi/basico.git


Use the package
---------------

To start using the package, you simply import it:

.. code-block:: python

    >>> from basico import *

Loading a Model
---------------

You can load either COPASI, or SBML files directly using the
:func:`.load_model` command:

.. code-block:: python

    >>> load_model('brusselator.cps')

You can also load a model by providing a URL:

.. code-block:: python

    >>> load_model('https://fairdomhub.org/models/287/download?version-1')

We also provide a number of example models, that you can directly load
with the installation. See :func:`.get_examples` and :func:`.load_example`.

Models from the BioModels Database and JWS can also be directly loaded
( :mod:`.jws_online`, :mod:`.biomodels`, :func:`.load_biomodel`)

.. code-block:: python

    >>> load_biomodel(206)


Interrogating the Model
-----------------------

To find out what is in a model, you could use the corresponding
functions:

 * :func:`.get_species`
 * :func:`.get_reactions`
 * :func:`.get_parameters`
 * :func:`.get_compartments`

Analogous you can also set all of these, by providing the name
of the element to modify:

 * :func:`.set_species`
 * :func:`.set_reaction`
 * :func:`.set_parameters`
 * :func:`.set_compartment`

New elements are added with:

 * :func:`.add_species`
 * :func:`.add_reaction`
 * :func:`.add_parameter`
 * :func:`.add_compartment`

And removed with:

 * :func:`.remove_species`
 * :func:`.remove_reaction`
 * :func:`.remove_parameter`
 * :func:`.remove_compartment`


Analyzing the Model
-------------------

Currently the following analysis tasks have been included:

 * :mod:`.task_timecourse`
 * :mod:`.task_steadystate`
 * :mod:`.task_parameterestimation`

Saving a Model
---------------

Saving a model, is done by calling :func:`.save_model`:

.. code-block:: python

    >>> save_model('model_3.cps')

will save the file `model_3.cps` in the current folder. To export
the model to SBML use:

.. code-block:: python

    >>> save_model('model_3.xml', type-'sbml')


