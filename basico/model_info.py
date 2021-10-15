"""The model_info module contains basic functionality for interrogating the model.

Here all functionality for interrogating and manipulating the model is hosted. For each of the elements:

 * compartments
 * species
 * parameters
 * events
 * reactions

you will find functions to add, get, set, and remove them.

"""
import tempfile

import pandas as pd

from . import model_io
import pandas
import COPASI
import logging
import dateutil.parser
import datetime
import sys

MIRIAM_XML = 'http://copasi.org/static/miriam.xml' # noqa

try:
    from collections.abc import Iterable  # noqa
except ImportError:
    from collections import Iterable  # noqa

if sys.version_info[0] < 3:
    from io import open


def __status_to_int(status):
    # type: (str)->int
    codes = {
        "fixed": COPASI.CModelEntity.Status_FIXED,
        "assignment": COPASI.CModelEntity.Status_ASSIGNMENT,
        "ode": COPASI.CModelEntity.Status_ODE,
        "reactions": COPASI.CModelEntity.Status_REACTIONS,
        "time": COPASI.CModelEntity.Status_TIME,
    }
    return codes.get(status.lower(), COPASI.CModelEntity.Status_FIXED)


def __status_to_string(status):
    # type: (int)->str
    strings = {
        COPASI.CModelEntity.Status_FIXED: "fixed",
        COPASI.CModelEntity.Status_ASSIGNMENT: "assignment",
        COPASI.CModelEntity.Status_ODE: "ode",
        COPASI.CModelEntity.Status_REACTIONS: "reactions",
        COPASI.CModelEntity.Status_TIME: "time",
    }
    return strings.get(status, 'fixed')


def __line_type_to_int(line_type):
    # type: (str) -> int
    types = {
        'lines': 0,
        'points': 1,
        'symbols': 2,
        'both': 3,
        'lines_and_symbols': 3
    }
    return types.get(line_type, 0)


def __line_type_to_string(line_type):
    # type: (int) -> str
    types = {
        0: 'lines',
        1: 'points',
        2: 'symbols',
        3: 'lines_and_symbols'
    }
    return types.get(line_type, 'lines')


def __line_subtype_to_int(sub_type):
    # type: (str) -> int
    types = {
        'solid': 0,
        'dotted': 1,
        'dashed': 2,
        'dot_dash': 3,
        'dot_dot_dash': 4
    }
    return types.get(sub_type, 0)


def __line_subtype_to_string(sub_type):
    # type: (int) -> str
    types = {
        0: 'solid',
        1: 'dotted',
        2: 'dashed',
        3: 'dot_dash',
        4: 'dot_dot_dash'
    }
    return types.get(sub_type, 'solid')


def __symbol_to_int(symbol_type):
    # type: (str) -> int
    types = {
        'small_cross': 0,
        'large_cross': 1,
        'circle': 2
    }
    return types.get(symbol_type, 0)


def __symbol_to_string(symbol_type):
    # type: (int) -> str
    types = {
        0: 'small_cross',
        1: 'large_cross',
        2: 'circle'
    }
    return types.get(symbol_type, 'small_cross')


def __curve_type_to_int(curve_type):
    # type: (str) -> int
    types = {
        'curve2d': 1,
        'histoItem1d': 2,
        'bandedGraph': 3,
        'spectogram': 7
    }
    return types.get(curve_type, 1)


def __curve_type_to_string(curve_type):
    # type: (int) -> str
    types = {
        1: 'curve2d',
        2: 'histoItem1d',
        3: 'bandedGraph',
        7: 'spectogram'
    }
    return types.get(curve_type, 'curve2d')


def __function_type_to_int(function_type):
    # type: (str) -> int
    types = {
        'general': -1,
        'reversible': 1,
        'irreversible': 0
    }
    return types.get(function_type, -1)


def __function_type_to_string(function_type):
    # type: (int) -> str
    types = {
        -1: 'general',
        1: 'reversible',
        0: 'irreversible'
    }
    return types.get(function_type, 'general')


def __usage_to_int(usage):
    # type:  (str) -> int
    types = {
        "substrate": 0,
        "product": 1,
        "modifier": 2,
        "parameter": 3,
        "volume": 4,
        "time": 5,
        "variable": 6,
        "temporary": 7,
    }
    return types.get(usage, 3)


def __usage_to_string(usage):
    # type:  (int) -> str
    types = {
        0: "substrate",
        1: "product",
        2: "modifier",
        3: "parameter",
        4: "volume",
        5: "time",
        6: "variable",
        7: "temporary",
    }
    return types.get(usage, "parameter")


def get_species(name=None, **kwargs):
    """Returns all information about the species as pandas dataframe.

    Example:

    Assume you have the brusselator example loaded `load_example('brusselator')`

        >>> get_species()

    returns you a dataframe of all species with the species name as index.

        >>> get_species('X')

    returns you only those species, that include `X` in the name.


    :param name: optional filter expression for the species, if it is not included in the species name,
                 the species will not be added to the data set.
    :type name: str

    :param kwargs: optional arguments to further filter down the species. recognized are:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

     * `compartment`: to filter down only species in specific compartments

     * `type`: to filter for species of specific simulation type

    :return: a pandas dataframe with the information about the species
    :rtype: pandas.DataFrame
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    model.compileIfNecessary()

    metabs = model.getMetabolitesX()
    assert(isinstance(metabs, COPASI.MetabVector))

    num_metabs = metabs.size()
    data = []

    for i in range(num_metabs):
        metab = metabs.get(i)
        assert (isinstance(metab, COPASI.CMetab))

        unit = metab.getUnitExpression()
        if not unit:
            unit = model.getQuantityUnit() + '/' + model.getVolumeUnit()

        metab_data = {
            'name': metab.getObjectName(),
            'compartment': metab.getCompartment().getObjectName(),
            'type': __status_to_string(metab.getStatus()),
            'unit': unit,
            'initial_concentration': metab.getInitialConcentration(),
            'initial_particle_number': metab.getInitialValue(),
            'initial_expression': _replace_cns_with_names(metab.getInitialExpression()),
            'expression': _replace_cns_with_names(metab.getExpression()),
            'concentration': metab.getConcentration(),
            'particle_number': metab.getValue(),
            'rate': metab.getConcentrationRate(),
            'particle_number_rate': metab.getRate(),
            'key': metab.getKey(),
            'sbml_id': metab.getSBMLId()
        }

        display_name = metab.getObjectDisplayName()

        if 'name' in kwargs and not kwargs['name'] in metab_data['name']:
            continue

        if name and type(name) is str and name not in metab_data['name'] and name not in display_name:
            continue

        if name and isinstance(name, Iterable) and name not in metab_data['name'] and display_name not in name:
            continue

        if 'compartment' in kwargs and not kwargs['compartment'] in metab_data['compartment']:
            continue

        if 'type' in kwargs and kwargs['type'] not in metab_data['type']:
            continue

        if 'sbml_id' in kwargs and kwargs['sbml_id']  != metab_data['sbml_id']:
            continue

        data.append(metab_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_events(name=None, **kwargs):
    """Returns all information about the events as pandas dataframe.

    :param name: optional filter expression for the event, if it is not included in the event name,
                 the event will not be added to the data set.
    :type name: str

    :param kwargs: optional arguments:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

    :return: a pandas dataframe with the information about the event
    :rtype: pandas.DataFrame
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    events = model.getEvents()

    num_events = events.size()
    data = []

    for i in range(num_events):
        event = events.get(i)
        assert (isinstance(event, COPASI.CEvent))

        assignments = []
        for j in range(event.getNumAssignments()):
            ea = event.getAssignment(j)
            assert (isinstance(ea, COPASI.CEventAssignment))
            target = ea.getTargetObject()
            if target is None:
                continue
            assignments.append(
                {
                    'target': target.getObjectDisplayName(),
                    'expression': _replace_cns_with_names(ea.getExpression(), model=dm)
                })

        event_data = {
            'name': event.getObjectName(),
            'trigger': _replace_cns_with_names(event.getTriggerExpression(), model=dm),
            'delay': _replace_cns_with_names(event.getDelayExpression(), model=dm),
            'assignments': assignments,
            'key': event.getKey(),
            'sbml_id': event.getSBMLId()
        }

        if 'name' in kwargs and not kwargs['name'] in event_data['name']:
            continue

        if name and name not in event_data['name']:
            continue

        if 'sbml_id' in kwargs and kwargs['sbml_id'] != event_data['sbml_id']:
            continue

        data.append(event_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_plots(name=None, **kwargs):
    """Returns all information about the plot definitions as pandas dataframe.

    :param name: optional filter expression for the plots, if it is not included in the plot name,
                 the plot will not be added to the data set.
    :type name: str

    :param kwargs: optional arguments:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

    :return: a pandas dataframe with the information about the plot see also :func:`.get_plot_dict`
    :rtype: pandas.DataFrame
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    data = []

    for i in range(dm.getNumPlotSpecifications()):
        plot_spec = dm.getPlotSpecification(i)
        assert (isinstance(plot_spec, COPASI.CPlotSpecification))

        plot_data = get_plot_dict(plot_spec, model=dm)

        if 'name' in kwargs and not kwargs['name'] in plot_data['name']:
            continue

        if name and name not in plot_data['name']:
            continue

        data.append(plot_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_plot_dict(plot_spec, **kwargs):
    """Returns the information for the specified plot

        :param plot_spec: the name, index or plot specification object
        :type plot_spec: Union[str,int,COPASI.CPlotSpecification]

        :param kwargs: optional arguments

            - | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: dictionary of the form:
                | {
                |  'name': 'Phase Plot',
                |  'active': True,
                |  'log_x': False,
                |  'log_y': False,
                |  'tasks': '',
                |  'curves':
                |   [
                |     {
                |       'name': '[Y]|[X]', # the name of the curve
                |       'type': 'curve2d',# type of the curve (one of `curve2d`, `histoItem1d`, `bandedGraph`
                |                           or `spectogram`)
                |       'channels': ['[X]', '[Y]'],  # display names of all the items to be plotted
                |       'color': 'auto', # color as hex rgb value (i.e '#ff0000' for red) or 'auto'
                |       'line_type': 'lines',# the line type (one of `lines`, `points`, `symbols` or
                |                                            `lines_and_symbols`)
                |       'line_subtype': 'solid', # line subtype (one of `solid`, `dotted`, `dashed`, `dot_dash` or
                |                                 `dot_dot_dash`)
                |       'line_width': 2.0, # line width
                |       'symbol': 'small_cross', # the symbol to be used (one of `small_cross`, `large_cross`
                |                                or `circle` )
                |       'activity': 'during' # when the data should be collected (one of 'before', 'during', 'after')
                |                              from task
                |     }
                |   ]
                | }

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(plot_spec, str) or isinstance(plot_spec, int):
        spec = dm.getPlotSpecification(plot_spec)
        if spec is None:
            logging.error('No plot specification: {0}'.format(plot_spec))
            return

        plot_spec = spec

    curves = []
    for j in range(plot_spec.getNumPlotItems()):
        plot_item = plot_spec.getItem(j)
        assert (isinstance(plot_item, COPASI.CPlotItem))
        curve_data = {
            'name': plot_item.getObjectName(),
            'type': __curve_type_to_string(plot_item.getType()),
            'channels': []
        }

        if plot_item.getParameter('Color'):
            curve_data['color'] = plot_item.getParameter('Color').getValue()
        if plot_item.getParameter('Line type'):
            curve_data['line_type'] = __line_type_to_string(plot_item.getParameter('Line type').getValue())
        if plot_item.getParameter('Line subtype'):
            curve_data['line_subtype'] = __line_subtype_to_string(plot_item.getParameter('Line subtype').getValue())
        if plot_item.getParameter('Line width'):
            curve_data['line_width'] = plot_item.getParameter('Line width').getValue()
        if plot_item.getParameter('Symbol subtype'):
            curve_data['symbol'] = __symbol_to_string(plot_item.getParameter('Symbol subtype').getValue())
        if plot_item.getParameter('Recording Activity'):
            curve_data['activity'] = plot_item.getParameter('Recording Activity').getValue()
        if plot_item.getParameter('increment'):
            curve_data['increment'] = plot_item.getParameter('increment').getValue()
        if plot_item.getParameter('logZ'):
            curve_data['log_z'] = plot_item.getParameter('logZ').getValue()
        if plot_item.getParameter('colorMap'):
            curve_data['color_map'] = plot_item.getParameter('colorMap').getValue()
        if plot_item.getParameter('bilinear'):
            curve_data['bilinear'] = plot_item.getParameter('bilinear').getValue()
        if plot_item.getParameter('contours'):
            curve_data['contours'] = plot_item.getParameter('contours').getValue()
        if plot_item.getParameter('maxZ'):
            curve_data['max_z'] = plot_item.getParameter('maxZ').getValue()

        channels = plot_item.getChannels()
        for k in range(channels.size()):
            channel_obj = dm.getObject(channels[k])
            if channel_obj is None:
                continue
            curve_data['channels'].append(channel_obj.getObjectDisplayName())

        curves.append(curve_data)

    plot_data = {
        'name': plot_spec.getObjectName(),
        'active': plot_spec.isActive(),
        'log_x': plot_spec.isLogX(),
        'log_y': plot_spec.isLogY(),
        'tasks': plot_spec.getTaskTypes(),
        'curves': curves
    }

    return plot_data


