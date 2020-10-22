from . import model_io
import COPASI
import logging
import re
import pandas
import numpy as np


def compartment_names(**kwargs):
    # type: (**kwargs) -> [str]
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    assert (isinstance(dm, COPASI.CDataModel))
    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()
    assert (isinstance(compartments, COPASI.CompartmentVectorNS))
    num_compartments = compartments.size()

    names = []

    # an array model has to have at least one chain comp[1] -> comp[2]
    for i in range(num_compartments):
        comp = compartments.get(i)
        assert (isinstance(comp, COPASI.CCompartment))
        name = comp.getObjectName()
        names.append(name)

    return names


def remove_template(**kwargs):
    """Removes the template model from the array model"""
    names = compartment_names(**kwargs)
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))
    exp = re.compile(r'([-a-zA-Z_0-9 ]+)\\[(\d+)\\]')

    compartments = model.getCompartments()
    assert (isinstance(compartments, COPASI.CompartmentVectorNS))

    for name in names:
        if not exp.match(name):
            comp = model.getCompartments().getByName(name)
            if comp is None:
                logging.warning("Could not find comp {0}".format(name))
            else:
                logging.warning("Removing {0} recursively".format(name))
                model.removeCompartment(comp.getKey(), True)
                model.compileIfNecessary()


def remove_arrays(**kwargs):
    """Removes arrays  from the model"""
    names = compartment_names(**kwargs)
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))
    exp = re.compile(r'([-a-zA-Z_0-9 ]+)\\[(\d+)\\]')

    for name in names:
        if exp.match(name):
            comp = model.getCompartments().getByName(name)
            if comp is None:
                logging.warning("Could not find comp {0}".format(name))
            else:
                logging.warning("Removing {0} recursively".format(name))
                model.removeCompartment(comp.getKey(), True)
                model.compileIfNecessary()


def plot_arrays_1d(df, species, **kwargs):
    # type:(pandas.DataFrame, str, **kwargs) -> pandas.DataFrame
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    names = compartment_names(**kwargs)

    candidates = []
    for name in df.columns:
        index = name.find('{')
        if index < 0:
            continue
        name = name[0:index]

        if species not in name:
            continue

        if name not in candidates:
            candidates.append(name)

    cols = []
    for compartment in names:
        for species in candidates:
            index = species + '{' + compartment + '}'
            if index not in df:
                continue
            cols.append(index)

    rows = []
    row_index = kwargs.get('index', df.index)
    num_rows = len(row_index)
    num_cols = len(cols)

    data = np.empty((num_rows, num_cols))

    for row in range(num_rows):
        rows.append(row_index[row])
        for col in range(num_cols):
            col_name = cols[col]
            data[row, col] = df[col_name][row_index[row]]

    return pandas.DataFrame(data, index=rows, columns=cols)