def set_plot_curves(plot_spec, curves, **kwargs):
    """Sets all curves of the named plot specification (all curves will be replaced)

        :param plot_spec: the name, index or plot specification object
        :type plot_spec: Union[str,int,COPASI.CPlotSpecification]

        :param curves: | list of dictionaries of curve items to be added. For example
              |
              | [
              |   {
              |    'name': '[Y]|[X]',          # the name of the curve
              |    'type': 'curve2d',          # type of the curve (one of `curve2d`, `histoItem1d`, `bandedGraph`
              |                                  or `spectogram`)
              |    'channels': ['[X]', '[Y]'], # display names of all the items to be plotted
              |    'color': 'auto',            # color as hex rgb value (i.e '#ff0000' for red) or 'auto'
              |    'line_type': 'lines',       # the line type (one of `lines`, `points`, `symbols` or 
              |                                  `lines_and_symbols`)
              |    'line_subtype': 'solid',    #  line subtype (one of `solid`, `dotted`, `dashed`, `dot_dash` or
              |                                   `dot_dot_dash`)
              |    'line_width': 2.0,          # line width
              |    'symbol': 'small_cross',    # the symbol to be used (one of `small_cross`, `large_cross` or `circle`)
              |    'activity': 'during'   # when the data should be collected (one of 'before', 'during', 'after')
              |   }
              | ]
              |
              | Additionally, histograms may have the bin size in a `increment` element. Spectograms can have
              | `log_z`, `color_map` (one of 'Default', 'Yellow-Red', 'Grayscale' or 'Blue-White-Red'),
              | 'bilinear' (should the plot interpolate between values), 'contours' (at which values to draw contours)
              | 'max_z' (max z value).

        :type curves: [{}]

        :param kwargs: optional arguments

            - | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: None
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(plot_spec, str) or isinstance(plot_spec, int):
        spec = dm.getPlotSpecification(plot_spec)
        if spec is None:
            logging.error('No plot specification: {0}'.format(plot_spec))
            return

        plot_spec = spec

    assert (isinstance(plot_spec, COPASI.CPlotSpecification))

    plot_spec.cleanup()

    if not curves:
        return

    for curve in curves:
        name = curve['name'] if 'name' in curve else 'curve_{0}'.format(plot_spec.getNumPlotItems())
        curve_type = __curve_type_to_int(curve['type']) if 'type' in curve else 1

        plot_item = plot_spec.createItem(name, curve_type)
        assert (isinstance(plot_item, COPASI.CPlotItem))

        color = curve['color'] if 'color' in curve else 'auto'
        if plot_item.getParameter('Color'):
            plot_item.getParameter('Color').setStringValue(color)
        line_subtype = __line_subtype_to_int(curve['line_subtype']) if 'line_subtype' in curve else 0
        if plot_item.getParameter('Line subtype'):
            plot_item.getParameter('Line subtype').setValue(line_subtype)
        line_type = __line_type_to_int(curve['line_type']) if 'line_type' in curve else 0
        if plot_item.getParameter('Line type'):
            plot_item.getParameter('Line type').setValue(line_type)
        line_width = curve['line_width'] if 'line_width' in curve else 2.0
        if plot_item.getParameter('Line width'):
            plot_item.getParameter('Line width').setValue(line_width)
        symbol = __symbol_to_int(curve['symbol']) if 'symbol' in curve else 0
        if plot_item.getParameter('Symbol subtype'):
            plot_item.getParameter('Symbol subtype').setValue(symbol)
        activity = curve['activity'] if 'activity' in curve else 'during'
        if plot_item.getParameter('Recording Activity'):
            plot_item.getParameter('Recording Activity').setValue(activity)

        if plot_item.getParameter('increment') and 'increment' in curve:
            plot_item.getParameter('increment').setValue(curve['increment'])
        if plot_item.getParameter('logZ') and 'log_z' in curve:
            plot_item.getParameter('logZ').setValue(curve['log_z'])
        if plot_item.getParameter('colorMap') and 'color_map' in curve:
            plot_item.getParameter('colorMap').setValue(curve['color_map'])
        if plot_item.getParameter('bilinear') and 'bilinear' in curve:
            plot_item.getParameter('bilinear').setValue(curve['bilinear'])
        if plot_item.getParameter('contours') and 'contours' in curve:
            plot_item.getParameter('contours').setValue(curve['contours'])
        if plot_item.getParameter('maxZ') and 'max_z' in curve:
            plot_item.getParameter('maxZ').setValue(curve['max_z'])

        if 'channels' in curve:
            for channel in curve['channels']:
                obj = dm.findObjectByDisplayName(channel)
                if channel == 'Time':
                    obj = dm.getModel().getValueReference()
                if obj is None:
                    logging.warning("Couldn't resolve {0} when adding curve spec".format(channel))
                    continue
                plot_item.addChannel(COPASI.CPlotDataChannelSpec(obj.getCN()))


def add_plot(name, **kwargs):
    """Adds a new plot specification to the model.

        :param name: the name for the new plot specification
        :type name: str

        :param kwargs: optional parameters, recognized are:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

            * all other parameters from :func:`set_plot_dict`.

        :return: the plot
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    plot_spec = dm.getPlotDefinitionList().createPlotSpec(name, COPASI.CPlotItem.plot2d)

    if not plot_spec:
        raise ValueError('A plot named ' + name + ' already exists')

    set_plot_dict(plot_spec, **kwargs)

    return plot_spec


def set_plot_dict(plot_spec, active=True, log_x=False, log_y=False, tasks='', **kwargs):
    """Sets properties of the named plot specification.

        :param plot_spec: the name, index or plot specification object
        :type plot_spec: Union[str,int,COPASI.CPlotSpecification]

        :param active: boolean indicating whether plot should be active (defaults to true)
        :type active: bool

        :param log_x: boolean indicating that the x axis should be logarithmic
        :type log_x: bool

        :param log_y: boolean indicating that the y axis should be logarithmic
        :type log_y: bool

        :param tasks: | task type (or colon separated list of task types) for which the plot
                      | should be brought up
        :type tasks: str

        :param kwargs: optional arguments

            - | `new_name`: to rename the plot specification

            - | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

            - `curves`: dictionary in the format as described in :func:`set_plot_curves`.

        :return: None
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(plot_spec, str) or isinstance(plot_spec, int):
        spec = dm.getPlotSpecification(plot_spec)
        if spec is None:
            logging.error('No plot specification: {0}'.format(plot_spec))
            return

        plot_spec = spec

    assert (isinstance(plot_spec, COPASI.CPlotSpecification))

    plot_spec.setActive(active)
    plot_spec.setLogX(log_x)
    plot_spec.setLogY(log_y)
    plot_spec.setTaskTypes(tasks)

    if 'curves' in kwargs:
        set_plot_curves(plot_spec, **kwargs)

    if 'new_name' in kwargs:
        plot_spec.setObjectName(kwargs['new_name'])


def _replace_names_with_cns(expression, **kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    resulting_expression = ''
    expression = expression.replace('{', ' {')
    expression = expression.replace('}', '} ')
    for word in expression.split():
        if word.startswith('{') and word.endswith('}'):
            word = word[1:-1]

        obj = dm.findObjectByDisplayName(word)
        if obj is not None:
            if isinstance(obj, COPASI.CModel):
                obj = obj.getValueReference()
            resulting_expression += ' <{0}>'.format(obj.getCN())
        else:
            resulting_expression += ' ' + word

    return resulting_expression.strip()


def _split_by_cn(expression):
    result = []
    current = ''
    num_chars = len(expression)
    pos = 0
    while pos < num_chars:
        has_more = pos + 4 < num_chars
        cur_char = expression[pos]

        if cur_char == '<' and has_more:

            next_3 = expression[pos:pos+4]

            if next_3.startswith('<CN='):
                end = expression.find('>', pos)
                cn = expression[pos+1: end]
                result.append(cn)
                pos = end + 1
                current = ''
                continue

        if cur_char in '/*+-()^%<>!=&|':

            if current:
                result.append(current)
                current = ''

            if pos + 1 < num_chars and expression[pos + 1] == '=':
                cur_char += '='
                pos += 1
            result.append(cur_char)

        elif cur_char != ' ':
            current += cur_char

        pos += 1

    if current:
        result.append(current)

    return result


def _replace_cns_with_names(expression, **kwargs):
    if not expression:
        return expression

    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    resulting_expression = ''
    words = _split_by_cn(expression)
    skip = -1
    for i in range(len(words)):
        if i < skip: 
            continue

        word = words[i]
        if word.startswith('<CN') and word.endswith('>'):
            word = word[1:-1]
            cn = word
            word = ''
        elif word.startswith('<CN'):
            cn = word[1:] 
            i = i + 1
            while not words[i].endswith('>'):
                cn += ' ' + words[i]
                i = i + 1
            cn += ' ' + words[i][:-1]
            i = i + 1
            skip = i
            word = ''
        elif word.startswith('CN='):
            cn = word
            word = ''
        else: 
            cn = None

        if cn is not None: 
            obj = dm.getObject(COPASI.CCommonName(cn))
            if obj is not None:
                word = obj.getObjectDisplayName()
        resulting_expression += ' ' + word

    return resulting_expression.strip()


def set_notes(notes, **kwargs):
    """Sets notes on the provided element

    :param notes: the notes to be set, can be either plain text, or valid xhtml
    :type notes: str

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)
        * | `name`: the display name of the element to set the notes on.
          | otherwise the main model will be taken.
        * | `element`: any model element

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = dm.findObjectByDisplayName(kwargs['name'])
        if element is None:
            logging.warning("Couldn't find element {0} to set notes.".format(kwargs['name']))
            return

    if element is None:
        logging.warning("Couldn't find element to set notes.")
        return

    if isinstance(element, COPASI.CDataObject):
        element = COPASI.CAnnotation.castObject(element)

    if isinstance(element, COPASI.CAnnotation):
        element.setNotes(notes)
    else:
        logging.warning("Unsupported element type for setting notes.")


def get_notes(**kwargs):
    """Returns all notes on the element or model.

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)
        * | `name`: the display name of the element to set the notes on.
          | otherwise the main model will be taken.
        * | `element`: any model element

    :return: the notes string (plain text, or xhtml)
    :rtype: str
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = dm.findObjectByDisplayName(kwargs['name'])
        if element is None:
            logging.warning("Couldn't find element {0} to get notes.".format(kwargs['name']))
            return None

    if element is None:
        logging.warning("Couldn't find element to get notes.")
        return None

    if isinstance(element, COPASI.CDataObject):
        element = COPASI.CAnnotation.castObject(element)

    if isinstance(element, COPASI.CAnnotation):
        return element.getNotes()
    else:
        logging.warning("Unsupported element type for getting notes.")
    return None


def get_miriam_annotation(**kwargs):
    """Returns the elements miriam annotations as dictionary of the form:

    {
        'created': datetime,
        'creators': [{
            'first_name': '...',
            'last_name': '...',
            'email': '...',
            'organization': '...'
        },...],

        'references': [{
            'id': '...',
            'uri': 'identifiers.org uri',
            'resource': 'human readable name of resource',
            'description', '...'
        },...],

        'descriptions': [{
            'id': '...',
            'qualifier': 'human readable qualifier string',
            'uri': 'identifiers.org uri',
            'resource': 'name of the resource referenced'
        },...],
        'modifications': [datetime,...]
    }

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)
        * | `name`: the display name of the element to set the notes on.
          | otherwise the main model will be taken.
        * | `element`: any model element

    :return: the elements annotation as dictionary as described
    :rtype: {}
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = dm.findObjectByDisplayName(kwargs['name'])
        if element is None:
            logging.warning("Couldn't find element {0} to get annotations.".format(kwargs['name']))
            return None

    if element is None:
        logging.warning("Couldn't find element to get annotations.")
        return None

    if isinstance(element, COPASI.CDataObject):
        info = COPASI.CMIRIAMInfo()
        info.load(element)
        result = {'creators': [], 'references': [],
                  'descriptions': [], 'modifications': []}

        try:
            dt = dateutil.parser.isoparse(info.getCreatedDT())
            result['created'] = dt
        except ValueError:
            pass

        for creator in info.getCreators():
            result['creators'].append({
                'first_name': creator.getGivenName(),
                'last_name': creator.getFamilyName(),
                'email': creator.getEmail(),
                'organization': creator.getORG()
            })

        for reference in info.getReferences():
            result['references'].append({
                'id': reference.getId(),
                'uri': reference.getMIRIAMResourceObject().getIdentifiersOrgURL(),
                'resource': reference.getResource(),
                'description': reference.getDescription()
            })

        for description in info.getBiologicalDescriptions():
            assert (isinstance(description, COPASI.CBiologicalDescription))
            result['descriptions'].append({
                'id': description.getId(),
                'qualifier': description.getPredicate(),
                'uri': description.getMIRIAMResourceObject().getIdentifiersOrgURL(),
                'resource': description.getResource(),
            })

        for modification in info.getModifications():
            assert (isinstance(modification, COPASI.CModification))
            result['modifications'].append(dateutil.parser.isoparse(modification.getDate()))

        for key in ['creators', 'references', 'descriptions', 'modifications']:
            if len(result[key]) == 0:
                del result[key]

        return result
    else:
        logging.warning("Unsupported element type for getting annotations.")
    return None


def set_miriam_annotation(created=None, creators=None, references=None, descriptions=None, modifications=None,
                          replace=True,
                          **kwargs):
    """Sets the MIRIAM annotations for the provided element or model

    :param created: the date/time to set as the objects creation time or None, if not to be set
    :type created: datetime.datetime or None

    :param creators: | None, if not to be modified, otherwise list of creators of the form:
                     | {
                     |  'first_name': '...',
                     |  'last_name': '...',
                     |  'email': '...',
                     |  'organization': '...'
                     | }
    :type creators: list or None

    :param references: | None if not to be modified, otherwise list of references of the form:
                       |
                       | {
                       |   'resource': 'human readable name of resource',
                       |   'id': '...',
                       |   'uri': 'identifiers.org uri',
                       |   'description', '...'
                       | }
                       |
                       | only the uri needs to be provided, or alternatively id + resource.
    :type references: list or None

    :param descriptions: | None if not to be modified, otherwise list of descriptions of the form:
                         |
                         | {
                         |   'resource': 'human readable name of resource',
                         |   'id': '...',
                         |   'qualifier': '...',
                         |   'uri': 'identifiers.org uri',
                         | }
                         |
                         | only the uri needs to be provided, or alternatively id + resource.

    :type descriptions: list or None

    :param modifications: | None if not to be modified, otherwise list of datetime objects representing
                          | modification dates
    :type modifications: list or None

    :param replace: Boolean indicating whether existing entries should be removed.
    :type replace: bool

        :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)
        * | `name`: the display name of the element to set the notes on.
          | otherwise the main model will be taken.
        * | `element`: any model element

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = dm.findObjectByDisplayName(kwargs['name'])
        if element is None:
            logging.warning("Couldn't find element {0} to set annotations.".format(kwargs['name']))
            return

    if element is None:
        logging.warning("Couldn't find element to set annotations.")
        return

    if not isinstance(element, COPASI.CDataObject):
        logging.warning("Unsupported element type for setting annotations.")
        return

    info = COPASI.CMIRIAMInfo()
    info.load(element)

    if created is not None and isinstance(created, datetime.datetime):
        info.setCreatedDT(created.isoformat())

    if creators is not None:
        if replace:
            _remove_creators(info)
        for creator in creators:
            c = info.createCreator('')
            assert (isinstance(c, COPASI.CCreator))
            if 'first_name' in creator:
                c.setGivenName(creator['first_name'])
            if 'last_name' in creator:
                c.setFamilyName(creator['last_name'])
            if 'email' in creator:
                c.setEmail(creator['email'])
            if 'organization' in creator:
                c.setORG(creator['organization'])

    if references is not None:
        if replace:
            _remove_references(info)
        for reference in references:
            r = info.createReference('')
            assert (isinstance(r, COPASI.CReference))
            if 'resource' in reference:
                r.setResource(reference['resource'])
            if 'id' in reference:
                r.setId(reference['id'])
            if 'description' in reference:
                r.setDescription(reference['description'])
            if 'uri' in reference:
                r.getMIRIAMResourceObject().setURI(reference['uri'])

    if descriptions is not None:
        if replace:
            _remove_descriptions(info)
        for desc in descriptions:
            d = info.createBiologicalDescription()
            assert (isinstance(d, COPASI.CBiologicalDescription))
            if 'qualifier' in desc:
                d.setPredicate(desc['qualifier'])
            if 'resource' in desc:
                d.setResource(desc['resource'])
            if 'id' in desc:
                d.setId(desc['id'])
            if 'uri' in desc:
                d.getMIRIAMResourceObject().setURI(desc['uri'])

    if modifications is not None:
        if replace:
            _remove_modifications(info)
        for modification in modifications:
            m = info.createModification('')
            assert (isinstance(m, COPASI.CModification))
            m.setDate(modification.isoformat())

    info.save()


def _remove_modifications(info):
    num_entries = info.getModifications().size()
    for i in range(num_entries):
        info.removeModification(info.getModifications().get(0))


def _remove_descriptions(info):
    num_entries = info.getBiologicalDescriptions().size()
    for i in range(num_entries):
        info.removeBiologicalDescription(info.getBiologicalDescriptions().get(0))


def _remove_references(info):
    num_entries = info.getReferences().size()
    for i in range(num_entries):
        info.removeReference(info.getReferences().get(0))


def _remove_creators(info):
    num_entries = info.getCreators().size()
    for i in range(num_entries):
        info.removeCreator(info.getCreators().get(0))


def add_compartment(name, initial_size=1.0, **kwargs):
    """Adds a new compartment to the model.

    :param name: the name for the new compartment
    :type name: str

    :param initial_size: the initial size for the compartment
    :type initial_size: float

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

        * all other parameters from :func:`set_compartment`.

    :return: the compartment added
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartment = model.createCompartment(name, initial_size)
    if compartment is None:
        raise ValueError('A compartment named ' + name + ' already exists')

    set_compartment(name, **kwargs)

    return compartment


def add_function(name, infix, type='general', mapping=None, **kwargs):
    """Adds a new function definition if none with that name already exists

    :param name: the name for the new function
    :type name: str

    :param infix: the formula for the new function (e.g: `V * S / ( K + S )`)
    :type infix: str

    :param type: optional flag specifying whether the function is
                 'reversible', 'irreversible' or 'general'
    :type type: str

    :param mapping: optional dictionary mapping the elements of the infix
           to their usage. If not specified, the usage will default to `parameter`,
           other values possible would be `substrate`, `product`, `modifier`, `volume or
           `time`. One example for the infix for the infix above  we would specify that
           `S` is `substrate`:

           { 'S': 'substrate' }

    :type mapping: dict

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    db = root.getFunctionList()
    assert (isinstance(db, COPASI.CFunctionDB))
    functions = db.loadedFunctions()

    if mapping is None:
        mapping = {}
    
    if db.findLoadFunction(name) is not None:
        logging.error('A function with name "' + name + '" already exists')
        return

    fun = db.createFunction(name, COPASI.CEvaluationTree.Function)
    if fun is None:
        logging.error('Could not create a function with name "' + name + '" already exists')
        return

    fun.setInfix(infix)
    fun.setReversible(__function_type_to_int(type))

    variables = fun.getVariables()
    assert(isinstance(variables, COPASI.CFunctionParameters))

    for i in range(variables.size()):
        param = variables.getParameter(i)
        assert(isinstance(param, COPASI.CFunctionParameter))
        usage = __usage_to_int(mapping.get(param.getObjectName(), 'parameter'))
        param.setUsage(usage)

    return fun


def remove_function(name, **kwargs):
    """Removes the function with the given name

    :param name: the name of the function to be removed
    :type name: str

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    db = root.getFunctionList()
    assert(isinstance(db, COPASI.CFunctionDB))

    fun = db.findFunction(name)
    assert(isinstance(fun, COPASI.CFunction))
    if fun is None:
        logging.warning('A function with name "' + name + '" does not exists')
        return

    if fun.isReadOnly():
        logging.error('The function "' + name + '" is readonly and cannot be deleted')
        return

    key = fun.getKey()
    fun = None

    db.removeFunction(key)


def remove_user_defined_functions():
    """Removes all user defined functions along with all elements that still use them
    """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    db = root.getFunctionList()
    assert(isinstance(db, COPASI.CFunctionDB))
    funs = db.loadedFunctions()

    to_be_deleted = []

    for i in range(funs.size()):
        fun = funs.get(i)
        if fun is None:
            continue
        if fun.isReadOnly():
            continue
        to_be_deleted.append(fun.getKey())

    for key in to_be_deleted:
        db.removeFunction(key)


def add_species(name, compartment_name='', initial_concentration=1.0, **kwargs):
    """Adds a new species to the model.

        :param name: the name for the new species
        :type name: str

        :param compartment_name: optional the name of the compartment in which the species should be
               created, it will default to the first compartment. If no compartment is present,
               a unit compartment named `compartment` will be created.
        :type compartment_name: str

        :param initial_concentration: optional the initial concentration of the species
        :type initial_concentration: float

        :param kwargs: optional parameters, recognized are:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)
            * all other parameters from :func:`set_species`.

        :return: the newly created species
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    # create compartment if it does not yet exist
    if not compartment_name:
        if model.getNumCompartments() == 0:
            model.createCompartment('compartment', 1)
        compartment_name = model.getCompartment(0).getObjectName()

    species = model.createMetabolite(name, compartment_name, initial_concentration)
    if species is None:
        raise ValueError('A species named ' + name + ' already exists in compartment ' + compartment_name)

    set_species(name, **kwargs)

    return species


def add_parameter(name, initial_value=1.0, **kwargs):
    """Adds a new global parameter to the model.

        :param name: the name for the new global parameter
        :type name: str

        :param initial_value: optional the initial value of the parameter (defaults to 1)
        :type initial_value: float

        :param kwargs: optional parameters, recognized are:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

            * all other parameters from :func:`set_parameters`.

        :return: the newly created parameter
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameter = model.createModelValue(name, initial_value)
    if parameter is None:
        raise ValueError('A global parameter named ' + name + ' already exists')

    set_parameters(name, **kwargs)

    return parameter


def add_event(name, trigger, assignments, **kwargs):
    """Adds a new event to the model.

        :param name: the name for the new event
        :type name: str

        :param trigger: the trigger expression to be used. The expression can consist of all display names.
               for example `Time > 10` would make the event trigger at time 10.
        :type trigger: str

        :param assignments: All the assignments that should be made, when the event fires. This should be a
                list of tuples where the first element is the name of the element to change, and the second element
                the assignment expression.
        :type assignments: [(str,str)]

        :param kwargs: optional parameters, recognized are:

             * | `model`: to specify the data model to be used (if not specified
               | the one from :func:`.get_current_model` will be taken)

        :return: the newly created event
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    event = model.createEvent(name)
    if event is None:
        raise ValueError('An Event named ' + name + ' already exists')
    assert (isinstance(event, COPASI.CEvent))

    event.setTriggerExpression(_replace_names_with_cns(trigger, model=dm))
    for assignment in assignments:
        ea = event.createAssignment()
        assert (isinstance(ea, COPASI.CEventAssignment))
        target = dm.findObjectByDisplayName(assignment[0])
        if target is None:
            logging.warning("Couldn't resolve target for event assignment {0}, skipping.".format(assignment[0]))
            continue
        ea.setTargetCN(target.getCN())
        ea.setExpression(_replace_names_with_cns(assignment[1], model=dm))

    model.compileIfNecessary()
    return event


def add_reaction(name, scheme, **kwargs):
    """Adds a new reaction to the model

        :param name: the name for the new reaction
        :type name: str

        :param scheme: the reaction scheme for the new reaction, if it includes Species that do not exist yet
               in the model they will be created. So for example a scheme of `A -> B` would create species `A`
               and `B` if they would not exist in the model, before creating the irreversible reaction.
        :type scheme: str

        :param kwargs: optional parameters, recognized are:

           * | `model`: to specify the data model to be used (if not specified
             | the one from :func:`.get_current_model` will be taken)

           * all other parameters from :func:`set_reaction`.

        :return: the newly created reaction
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reaction = model.createReaction(name)
    if reaction is None:
        raise ValueError('A reaction named ' + name + ' already exists')

    assert (isinstance(reaction, COPASI.CReaction))
    set_reaction(name, scheme=scheme, **kwargs)

    return reaction


def get_compartments(name=None, **kwargs):
    """Returns all information about the compartments as pandas dataframe.

        :param name: optional filter expression for the compartment, if it is not included in the name,
                     the compartment will not be added to the data set.
        :type name: str

        :param kwargs: optional arguments:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: a pandas dataframe with the information about the compartment
        :rtype: pandas.DataFrame
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()
    assert(isinstance(compartments, COPASI.CompartmentVectorNS))

    num_compartments = compartments.size()
    data = []

    for i in range(num_compartments):
        compartment = compartments.get(i)
        assert (isinstance(compartment, COPASI.CCompartment))

        unit = compartment.getUnitExpression()
        if not unit:
            unit = model.getVolumeUnit()

        comp_data = {
            'name': compartment.getObjectName(),
            'type': __status_to_string(compartment.getStatus()),
            'unit': unit,
            'initial_size': compartment.getInitialValue(),
            'initial_expression': _replace_cns_with_names(compartment.getInitialExpression()),
            'dimensionality': compartment.getDimensionality(),
            'expression': _replace_cns_with_names(compartment.getExpression()),
            'size': compartment.getValue(),
            'rate': compartment.getRate(),
            'key': compartment.getKey(),
            'sbml_id': compartment.getSBMLId()
        }

        if 'name' in kwargs and kwargs['name'] not in comp_data['name']:
            continue

        if name and name not in comp_data['name']:
            continue

        if 'type' in kwargs and kwargs['type'] not in comp_data['type']:
            continue

        if 'sbml_id' in kwargs and kwargs['sbml_id'] != comp_data['sbml_id']:
            continue

        data.append(comp_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_parameters(name=None, **kwargs):
    """Returns all information about the global parameters as pandas dataframe.

        :param name: optional filter expression for the parameters, if it is not included in the name,
                     the parameter will not be added to the data set.
        :type name: str
        :param kwargs: optional arguments:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: a pandas dataframe with the information about the parameter
        :rtype: pandas.DataFrame
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameters = model.getModelValues()
    assert(isinstance(parameters, COPASI.ModelValueVectorN))

    num_params = parameters.size()
    data = []

    for i in range(num_params):
        param = parameters.get(i)
        assert (isinstance(param, COPASI.CModelValue))

        unit = param.getUnitExpression()
        if 'unit' in kwargs and not kwargs['unit'] in unit:
            continue

        param_data = {
            'name': param.getObjectName(),
            'type': __status_to_string(param.getStatus()),
            'unit': unit,
            'initial_value': param.getInitialValue(),
            'initial_expression': _replace_cns_with_names(param.getInitialExpression()),
            'expression': _replace_cns_with_names(param.getExpression()),
            'value': param.getValue(),
            'rate': param.getRate(),
            'key': param.getKey(),
            'sbml_id': param.getSBMLId()
        }

        display_name = param.getObjectDisplayName()

        if 'name' in kwargs and (kwargs['name'] not in param_data['name'] and kwargs['name'] != display_name):
            continue

        if name and (name not in param_data['name'] and name != display_name):
            continue

        if 'type' in kwargs and kwargs['type'] not in param_data['type']:
            continue

        if 'sbml_id' in kwargs and kwargs['sbml_id'] != param_data['sbml_id']:
            continue

        data.append(param_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_functions(name=None, **kwargs):
    """Returns all available functions as pandas dataframe.

           :param name: optional filter expression for the functions, if it is not included in the name,
                        the function will not be added to the data set.
           :type name: str
           :param kwargs: optional arguments:

            * `reversible`: to further filter for functions that are only reversible

           :return: a pandas dataframe with the information about the functions
           :rtype: pandas.DataFrame
           """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    functions = root.getFunctionList().loadedFunctions()
    data = []
    for index in range(functions.size()):
        function = functions.get(index)
        assert (isinstance(function, COPASI.CFunction))

        fun_data = {
            'name': function.getObjectName(),
            'reversible': function.isReversible() == 1,
            'formula': function.getInfix(),
            'general': function.isReversible() == -1,
        }

        if 'name' in kwargs and kwargs['name'] not in fun_data['name']:
            continue

        if 'reversible' in kwargs and kwargs['reversible'] != fun_data['reversible']:
            continue

        if name and name not in fun_data['name']:
            continue

        data.append(fun_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_reaction_parameters(name=None, **kwargs):
    """Returns all local parameters as pandas dataframe.

       This also includes global parameters that are mapped to local ones.

       :param name: optional filter expression, if it is not included in the name,
                    the function will not be added to the data set.
       :type name: str
       :param kwargs: optional arguments:

        * | `reaction_name`: to further filter for local parameters of only certain reactions
          | (that contain the substring)

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

       :return: a pandas dataframe with the information about local parameters
       :rtype: pandas.DataFrame
       """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()

    num_reactions = reactions.size()
    data = []

    for i in range(num_reactions):
        reaction = reactions.get(i)

        if 'reaction_name' in kwargs and kwargs['reaction_name'] != reaction.getObjectName():
            continue

        parameter_group = reaction.getParameters()
        fun_params = reaction.getFunctionParameters()
        num_params = fun_params.size()
        param_objects = reaction.getParameterObjects()

        for j in range(num_params):
            fun_parameter = fun_params.getParameter(j)
            if fun_parameter.getUsage() != COPASI.CFunctionParameter.Role_PARAMETER:
                continue
            parameter = parameter_group.getParameter(fun_parameter.getObjectName())
            if parameter is None: 
                continue

            current_param = param_objects[j][0] if param_objects[j] else None
            cn = current_param.getCN() if current_param else None
            mv = dm.getObject(current_param.getCN()) if cn else None
            if mv and isinstance(mv, COPASI.CModelValue):
                param_type = 'global'
                mapped_to = mv.getObjectName()
                value = mv.getInitialValue()
            else:
                param_type = 'local'
                mapped_to = ''
                value = reaction.getParameterValue(parameter.getObjectName())

            param_data = {
                'name': parameter.getObjectDisplayName(),
                'value': value,
                'reaction': reaction.getObjectName(),
                'type': param_type,
                'mapped_to': mapped_to
            }

            if 'name' in kwargs and kwargs['name'] not in param_data['name']:
                continue

            if name and name not in param_data['name']:
                continue

            if 'type' in kwargs and kwargs['type'] not in param_data['type']:
                continue

            data.append(param_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_reactions(name=None, **kwargs):
    """Returns all reactions as pandas dataframe.

       :param name: optional filter expression, if it is not included in the name,
                    the reaction will not be added to the data set.
       :type name: str
       :param kwargs: optional arguments:

        * | `reaction_name`: to further filter for local parameters of only certain reactions
          | (that contain the substring)

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

       :return: a pandas dataframe with the information about local parameters
       :rtype: pandas.DataFrame
       """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()

    num_reactions = reactions.size()
    data = []

    for i in range(num_reactions):
        reaction = reactions.get(i)
        assert (isinstance(reaction, COPASI.CReaction))

        reaction_data = {
            'name': reaction.getObjectName(),
            'scheme': reaction.getReactionScheme(),
            'flux': reaction.getFlux(),
            'particle_flux': reaction.getParticleFlux(),
            'function': reaction.getFunction().getObjectName(),
            'key': reaction.getKey(),
            'sbml_id': reaction.getSBMLId()
        }

        if 'name' in kwargs and kwargs['name'] not in reaction_data['name']:
            continue

        if name and name not in reaction_data['name']:
            continue

        if 'sbml_id' in kwargs and kwargs['sbml_id']  != reaction_data['sbml_id']:
            continue

        data.append(reaction_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_time_unit(**kwargs):
    """Returns the time unit of the model"""
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    time = model.getTimeUnit()

    return time


def set_compartment(name=None, **kwargs):
    """Sets properties of the named compartment

    :param name: the name of the compartment (or a substring of the name)
    :type name: str

    :param kwargs: optional arguments

        - | `initial_value` or `initial_size`: to set the initial size of the compartment

        - | `initial_expression`: the initial expression for the compartment

        - | `status` or `type`: the type of the compartment one of `fixed`, `assignment` or `ode`

        - | `expression`: the expression for the compartment (only valid when type is `ode` or `assignment`)

        - | `dimensionality`: sets the dimensionality of the compartment (int value 1..3)

        - | `notes`: sets notes for the compartment (either plain text, or valid xhtml)

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()

    num_compartments = compartments.size()

    change_set = COPASI.ObjectStdVector()

    for i in range(num_compartments):
        compartment = compartments.get(i)
        assert (isinstance(compartment, COPASI.CCompartment))
        current_name = compartment.getObjectName()

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        if 'initial_value' in kwargs:
            compartment.setInitialValue(kwargs['initial_value'])
            change_set.append(compartment.getInitialValueReference())

        if 'initial_size' in kwargs:
            compartment.setInitialValue(kwargs['initial_size'])
            change_set.append(compartment.getInitialValueReference())

        if 'initial_expression' in kwargs:
            compartment.setInitialExpression(_replace_names_with_cns(kwargs['initial_expression']))
            model.setCompileFlag(True)

        if 'status' in kwargs:
            compartment.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            compartment.setStatus(__status_to_int(kwargs['type']))

        if 'expression' in kwargs:
            compartment.setExpression(_replace_names_with_cns(kwargs['expression']))
            model.setCompileFlag(True)

        if 'dimensionality' in kwargs:
            compartment.setDimensionality(kwargs['dimensionality'])

        if 'notes' in kwargs:
            compartment.setNotes(kwargs['notes'])

        if 'sbml_id' in kwargs:
            compartment.setSBMLId(kwargs['sbml_id'])

    model.updateInitialValues(change_set)
    model.compileIfNecessary()


def set_parameters(name=None, **kwargs):
    """Sets properties of the named parameter(s).

    :param name: the name of the parameter (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `unit`: the unit expression to be set
        - | `initial_value`: to set the initial value for the parameter
        - | `initial_expression`: the initial expression
        - | `status` or `type`: the type of the parameter one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the parameter (only valid when type is `ode` or `assignment`)
        - | `notes`: sets notes for the parameter (either plain text, or valid xhtml)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameters = model.getModelValues()
    assert (isinstance(parameters, COPASI.ModelValueVectorN))

    num_params = parameters.size()

    change_set = COPASI.ObjectStdVector()

    for i in range(num_params):
        param = parameters.get(i)
        assert (isinstance(param, COPASI.CModelValue))
        current_name = param.getObjectName()
        display_name = param.getObjectDisplayName()

        if 'name' in kwargs and (kwargs['name'] not in current_name and kwargs['name'] != display_name):
            continue

        if name and type(name) is str and (name not in current_name and name != display_name):
            continue

        if name and isinstance(name, Iterable) and (current_name not in name and display_name not in name):
            continue

        if 'unit' in kwargs:
            param.setUnitExpression(kwargs['unit'])

        if 'initial_value' in kwargs:
            param.setInitialValue(kwargs['initial_value'])
            change_set.append(param.getInitialValueReference())

        if 'initial_expression' in kwargs:
            param.setInitialExpression(_replace_names_with_cns(kwargs['initial_expression']))
            model.setCompileFlag(True)

        if 'status' in kwargs:
            param.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            param.setStatus(__status_to_int(kwargs['type']))

        if 'expression' in kwargs:
            param.setExpression(_replace_names_with_cns(kwargs['expression']))
            model.setCompileFlag(True)

        if 'notes' in kwargs:
            param.setNotes(kwargs['notes'])

        if 'sbml_id' in kwargs:
            param.setSBMLId(kwargs['sbml_id'])

    model.updateInitialValues(change_set)
    model.compileIfNecessary()


def set_reaction_parameters(name=None, **kwargs):
    """Sets local parameter values.

    :param name: the name of the parameter (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `reaction_name`: if specified only parameters of the named reaction will be changed
        - | `value`: the new value of the parameter to set.
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()
    num_reactions = reactions.size()

    for i in range(num_reactions):
        reaction = reactions.get(i)

        if 'reaction_name' in kwargs and kwargs['reaction_name'] != reaction.getObjectName():
            continue

        changed = False

        parameter_group = reaction.getParameters()
        fun_params = reaction.getFunctionParameters()
        num_params = fun_params.size()
        param_objects = reaction.getParameterObjects()

        for j in range(num_params):
            fun_parameter = fun_params.getParameter(j)
            if fun_parameter.getUsage() != COPASI.CFunctionParameter.Role_PARAMETER:
                continue
            param = parameter_group.getParameter(fun_parameter.getObjectName())
            if param is None: 
                continue
            current_param = param_objects[j][0] if param_objects[j] else None
            cn = current_param.getCN() if current_param else None
            mv = dm.getObject(current_param.getCN()) if cn else None

            current_name = param.getObjectDisplayName()

            if 'name' in kwargs and kwargs['name'] not in current_name:
                continue

            if name and type(name) is str and name not in current_name:
                continue

            if name and isinstance(name, Iterable) and current_name not in name:
                continue

            if 'value' in kwargs:
                if mv and isinstance(mv, COPASI.CModelValue):
                    mv.setInitialValue(kwargs['value'])
                    model.updateInitialValues(mv)
                else:
                    param.setDblValue(kwargs['value'])
                    model.updateInitialValues(param)
                changed = True

        if changed:
            reaction.compile()
            model.setCompileFlag(True)


def set_reaction(name=None, **kwargs):
    """Sets attributes of the named reaction.

    :param name: the name of the reaction (or a substring of the name)
    :type name: str

    :param kwargs: optional arguments

        - | `new_name`: new name of the reaction

        - | `scheme`: the reaction scheme, new species will be created automatically

        - | `function`: the function from the function database to set
        
        - | `mapping`: an optional dictionary that maps model elements to the function
          |            parameters. (can be any volume, species, modelvalue or in case of 
          |            local parameters a value)

        - | `notes`: sets notes for the reaction (either plain text, or valid xhtml)

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """

    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()
    num_reactions = reactions.size()

    changed = False

    for i in range(num_reactions):
        reaction = reactions.get(i)
        assert(isinstance(reaction, COPASI.CReaction))

        current_name = reaction.getObjectName()

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        if 'new_name' in kwargs:
            reaction.setObjectName(kwargs['new_name'])

        if 'scheme' in kwargs:
            reaction.setReactionScheme(kwargs['scheme'])
            reaction.compile()
            changed = True

        if 'function' in kwargs:
            info = COPASI.CReactionInterface()
            info.init(reaction)
            info.setFunctionAndDoMapping(kwargs['function'])
            info.writeBackToReaction(reaction)
            reaction.compile()
            changed = True

        if 'mapping' in kwargs:
            mapping = kwargs['mapping']
            info = COPASI.CReactionInterface()
            info.init(reaction)
            for j in range(info.size()):
                p_type = info.getUsage(j)
                p_name = info.getParameterName(j)
                if p_name in mapping:
                    mapped_to = mapping[p_name]
                    if p_type == COPASI.CFunctionParameter.Role_PARAMETER:
                        try:
                            value = float(mapped_to)
                            info.setLocalValue(j, value)
                        except ValueError:
                            obj = model.getModelValue(mapped_to)
                            if obj is None:
                                obj = dm.findObjectByDisplayName(mapped_to)
                                if obj is not None and type(obj) != COPASI.CModelValue:
                                    logging.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                                    continue
                            if obj is None:
                                logging.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                                continue

                            info.setMapping(j, obj.getObjectName())

                    elif p_type == COPASI.CFunctionParameter.Role_SUBSTRATE or \
                         p_type == COPASI.CFunctionParameter.Role_PRODUCT or \
                         p_type == COPASI.CFunctionParameter.Role_MODIFIER:
                        obj = model.getMetabolite(mapped_to)
                        if obj is None:
                            obj = dm.findObjectByDisplayName(mapped_to)
                            if obj is not None and type(obj) != COPASI.CMetab:
                                logging.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                                continue
                        if obj is None:
                            logging.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                            continue

                        info.setMapping(j, obj.getObjectName())
                        pass
                    elif p_type == COPASI.CFunctionParameter.Role_VOLUME:
                        obj = model.getCompartment(mapped_to)
                        if obj is None:
                            obj = dm.findObjectByDisplayName(mapped_to)
                            if obj is not None and type(obj) != COPASI.CCompartment:
                                logging.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                                continue
                        if obj is None:
                            logging.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                            continue

                        info.setMapping(j, obj.getObjectName())
                        pass
            info.writeBackToReaction(reaction)
            reaction.compile()
            changed = True

        if 'notes' in kwargs:
            reaction.setNotes(kwargs['notes'])

        if 'sbml_id' in kwargs:
            reaction.setSBMLId(kwargs['sbml_id'])

    if changed:
        model.forceCompile()


def remove_species(name, **kwargs):
    """Deletes the named species

    :param name: the name of a species in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    metab = model.getMetabolite(name)
    if metab is None:
        logging.warning('no such metabolite {0}'.format(name))
        return

    key = metab.getKey()
    metab = None
    model.compileIfNecessary()
    model.removeMetabolite(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_parameter(name, **kwargs):
    """Deletes the named global parameter

    :param name: the name of a parameter in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    mv = model.getModelValue(name)
    if mv is None:
        logging.warning('no such global parameter {0}'.format(name))
        return

    key = mv.getKey()
    mv = None
    model.compileIfNecessary()
    model.removeModelValue(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_compartment(name, **kwargs):
    """Deletes the named compartment (and everything included)

    :param name: the name of a compartment in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    comp = model.getCompartment(name)
    if comp is None:
        logging.warning('no such compartment {0}'.format(name))
        return

    key = comp.getKey()
    comp = None
    model.compileIfNecessary()
    model.removeCompartment(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_event(name, **kwargs):
    """Deletes the named event

    :param name: the name of an event in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    ev = model.getEvent(name)
    if ev is None:
        logging.warning('no such event {0}'.format(name))
        return
    key = ev.getKey()
    ev = None
    model.compileIfNecessary()
    model.removeEvent(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_plot(name, **kwargs):
    """Deletes the named plot

    :param name: the name of an plot in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    output_list = dm.getPlotDefinitionList()
    assert (isinstance(output_list, COPASI.COutputDefinitionVector))

    for i in range(output_list.size()):
        plot = output_list.get(i)
        if plot.getObjectName() != name:
            continue

        output_list.remove(i)
        return

    logging.warning('no such plot {0}'.format(name))


def remove_reaction(name, **kwargs):
    """Deletes the named reaction

    :param name: the name of a reaction in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reaction = model.getReaction(name)
    if reaction is None:
        logging.warning('no such reaction {0}'.format(name))
        return

    key = reaction.getKey()
    reaction = None
    model.compileIfNecessary()
    model.removeReaction(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def set_species(name=None, **kwargs):
    """Sets properties of the named species

    :param name: the name of the species (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `new_name`: the new name for the species
        - | `initial_concentration`: to set the initial concentration for the species
        - | `initial_particle_number`: to set the initial particle number for the species
        - | `initial_expression`: the initial expression for the species
        - | `status` or `type`: the type of the species one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the species (only valid when type is `ode` or `assignment`)
        - | `notes`: sets notes for the species (either plain text, or valid xhtml)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    metabs = model.getMetabolitesX()
    num_metabs = metabs.size()

    change_set = COPASI.ObjectStdVector()

    for i in range(num_metabs):
        metab = metabs.get(i)
        assert (isinstance(metab, COPASI.CMetab))

        current_name = metab.getObjectName()
        display_name = metab.getObjectDisplayName()

        if 'name' in kwargs and kwargs['name'] not in current_name and kwargs['name'] not in display_name:
            continue

        if name and type(name) is str and name not in current_name and name not in display_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name and display_name not in name:
            continue

        if 'new_name' in kwargs:
            metab.setObjectName(kwargs['new_name'])

        if 'unit' in kwargs:
            metab.setUnitExpression(kwargs['unit'])

        if 'initial_concentration' in kwargs:
            metab.setInitialConcentration(kwargs['initial_concentration'])
            change_set.append(metab.getInitialConcentrationReference())

        if 'initial_particle_number' in kwargs:
            metab.setInitialValue(kwargs['initial_particle_number']),
            change_set.append(metab.getInitialValueReference())

        if 'initial_expression' in kwargs:
            metab.setInitialExpression(_replace_names_with_cns(kwargs['initial_expression']))
            model.setCompileFlag(True)

        if 'status' in kwargs:
            metab.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            metab.setStatus(__status_to_int(kwargs['type']))

        if 'expression' in kwargs:
            metab.setExpression(_replace_names_with_cns(kwargs['expression']))
            model.setCompileFlag(True)

        if 'notes' in kwargs:
            metab.setNotes(kwargs['notes'])

        if 'sbml_id' in kwargs:
            metab.setSBMLId(kwargs['sbml_id'])

    model.updateInitialValues(change_set)
    model.compileIfNecessary()


def set_time_unit(unit, **kwargs):
    """Sets the time unit of the model.

    :param unit: the time unit expression
    :type unit: str
    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'unit' in kwargs:
        model.setTimeUnit(kwargs['unit'])


def get_model_units(**kwargs):
    """Returns all model units as dictionary.

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: a dictionary containing the model units in the form:
        | {
        |    'time_unit': '',
        |    'quantity_unit': '',
        |    'length_unit': '',
        |    'area_unit': '',
        |    'volume_unit': '',
        | }
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    return {
        'time_unit': model.getTimeUnit(),
        'quantity_unit': model.getQuantityUnit(),
        'length_unit': model.getLengthUnit(),
        'area_unit': model.getAreaUnit(),
        'volume_unit': model.getVolumeUnit(),
    }


def set_element_name(element, new_name, **kwargs):
    """Sets the name of the element

    :param element: the element whose name to change
    :type element: COPASI.CDataObject or str

    :param new_name: the new name for the element
    :type new_name: str

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    if type(element) is COPASI.CDataObject:
        if not element.setObjectName(new_name):
            logging.warning("couldn't change name of the element")
        return
    if type(element) is str:
        obj = dm.findObjectByDisplayName(element)
        if obj is not None:
            if not element.setObjectName(new_name):
                logging.warning("couldn't change name of the element")
            return

    logging.warning("couldn't change name of the element (could not find the object)")


def set_model_unit(**kwargs):
    """Sets the model units.

    :param kwargs: optional parameters

        - | `time_unit`: time unit expression

        - | `substance_unit` or `quantity_unit`: substance unit expression

        - | `length_unit`: length unit expression

        - | `area_unit`: area unit expression

        - | `volume_unit`: volume unit expression

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """

    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'time_unit' in kwargs:
        model.setTimeUnit(kwargs['time_unit'])

    if 'substance_unit' in kwargs:
        model.setQuantityUnit(kwargs['substance_unit'])

    if 'quantity_unit' in kwargs:
        model.setQuantityUnit(kwargs['quantity_unit'])

    if 'length_unit' in kwargs:
        model.setLengthUnit(kwargs['length_unit'])

    if 'area_unit' in kwargs:
        model.setAreaUnit(kwargs['area_unit'])

    if 'volume_unit' in kwargs:
        model.setVolumeUnit(kwargs['volume_unit'])

    model.updateInitialValues(COPASI.CCore.Framework_Concentration)


def add_amount_expressions(**kwargs):
    """ Utility function that adds model values for all metabolites to the model to compute the amount

    The global parameters created will be named amount(metab_name), and so can be accessed at any time.
    Should the amount already exist, it will not be modified.

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    for metab in model.getMetabolites():
        assert (isinstance(metab, COPASI.CMetab))
        if metab.getCompartment() is None:
            logging.warning('Cannot create an amount expression for {0} as it has no compartment'.format(
                metab.getObjectDisplayName()))
            continue

        if 'ignore_fixed' in kwargs \
               and kwargs['ignore_fixed'] == True \
               and metab.getStatus() == COPASI.CModelEntity.Status_FIXED:
            continue

        if 'ignore_assignment' in kwargs \
                and kwargs['ignore_assignment'] == True\
                and metab.getStatus() == COPASI.CModelEntity.Status_ASSIGNMENT:
            continue

        mv_name = 'amount({0})'.format(metab.getObjectDisplayName())
        if 'use_sbml_ids' in kwargs:
            mv_name = 'amount({0})'.format(metab.getSBMLId())

        mv = model.getModelValue(mv_name)
        if mv is not None:
            continue
        add_parameter(mv_name,
                      status='assignment',
                      expression='<{0}> * <{1}>'.format(
                          metab.getConcentrationReference().getCN(),
                          metab.getCompartment().getValueReference().getCN()),
                      notes='Amount expression for {0}'.format(metab.getObjectDisplayName())
                      )


def remove_amount_expressions(**kwargs):
    """ Utility function that removes model values created using `add_amount_expressions`.

    The global parameters created will be named amount(metab_name), and so can be accessed at any time.

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    keys = []
    for mv in model.getModelValues():
        assert(isinstance(mv, COPASI.CModelValue))
        if mv.getNotes().startswith('Amount ex'):
            keys.append(mv.getKey())

    for key in keys:
        model.removeModelValue(key)
        model.compileIfNecessary()


def have_miriam_resources():
    """Utility function returning whether MIRIAM resources are avaialble

    :return: boolean indicating whether there are MIRIAM resources available or not
    :rtype: bool
    """
    try:
        miriam = COPASI.CRootContainer.getConfiguration().getRecentMIRIAMResources()
        assert (isinstance(miriam, COPASI.CMIRIAMResources))
        return miriam.getResourceList().size() > 0
    except AttributeError:
        return False


def get_miriam_resources():
    """Retrieves the current MIRIAM resources from the configuration

    :return: dataframe with the list of current miriam resources
    :rtype: pandas.DataFrame
    """
    resources = []
    try:
        miriam = COPASI.CRootContainer.getConfiguration().getRecentMIRIAMResources()
        assert (isinstance(miriam, COPASI.CMIRIAMResources))
        for i in range(miriam.getResourceList().size()):
            res = miriam.getMIRIAMResource(i)
            assert (isinstance(res, COPASI.CMIRIAMResource))
            resources.append({
                'resource': res.getMIRIAMDisplayName(),
                'is_citation': res.getMIRIAMCitation(),
                'uri': res.getIdentifiersOrgURL()
            })
    except AttributeError:
        logging.error("Couldn't retrieve list of miriam resources, please update the python-copasi version")

    df = pandas.DataFrame(data=resources)
    if resources:
        df = df.set_index('resource')
    return df


def update_miriam_resources():
    """This method downloads the latest miriam resources from the COPASI website and stores the configuration"""
    try:
        import biomodels
    except ImportError:
        from . import biomodels

    temp_name = tempfile.mktemp()

    with open(temp_name, mode='w', encoding='utf-8') as temp_file:
        if sys.version_info[0] < 3:
            temp_file.write(biomodels.download_from(MIRIAM_XML).decode('utf-8'))
        else:
            temp_file.write(biomodels.download_from(MIRIAM_XML))
        temp_file.close()
    config = COPASI.CRootContainer.getConfiguration()
    miriam = config.getRecentMIRIAMResources()
    assert (isinstance(miriam, COPASI.CMIRIAMResources))
    miriam.updateMIRIAMResourcesFromFile(None, temp_name)
    config.save()


def _is_number(x):
    try:
        float(x)
        return True
    except:
        return False

def _tokenize_eqn(eqn):
    """ Utility function for tokenizing equations into variables and functions

    :param eqn: an equation
    :type eqn: str
    :return: a dictionary of the tokens
    :rtype: dict
    """
    result = {}
    num_chars = len(eqn)
    i = 0

    species = []
    parameters = []
    tokens = []

    operators = ['/', '*', '+', '-', '^', '(', ')']
    functions = ['exp', 'pow', 'abs', 'floor', 'factorial',
                 'log', 'log10', 'sin', 'cos', 'tan', 'sec',
                 'csc', 'cot', 'sinh', 'cosh', 'tanh', 'sech'
                 'csch', 'coth', 'asin', 'acos', 'atan', 'arcsec',
                 'arccsc', 'arccot', 'arcsinh', 'arccosh',
                 'arctanh', 'arcsech', 'arccsch', 'arccoth',
                 'uniform', 'normal', 'gamma', 'poisson',
                 'le', 'lt', 'ge', 'gt', 'ne', 'eq', 'and',
                 'or', 'xor', 'not', 'if']

    chunk = ''
    var = None
    var_is_species = False
    var_is_initial = False
    is_ode = False

    while i < num_chars:
        c_0 = eqn[i]
        c_1 = eqn[i + 1] if i + 1 < num_chars else None
        c_2 = eqn[i + 2] if i + 2 < num_chars else None

        if ord(c_0) > 127:  # skip non-ascii characters
            logging.warning(u'Encountered invalid character {0} while tokenizing equation, skipping it.'.format(c_0))
            i = i + 1
            continue

        if c_0 == '[' and c_1 is not None:
            var, var_is_initial, var_is_species = _store_variable(parameters, species, tokens, var, var_is_initial,
                                                                  var_is_species)
            pos = eqn.find(']', i+1)
            if pos != -1:
                var = eqn[i + 1:pos]
                var_is_species = True
                i = pos + 1
                c_0 = eqn[i]
                c_1 = eqn[i + 1] if i + 1 < num_chars else None

                if c_0 == '_' and c_1 == '0':
                    var_is_initial = True
                    i = i + 2

                continue

        elif c_0 == '/' and c_1 == 'd' and c_2 == 't':
            is_ode = True
            i += 3

            if chunk.startswith('d'):
                chunk = chunk[1:]
                continue

            continue

        elif c_0 == '=':

            if var is None:
                var = chunk

            token = {
                'var': var,
                'is_species': var_is_species,
                'is_initial': var_is_initial
            }
            #tokens.append(token)
            #tokens.append('=')
            result['lhs'] = token
            if var_is_species and var not in species:
                species.append(var)
            elif not var_is_species and var not in parameters:
                parameters.append(var)
            var = None
            var_is_species = False
            var_is_initial = False
            chunk = ''
            result['is_ode'] = is_ode
            i = i+1
            continue

        elif c_0 == ' ':
            var, var_is_initial, var_is_species = _store_variable(parameters, species, tokens, var, var_is_initial,
                                                                  var_is_species)

            if chunk != '':
                if chunk in functions or _is_number(chunk):
                    if tokens and type(tokens[-1]) is dict:
                        tokens.append('*')
                    tokens.append(chunk)
                else:
                    token = {
                        'var': chunk,
                        'is_species': False,
                        'is_initial': False
                    }
                    if chunk not in parameters:
                        parameters.append(chunk)
                    if tokens and type(tokens[-1]) is dict:
                        tokens.append('*')
                    tokens.append(token)

            chunk = ''
        elif c_0 in operators:
            var, var_is_initial, var_is_species = _store_variable(parameters, species, tokens, var, var_is_initial,
                                                                  var_is_species)

            if chunk != '':
                if chunk in functions or _is_number(chunk):
                    if tokens and type(tokens[-1]) is dict:
                        tokens.append('*')
                    tokens.append(chunk)
                else:
                    token = {
                        'var': chunk,
                        'is_species': False,
                        'is_initial': False
                    }
                    if chunk not in parameters:
                        parameters.append(chunk)
                    if tokens and type(tokens[-1]) is dict:
                        tokens.append('*')
                    tokens.append(token)

            chunk = ''

            if c_0 == '(' and tokens and (tokens[-1] == ')' or type(tokens[-1]) is dict):
                tokens.append('*')

            tokens.append(c_0)
        else:
            chunk = chunk + c_0

        i += 1

    if chunk != '':
        if chunk in functions  or _is_number(chunk):
            if tokens and type(tokens[-1]) is dict:
                tokens.append('*')
            tokens.append(chunk)
        else:
            token = {
                'var': chunk,
                'is_species': False,
                'is_initial': False
            }
            if chunk not in parameters:
                parameters.append(chunk)
            if tokens and type(tokens[-1]) is dict:
                tokens.append('*')
            tokens.append(token)

    if var is not None:
        token = {
            'var': var,
            'is_species': var_is_species,
            'is_ode': is_ode,
            'is_initial': var_is_initial
        }
        if var_is_species and var not in species:
            species.append(var)
        elif not var_is_species and var not in parameters:
            parameters.append(var)

        if tokens and type(tokens[-1]) is dict:
            tokens.append('*')
        tokens.append(token)

    result['tokens'] = tokens
    result['species'] = species
    result['parameters'] = parameters

    return result


def _store_variable(parameters, species, tokens, var, var_is_initial, var_is_species):
    if var is not None:
        token = {
            'var': var,
            'is_species': var_is_species,
            'is_initial': var_is_initial
        }
        if var_is_species and var not in species:
            species.append(var)
        elif not var_is_species and var not in parameters:
            parameters.append(var)
        if tokens and type(tokens[-1]) is dict:
            tokens.append('*')
        tokens.append(token)
        var = None
        var_is_species = False
        var_is_initial = False
    return var, var_is_initial, var_is_species


def add_equation(eqn, time_symbol='t', **kwargs):
    """This function allows to add arbitrary equations to the current model.

    This function allows adding arbitrary ODE's / assignments to the model. Nonexisting
    model entities will be created.

    :param eqn: the equation for example of form: d[X]/dt = k1 * exp({Time})
    :type eqn: str

    :param time_symbol: optional symbol that will be used for time (defaults to t)
    :type time_symbol: str

    :param kwargs:
    :return:
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    result = _tokenize_eqn(eqn)

    # first create all non-existing species / parameters
    for species in result['species']:
        if model.getMetabolite(species) is None:
            add_species(species)

    for parameter in result['parameters']:
        if parameter == time_symbol:
            continue
        if model.getModelValue(parameter) is None:
            add_parameter(parameter)

    # now create the equation from the tokens
    expression = ''
    for token in result['tokens']:
        if type(token) is dict:
            if token['is_species']:
                element = model.getMetabolite(token['var'])
                assert (isinstance(element, COPASI.CMetab))
                obj = element.getInitialConcentrationReference().getCN() if token[
                    'is_initial'] else element.getConcentrationReference().getCN()
            elif token['var'] == time_symbol:
                obj = model.getValueReference().getCN()
            else:
                element = model.getModelValue(token['var'])
                assert (isinstance(element, COPASI.CModelValue))
                obj = element.getInitialValueReference().getCN() if token[
                    'is_initial'] else element.getValueReference().getCN()
            expression = expression + "<" + obj.getString() + ">"
        else:
            expression = expression + token

    # then lets add the equation
    if 'lhs' in result:
        lhs = result['lhs']
        if lhs['is_species']:
            element = model.getMetabolite(lhs['var'])
        else:
            element = model.getModelValue(lhs['var'])

        assert (isinstance(element, COPASI.CModelEntity))
        element.setStatus(COPASI.CModelEntity.Status_ODE if result['is_ode'] else COPASI.CModelEntity.Status_ASSIGNMENT)
        issue = element.setExpression(expression)
        assert (isinstance(issue, COPASI.CIssue))
        assert (issue.isSuccess())

    # mark the model as needing to be compiled
    model.setCompileFlag(True)


def _annotated_matrix_to_df(ann_matrix):
    """Converts the annotated matrix to a pandas dataframe

    :param ann_matrix: the matrix to convert
    :type ann_matrix: COPASI.CDataArray
    :return: a pandas dataframe representing the matrix
    :rtype: pd.DataFrame
    """
    assert(isinstance(ann_matrix, COPASI.CDataArray))
    if ann_matrix.dimensionality() != 2:
        logging.error('only two dimensional matrices are supported at this time')
        return None

    matrix = ann_matrix.getArray()
    columns = [s for s in ann_matrix.getAnnotationsString(1)]
    index = [s for s in ann_matrix.getAnnotationsString(0)]
    data = []
    for x in range(len(index)):
        row = {}
        for y in range(len(columns)):
            row[columns[y]] = matrix.get(x, y)
        data.append(row)
    return pd.DataFrame(data, columns=columns, index=index)


def get_stoichiometry_matrix(**kwargs):
    """Returns the stoichiometry matrix of the model

    :return: the stoichiometry matrix of the current model
    :rtype: pd.DataFrame

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))
    return _annotated_matrix_to_df(model.getStoiAnnotation())


def get_reduced_stoichiometry_matrix(**kwargs):
    """Returns the reduced stoichiometry matrix of the model

    :return: the stoichiometry matrix of the current model
    :rtype: pd.DataFrame

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))
    return _annotated_matrix_to_df(model.getRedStoiAnnotation())


def get_jacobian_matrix(apply_initial_values=False, **kwargs):
    """Returns the jacobian matrix of the model at the current state

    :param apply_initial_values: if set to the the initial values will be applied, otherwise
         the jacobian from the current state will be returned
    :type apply_initial_values: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the stoichiometry matrix of the current model
    :rtype: pd.DataFrame

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if apply_initial_values:
        model.applyInitialValues()

    jacobian = COPASI.FloatMatrix()
    model.getMathContainer().calculateJacobian(jacobian, 1e-12, False)
    state_template = model.getStateTemplate()
    user_order = state_template.getUserOrder()
    name_vector = []

    for i in range(0, user_order.size()):
        entity = state_template.getEntity(user_order.get(i))
        if entity is None:
            continue
        status = entity.getStatus()

        if status == COPASI.CModelEntity.Status_ODE or (status == COPASI.CModelEntity.Status_REACTIONS and entity.isUsed()):
            name_vector.append(entity.getObjectName())

    assert len(name_vector) == jacobian.numRows()

    data = []

    for i in range(0, len(name_vector)):
        row = {}
        for j in range(0, len(name_vector)):
            row[name_vector[j]] = jacobian.get(i, j)
        data.append(row)

    return pd.DataFrame(data, columns=name_vector, index=name_vector)


def get_reduced_jacobian_matrix(apply_initial_values=False, **kwargs):
    """Returns the jacobian matrix of the reduced model at the current state

        :param apply_initial_values: if set to the the initial values will be applied, otherwise
             the jacobian from the current state will be returned
        :type apply_initial_values: bool

        :param kwargs: optional parameters

            - | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: the stoichiometry matrix of the reduced current model
        :rtype: pd.DataFrame

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if apply_initial_values:
        model.applyInitialValues()

    jacobian = COPASI.FloatMatrix()
    model.getMathContainer().calculateJacobian(jacobian, 1e-12, True)
    state_template = model.getStateTemplate()
    name_vector = []
    data = []

    iMax = state_template.getNumIndependent()

    for i in range(0, iMax):
        name_vector.append(state_template.getIndependent(i).getObjectName())

    for i in range(0, iMax):
        row = {}
        for j in range(0, iMax):
            row[name_vector[j]] = jacobian.get(i, j)
        data.append(row)

    return pd.DataFrame(data, columns=name_vector, index=name_vector)

def _get_group_as_dict(group, basic_only=True):
    """Returns the values from the given parameter group as dictionary

    :param group: the copasi parameter group
    :type group: COPASI.CCopasiParameterGroup

    :param basic_only: boolean indicating, whether only basic parameters should be returned (default)
    :type basic_only: bool

    :return: dictionary with the values
    """
    result = {}
    for i in range(group.size()):
        param = group.getParameter(i)
        assert (isinstance(param, COPASI.CCopasiParameter))

        if isinstance(param, COPASI.CCopasiParameterGroup):
            continue

        if not param.isEditable():
            continue

        if not param.isBasic() and basic_only:
            continue

        name = param.getObjectName()
        param_type = param.getType()

        if param_type == COPASI.CCopasiParameter.Type_STRING:
            result[name] = param.getStringValue()
        elif param_type == COPASI.CCopasiParameter.Type_INT:
            result[name] = param.getIntValue()
        elif param_type == COPASI.CCopasiParameter.Type_UINT:
            result[name] = param.getUIntValue()
        elif param_type == COPASI.CCopasiParameter.Type_DOUBLE:
            result[name] = param.getDblValue()
        elif param_type == COPASI.CCopasiParameter.Type_UDOUBLE:
            result[name] = param.getUDblValue()
        elif param_type == COPASI.CCopasiParameter.Type_BOOL:
            result[name] = param.getBoolValue()

    return result


def _set_group_from_dict(group, values):
    """Changes settings in the given parameter group to the values specified in the values dictionary

    :param group: the copasi parameter group to update
    :type group: COPASI.CCopasiParameterGroup
    :param values: dictionary with new values
    :type values: dict
    :return:
    """
    for key in values:
        param = group.getParameter(key)
        if param is None:
            continue

        if isinstance(param, COPASI.CCopasiParameterGroup):
            continue

        assert (isinstance(param, COPASI.CCopasiParameter))
        param_type = param.getType()

        if param_type == COPASI.CCopasiParameter.Type_STRING:
            param.setStringValue(str(values[key]))
        elif param_type == COPASI.CCopasiParameter.Type_INT:
            param.setIntValue(int(values[key]))
        elif param_type == COPASI.CCopasiParameter.Type_UINT:
            param.setUIntValue(int(values[key]))
        elif param_type == COPASI.CCopasiParameter.Type_DOUBLE:
            param.setDblValue(float(values[key]))
        elif param_type == COPASI.CCopasiParameter.Type_UDOUBLE:
            param.setUDblValue(float(values[key]))
        elif param_type == COPASI.CCopasiParameter.Type_BOOL:
            param.setBoolValue(bool(values[key]))


def get_task_settings(task, basic_only=True, **kwargs):
    """Returns the settings of the given task

    :param task: the task to read the settings of
    :type task: COPASI.CCopasiTask or str

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: dict of task settings
    :rtype: {}

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    if not isinstance(task, COPASI.CCopasiTask):
        name = task
        task = dm.getTask(name)

    if not isinstance(task, COPASI.CCopasiTask):
        logging.error('no such task')
        return {}

    result = {
        'is_scheduled': task.isScheduled(),
        'is_update_model': task.isUpdateModel(),
    }

    problem = task.getProblem()
    result['problem'] = _get_group_as_dict(problem, basic_only)

    method = task.getMethod()
    result['method'] = _get_group_as_dict(method, basic_only)
    result['method']['name'] = method.getObjectName()

    return result


def set_task_settings(task, settings, **kwargs):
    """Applies the task settings present in the settings object

    :param task: the task to set
    :type task: COPASI.CCopasiTask or str
    :param settings: dictionary in the same format as the ones obtained from :func:`.get_task_settings`
    :type settings: dict

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    if not isinstance(task, COPASI.CCopasiTask):
        name = task
        task = dm.getTask(name)

    if not isinstance(task, COPASI.CCopasiTask):
        logging.error('no such task')
        return

    if 'is_scheduled' in settings:
        task.setScheduled(settings['is_scheduled'])

    if 'is_update_model' in settings:
        task.setUpdateModel(settings['is_update_model'])

    if 'problem' in settings:
        problem = task.getProblem()
        _set_group_from_dict(problem, settings['problem'])

    if 'method' in settings:
        method = task.getMethod()
        m_dict = settings['method']
        if 'name' in m_dict:
            name = m_dict['name']
            if name != method.getObjectName():
                task.setMethodType(COPASI.CCopasiMethod_TypeNameToEnum(name))
                method = task.getMethod()

        _set_group_from_dict(method, m_dict)
