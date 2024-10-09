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

import basico
import pandas as pd

try:
    from . import model_io
except ImportError:
    import model_io

import pandas
import COPASI
import logging
import dateutil.parser
import datetime
import sys
import re

from matplotlib import pyplot as plt

logger = logging.getLogger(__name__)

MIRIAM_XML = 'http://copasi.org/static/miriam.xml' # noqa

_copasi_build = COPASI.CVersion.VERSION.getVersionDevel()

try:
    from collections.abc import Iterable  # noqa
except ImportError:
    from collections import Iterable  # noqa

if sys.version_info[0] < 3:
    from io import open


class T:
    """Constants for Task names

    Convert between task names to enums

        >>> T.from_enum(0)
        Steady-State

        >>> T.to_enum('Steady-State')
        0

    """

    STEADY_STATE = "Steady-State"
    TIME_COURSE = "Time-Course"
    SCAN = "Scan"
    EFM = "Elementary Flux Modes"
    OPTIMIZATION = "Optimization"
    PARAMETER_ESTIMATION = "Parameter Estimation"
    MCA = "Metabolic Control Analysis"
    LYAPUNOV_EXPONENTS = "Lyapunov Exponents"
    TIME_SCALE_SEPARATION = "Time Scale Separation Analysis"
    SENSITIVITIES = "Sensitivities"
    MOIETIES = "Moieties"
    CROSS_SECTION = "Cross Section"
    LNA = "Linear Noise Approximation"
    TIME_COURSE_SENSITIVITIES = "Time-Course Sensitivities"

    _names = None
    _values = None

    @classmethod
    def _create_name_map(cls):
        return {
            COPASI.CTaskEnum.Task_steadyState: T.STEADY_STATE,
            COPASI.CTaskEnum.Task_timeCourse: T.TIME_COURSE,
            COPASI.CTaskEnum.Task_scan: T.SCAN,
            COPASI.CTaskEnum.Task_fluxMode: T.EFM,
            COPASI.CTaskEnum.Task_optimization: T.OPTIMIZATION,
            COPASI.CTaskEnum.Task_parameterFitting: T.PARAMETER_ESTIMATION,
            COPASI.CTaskEnum.Task_mca: T.MCA,
            COPASI.CTaskEnum.Task_lyap: T.LYAPUNOV_EXPONENTS,
            COPASI.CTaskEnum.Task_tssAnalysis: T.TIME_SCALE_SEPARATION,
            COPASI.CTaskEnum.Task_sens: T.SENSITIVITIES,
            COPASI.CTaskEnum.Task_moieties: T.MOIETIES,
            COPASI.CTaskEnum.Task_crosssection: T.CROSS_SECTION,
            COPASI.CTaskEnum.Task_lna: T.LNA,
            COPASI.CTaskEnum.Task_timeSens: T.TIME_COURSE_SENSITIVITIES,
        }

    @classmethod
    def _create_value_map(cls):
        return {
            T.STEADY_STATE: COPASI.CTaskEnum.Task_steadyState,
            T.TIME_COURSE: COPASI.CTaskEnum.Task_timeCourse,
            T.SCAN: COPASI.CTaskEnum.Task_scan,
            T.EFM: COPASI.CTaskEnum.Task_fluxMode,
            T.OPTIMIZATION: COPASI.CTaskEnum.Task_optimization,
            T.PARAMETER_ESTIMATION: COPASI.CTaskEnum.Task_parameterFitting,
            T.MCA: COPASI.CTaskEnum.Task_mca,
            T.LYAPUNOV_EXPONENTS: COPASI.CTaskEnum.Task_lyap,
            T.TIME_SCALE_SEPARATION: COPASI.CTaskEnum.Task_tssAnalysis,
            T.SENSITIVITIES: COPASI.CTaskEnum.Task_sens,
            T.MOIETIES: COPASI.CTaskEnum.Task_moieties,
            T.CROSS_SECTION: COPASI.CTaskEnum.Task_crosssection,
            T.LNA: COPASI.CTaskEnum.Task_lna,
            T.TIME_COURSE_SENSITIVITIES: COPASI.CTaskEnum.Task_timeSens,
        }

    @classmethod
    def from_enum(cls, int_value):
        if cls._names is None:
            cls._names = cls._create_name_map()

        return cls._names.get(int_value, T.STEADY_STATE)

    @classmethod
    def to_enum(cls, value):
        if cls._values is None:
            cls._values = cls._create_value_map()

        return cls._values.get(value, 0)

    @classmethod
    def all_task_names(cls):
        if cls._names is None:
            cls._names = cls._create_name_map()

        return list(cls._names.values())


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


def __xml_task_type_to_string(type_value):
    return T.from_enum(type_value)


def __task_name_to_xml_type(name):
    return T.to_enum(name)


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
    return types.get(usage.lower(), 3)


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


def get_species(name=None, exact=False, **kwargs):
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

    :param exact: if true, the name has to match precisely the name of the species
    :type exact: bool

    :param kwargs: optional arguments to further filter down the species. recognized are:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

     * `compartment`: to filter down only species in specific compartments

     * `type`: to filter for species of specific simulation type

    :return: a pandas dataframe with the information about the species
    :rtype: pandas.DataFrame
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    model.compileIfNecessary()

    metabs = model.getMetabolites()
    assert (isinstance(metabs, COPASI.MetabVector))

    num_metabs = metabs.size()
    data = []

    for i in range(num_metabs):
        metab = metabs.get(i)
        assert (isinstance(metab, COPASI.CMetab))

        unit = metab.getUnitExpression()
        if not unit:
            unit = model.getQuantityUnit() + '/' + model.getVolumeUnit()

        current_name = metab.getObjectName()
        display_name = metab.getObjectDisplayName()
        if 'name' in kwargs and not kwargs['name'] in current_name:
            continue

        if name and type(name) is str and exact and name != current_name and name != display_name:
            continue

        if name and type(name) is str and name not in current_name and name not in display_name:
            continue

        if name and isinstance(name, Iterable) and name not in current_name and display_name not in name:
            continue

        current_compartment = metab.getCompartment().getObjectName()

        if 'compartment' in kwargs and not kwargs['compartment'] in current_compartment:
            continue

        current_type = __status_to_string(metab.getStatus())
        if 'type' in kwargs and kwargs['type'] not in current_type:
            continue

        sbml_id = metab.getSBMLId()
        if 'sbml_id' in kwargs and kwargs['sbml_id'] != sbml_id:
            continue

        metab_data = {
            'name': current_name,
            'compartment': current_compartment,
            'type': current_type,
            'unit': unit,
            'initial_concentration': metab.getInitialConcentration(),
            'initial_particle_number': metab.getInitialValue(),
            'initial_expression': _replace_cns_with_names(metab.getInitialExpression(), model=dm),
            'expression': _replace_cns_with_names(metab.getExpression(), model=dm),
            'concentration': metab.getConcentration(),
            'particle_number': metab.getValue(),
            'rate': metab.getConcentrationRate(),
            'particle_number_rate': metab.getRate(),
            'key': metab.getKey(),
            'sbml_id': sbml_id,
            'transition_time': metab.getTransitionTime(),
            'display_name': metab.getObjectDisplayName(),
        }

        data.append(metab_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_events(name=None, exact=False, **kwargs):
    """Returns all information about the events as pandas dataframe.

    :param name: optional filter expression for the event, if it is not included in the event name,
                 the event will not be added to the data set.
    :type name: str

    :param exact: boolean indicating whether the name has to be exact
    :type exact: bool

    :param kwargs: optional arguments:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

    :return: a pandas dataframe with the information about the event
    :rtype: pandas.DataFrame
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    events = model.getEvents()

    num_events = events.size()
    data = []

    for i in range(num_events):
        event = events.get(i)
        assert (isinstance(event, COPASI.CEvent))

        current_name = event.getObjectName()

        if name and exact and name != current_name:
            continue

        if 'name' in kwargs and not kwargs['name'] in current_name:
            continue

        if name and name not in current_name:
            continue

        sbml_id = event.getSBMLId()
        if 'sbml_id' in kwargs and kwargs['sbml_id'] != sbml_id:
            continue

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
            'name': current_name,
            'trigger': _replace_cns_with_names(event.getTriggerExpression(), model=dm),
            'delay': _replace_cns_with_names(event.getDelayExpression(), model=dm),
            'assignments': assignments,
            'priority': _replace_cns_with_names(event.getPriorityExpression(), model=dm),
            'fire_at_initial_time': event.getFireAtInitialTime(),
            'persistent': event.getPersistentTrigger(),
            'delay_calculation': event.getDelayAssignment(),
            'key': event.getKey(),
            'sbml_id': sbml_id
        }

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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    data = []

    for i in range(dm.getNumPlotSpecifications()):
        plot_spec = dm.getPlotSpecification(i)
        assert (isinstance(plot_spec, COPASI.CPlotSpecification))

        plot_data = get_plot_dict(plot_spec, model=dm)
        if plot_data is None:
            continue

        if 'name' in kwargs and not kwargs['name'] in plot_data['name']:
            continue

        if name and name not in plot_data['name']:
            continue

        data.append(plot_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_reports(name=None, ignore_automatic=False, task=None, **kwargs):
    """Returns the reports as dataframe

    :param name: optional filter by name
    :param ignore_automatic: if true, only manually created reports are returned
    :param task: optional task name, to the get the report for
    :param kwargs: optional arguments:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

    :return: a data frame with all the report information
    :rtype: pd.DataFrame
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    data = []

    for i in range(dm.getNumReportDefinitions()):
        report = dm.getReportDefinition(i)
        assert (isinstance(report, COPASI.CReportDefinition))

        report_data = get_report_dict(report, model=dm)
        if not report_data:
            continue

        if 'name' in kwargs and not kwargs['name'] in report_data['name']:
            continue

        if ignore_automatic and 'comment' in report_data and 'Automatically generated report' in report_data['comment']:
            continue

        if task and 'task' in report_data and task not in report_data['task']:
            continue

        if name and name not in report_data['name']:
            continue

        data.append(report_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_report_dict(report, **kwargs):
    """Returns all information about the plot as dictionary

    :param report: report definition, index or name
    :type report: COPASI.CReportDefinition or int or str
    :param kwargs: optional arguments

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

    :return: a dictionary with all information about the plot
    :rtype: dict
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(report, str) or isinstance(report, int):
        spec = dm.getReportDefinition(report)
        if spec is None:
            logger.error('No plot specification: {0}'.format(report))
            return

        report = spec

    assert (isinstance(report, COPASI.CReportDefinition))

    result = {
        'name': report.getObjectName(),
        'separator': report.getSeparator().getStaticString(),
        'precision': report.getPrecision(),
        'task': __xml_task_type_to_string(report.getTaskType()),
        'comment': report.getComment(),
        'is_table': report.isTable()
    }

    if report.isTable():
        result['print_headers'] = report.getTitle()
        table_items = _add_report_items_to_list([], report.getNumTableItems(), report.getNthTableItem, dm)
        result['table'] = table_items

    else:
        result['header'] = _add_report_items_to_list([], report.getNumHeaderItems(), report.getNthHeaderItem, dm)
        result['body'] = _add_report_items_to_list([], report.getNumBodyItems(), report.getNthBodyItem, dm)
        result['footer'] = _add_report_items_to_list([], report.getNumFooterItems(), report.getNthFooterItem, dm)

    return result


def _add_report_items_to_list(result, num_elements, get_nth_function, dm):
    for i in range(num_elements):
        cn = get_nth_function(i)
        obj = dm.getObject(cn)
        if obj is None:
            obj = dm.getObjectFromCN(COPASI.CCommonName(cn))

        if obj is None:
            logger.warning('report item cannot be resolved: {0}'.format(cn.getString()))
            continue

        reverse = dm.findObjectByDisplayName(obj.getObjectDisplayName())
        if reverse is None:
            # item that cannot be resolved by name so use cn
            result.append(cn.getString())
        else:
            result.append(obj.getObjectDisplayName())

    return result


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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(plot_spec, str) or isinstance(plot_spec, int):
        spec = dm.getPlotSpecification(plot_spec)
        if spec is None:
            logger.error('No plot specification: {0}'.format(plot_spec))
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
                curve_data['channels'].append(channels[k].getString())
                continue
            name = channel_obj.getObjectDisplayName()
            if not dm.getObject(COPASI.CCommonName(name)):
                name = channels[k].getString()
            curve_data['channels'].append(name)

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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(plot_spec, str) or isinstance(plot_spec, int):
        spec = dm.getPlotSpecification(plot_spec)
        if spec is None:
            logger.error('No plot specification: {0}'.format(plot_spec))
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
            plot_item.getParameter('Recording Activity').setStringValue(activity)

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
                if channel.startswith('CN='):
                    plot_item.addChannel(COPASI.CPlotDataChannelSpec(COPASI.CCommonName(channel)))
                    continue

                obj = dm.findObjectByDisplayName(channel)
                if channel == 'Time':
                    obj = dm.getModel().getValueReference()
                if obj is None:
                    logger.warning("Couldn't resolve {0} when adding curve spec".format(channel))
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))
    plot_spec = dm.getPlotDefinitionList().createPlotSpec(name, COPASI.CPlotItem.plot2d)

    if not plot_spec:
        raise ValueError('A plot named ' + name + ' already exists')

    set_plot_dict(plot_spec, **kwargs)

    return plot_spec


def add_default_plot(name, **kwargs):
    """Adds a default plot to the list of plots

    :param name: name of the default plot
    :type name: str


    :param kwargs: optional arguments

        - | `new_name`: to rename the plot specification

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: none or the name of the plot created
    :rtype: str or None
    """

    if name not in get_default_plot_names():
        logger.warning('No such default plot: {0}'.format(name))
        return

    item = COPASI.COutputAssistant.getItem(_default_plots[name])
    assert (isinstance(item, COPASI.CDefaultOutputDescription))

    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    for task in dm.getTaskList():
        assert (isinstance(task, COPASI.CCopasiTask))
        if task.getType() == item.mTaskType:
            dm.getModel().compileIfNecessary()
            if isinstance(task, COPASI.CFitTask):
                task.getProblem().getExperimentSet().compile(task.getMathContainer())
            task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI)
            result = COPASI.COutputAssistant.createDefaultOutput(_default_plots[name], task, dm)
            if result is None:
                logger.warning('Failed to create default plot for: {0}'.format(name))
                return None
            return result.getObjectName()

    logger.warning('No task found for the plot')
    return None


_default_plots = {}


def get_default_plot_names(filter=None, **kwargs):
    """Returns a list of default plot names

    :param filter: optional filter of substring to be in the name
    :param kwargs:
    :return:
    """
    ids = COPASI.COutputAssistant.getListOfDefaultOutputDescriptions()
    global _default_plots
    if _default_plots:
        return _default_plots

    _default_plots = {}
    for index in ids:
        item = COPASI.COutputAssistant.getItem(index)
        assert (isinstance(item, COPASI.CDefaultOutputDescription))
        if not item.isPlot:
            continue
        if filter and filter not in item.name:
            continue
        _default_plots[item.name] = index
    return _default_plots


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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(plot_spec, str) or isinstance(plot_spec, int):
        spec = dm.getPlotSpecification(plot_spec)
        if spec is None:
            logger.error('No plot specification: {0}'.format(plot_spec))
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


def add_report(name, **kwargs):
    """Adds a new report specification to the model.

     Examples:

        The following would adds a report definition 'Time Course' to include Time and the concentration
        of S, in a report that is separated by tabs.

        >>> add_report('Time Course', body=['Time', '[S]']

        The following defines a report for the Steady State concentration of S. To disambiguate, that the
         string '[S]' in the header should be used literally, we call the function wrap_copasi_string.

        >>> add_report('Steady State', task=T.STEADY_STATE, header=[wrap_copasi_string('[S]')], footer=['[S]'])

        :param name: the name for the new plot specification
        :type name: str

        :param kwargs: optional parameters, recognized are:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

            * all other parameters from :func:`set_report_dict`.

        :return: the report definition
        """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))
    spec = dm.getReportDefinitionList().createReportDefinition(name, "")

    if not spec:
        raise ValueError('A report named ' + name + ' already exists')

    set_report_dict(spec, **kwargs)

    return spec


def set_report_dict(spec, precision=None, separator=None, table=None,
                    print_headers=True, header=None, body=None, footer=None, task=None,
                    comment=None, add_separator=None, **kwargs):
    """Sets properties of the named report definition.

        Examples:

        The following would set a report definition 'Time Course' to include Time and the concentration
        of S, in a report that is separated by tabs.

        >>> set_report_dict('Time Course', body=['Time', '[S]']

        The following defines a report for the Steady State concentration of S. To disambiguate, that the
         string '[S]' in the header should be used literally, we call the function wrap_copasi_string.

        >>> set_report_dict('Steady State', task=T.STEADY_STATE, header=[wrap_copasi_string('[S]')], footer=['[S]'])


        :param spec: the name, index or report definition object
        :type spec: Union[str,int,COPASI.CReportDefinition]

        :param precision: number of digits to print (defaults to 6)
        :type precision: Optional[int]

        :param separator: the separator to use between elements (defaults to \t)
        :type separator: Optional[str]

        :param table: a list of CNs or display names of elements to collect in a table. If `table` is specified
              the header, body, footer argument will be ignored. Note that setting table elements is only
              useful for tasks that generate output *during* the task. If that is not the case, you will have
              to specify the footer and header element directly.

        :type table: [str]

        :param print_headers: optional arguments, indicating whether table headers will be printed (only applies
               when the `table` argument is given
        :type print_headers: bool

        :param header: a list of CNs or display names of elements to collect in the header column
        :type header: [str]

        :param body: a list of CNs or display names of elements to collect in the body rows
        :type body: [str]

        :param footer: a list of CNs or display names of elements to collect in the footer column
        :type footer: [str]

        :param task: | task name for which the report should be used
        :type task: Optional[str]

        :param comment: a documentation string for the report (can bei either string, or xhtml string)
        :type comment: Optional[str]

        :param add_separator: an optional boolean flag, to automatically add seprators between header, body and
            footer entries since this is not necessary for table entries.
        :type add_separator: Optional[bool]

        :param kwargs: optional arguments

            - | `new_name`: to rename the report

            - | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: None
        """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if isinstance(spec, str) or isinstance(spec, int):
        r = dm.getReportDefinition(spec)
        if r is None:
            logger.error('No report specification: {0}'.format(spec))
            return

        spec = r

    assert (isinstance(spec, COPASI.CReportDefinition))

    if 'new_name' in kwargs:
        spec.setObjectName(kwargs['new_name'])

    if comment:
        spec.setComment(comment)

    if precision:
        spec.setPrecision(precision)

    if separator:
        spec.setSeparator(separator)

    if task is not None:
        spec.setTaskType(__task_name_to_xml_type(task))

    if table:
        spec.setIsTable(True)
        spec.setTitle(print_headers)
        _set_report_vector(spec.getTableAddr(), table, dm)
    else:
        seprator = 'Separator=' + spec.getSeparator().getStaticString()
        if header:
            _set_report_vector(spec.getHeaderAddr(), header, dm, seprator)
            spec.setIsTable(False)
        if body:
            _set_report_vector(spec.getBodyAddr(), body, dm, seprator)
            spec.setIsTable(False)
        if footer:
            _set_report_vector(spec.getFooterAddr(), footer, dm, seprator)
            spec.setIsTable(False)

def _get_registered_common_name(cn, dm):
    if isinstance(cn, COPASI.CRegisteredCommonName):
        return cn
    
    if _copasi_build < 286:
        return COPASI.CRegisteredCommonName(cn)
    
    return COPASI.CRegisteredCommonName(cn, dm)


def _set_report_vector(vec, list_of_cns, dm, separator=None):
    """ Sets the given vector to the elements of the list

    :param vec: the vector to change
    :type vec: COPASI.ReportItemVector
    :param list_of_cns: list of cns or display names to add
    :type list_of_cns: [str]
    :param dm: the data model to resolve elements in
    :type dm: COPASI.CDataModel
    :param separator: optional sepratator string to add between entries
    :type separator: Optional[str]
    :return: None
    """
    vec.clear()

    if not list_of_cns:
        return

    for item in list_of_cns:
        if item.startswith('CN'):
            vec.append(_get_registered_common_name(item, dm))
            if separator:
                vec.append(_get_registered_common_name(separator, dm))
            continue

        obj = dm.findObjectByDisplayName(item)
        if obj:
            if obj.getObjectType() != 'Reference':
                obj = obj.getValueReference()
            vec.append(_get_registered_common_name(obj.getCN(), dm))
            if separator:
                vec.append(_get_registered_common_name(separator, dm))
            continue

        if not item.startswith('String=') and not item.startswith('Separator='):
            item = wrap_copasi_string(item)
        vec.append(_get_registered_common_name(item, dm))
        if separator:
            vec.append(_get_registered_common_name(separator, dm))

    if separator:
        vec.pop()


def wrap_copasi_string(text):
    """ Utility function wrapping the given text into a COPASI string

    :param text: the text to wrap
    :return: an escaped COPASI string, that can be used in reports
    """
    return 'String=' + COPASI.CCommonName.escape(text)

def _is_known_reference_start(text, additional_list=None, reaction_list=None):
    if text.startswith('['):
        return 1, ']'
    if text.startswith('Values['):
        return len('Values['), ']'
    if text.startswith('Compartments['):
        return len('Compartments['), ']'
    if reaction_list:
        for r in reaction_list:
            if text.startswith(f'({r}).'):
                return len(f'({r}).'), ' '
    if additional_list:
        for s in additional_list:
            if text.startswith(f'[{s}]'):
                return len(f'[{s}]'), ' '
            if text.startswith(f'{s}.'):
                return len(f'{s}.'), ' '
    
    return None

def _is_known_reference_end(text):
    for end in [']', 
                ']_0',
                '].InitialValue', 
                '].Value',
                '].Rate',
                '].InitialConcentration',
                '].Flux',
                '].InitialParticleNumber',
                '].ParticleFlux',
                '].ParticleNumberRate',
                '].InitialVolume',
                ]:
        if text.endswith(end):
            return True
    return False

def _ends_in_start_e_notation(text):
    # go through the string from reverse and check if it ends <number>e|E<space>
    num_chars = len(text)
    i = num_chars - 1
    found_e = False
    had_numbers = False
    while i >= 0:
        cur_char = text[i]
        if cur_char in 'eE':
            if found_e: 
                return False
            found_e = True
            i -= 1
            continue

        if not found_e and cur_char == ' ':
            i -= 1
            continue
        
        if found_e and had_numbers and cur_char == ' ':
            return True
        
        if not cur_char.isdigit():  # not a number            
            if cur_char == '.':
                i-=1
                continue
            return False

        had_numbers = True
        i -= 1
    return had_numbers and found_e

def _replace_names_with_cns(expression, **kwargs):
    """ replaces all names in the given expression with cns

    :param expression: the expression as infix
    :type expression: str
    :param kwargs:
    :return: the expression with names replaced by cns
    """

    if type(expression) is not str:
        expression = str(expression)

    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    species_names = [s.getObjectName() for s in dm.getModel().getMetabolites()]
    reaction_names = [r.getObjectName() for r in dm.getModel().getReactions()]

    resulting_expression = ''
    expression = expression.replace('{', ' {')
    expression = expression.replace('}', '} ')
    expression += ' '
    current_word = None

    def _get_reference(dm, word):
        obj = dm.findObjectByDisplayName(word)
        if obj is not None:
            if isinstance(obj, COPASI.CModel):
                obj = obj.getValueReference()
            return ' <{0}>'.format(obj.getCN())
        return ' ' + word

    num_chars = len(expression)
    i = 0
    while i < num_chars:
        cur_char = expression[i]
        c_next = expression[i + 1] if (i + 1) < num_chars else None
        c_2 = expression[i + 2] if (i + 2) < num_chars else None
        c_3 = expression[i + 3] if (i + 3) < num_chars else None
        substr = expression[i:]

        if cur_char == '<' and c_next == 'C' and c_2 == 'N' and c_3 == '=':
            end = expression.find('>', i)
            cn = expression[i: end+1]
            resulting_expression += ' ' + cn
            i = end +1
            if i == 0:
                break
            continue

        if cur_char == '{':
            end = expression.find('}', i)
            reference = expression[i+1: end]
            resulting_expression += _get_reference(dm, reference)
            i = end +1
            if i == 0:
                break
            continue

        found = _is_known_reference_start(substr, species_names, reaction_names)
        if found is not None:
            end = expression.find(found[1], i + found[0])
            reference = expression[i: end+1].strip()
            if end != -1 and end + 1 < num_chars and expression[end + 1] == '.':
                end = expression.find(' ', end + 1)
                if end == -1:
                    end = num_chars
                reference = expression[i: end]
            elif end != -1 and end + 1 < num_chars and expression[end + 1] == '_':
                end = expression.find(' ', end + 1)
                if end == -1:
                    end = num_chars
                reference = expression[i: end]
            resulting_expression += _get_reference(dm, reference)
            i = end +1

            if i == 0:
                break
            continue

        if cur_char in '/*+-()^%<>!=&|':
            if current_word is not None:
                resulting_expression += ' ' + current_word
                current_word = None

            # fix an issue with number in e-notation
            if (cur_char == '-' or cur_char == '+') and _ends_in_start_e_notation(resulting_expression):
                # remove trailing space                                
                if resulting_expression[-1] == ' ':
                    resulting_expression = resulting_expression[:-1]
                resulting_expression += cur_char
                i += 1
                # read next characters while they are numbers
                while i < num_chars and expression[i].isdigit():
                    resulting_expression += expression[i]
                    i += 1
                continue
            
            resulting_expression += cur_char
        elif cur_char != ' ':
            if current_word is None:
                current_word = cur_char
            else:
                current_word += cur_char
        else:
            if current_word is not None:
                is_known = dm.findObjectByDisplayName(current_word)
                if is_known:
                    resulting_expression += ' <{0}>'.format(is_known.getCN())
                elif _is_known_reference_start(current_word, species_names) and not is_known:
                    resulting_expression += ' ' + current_word
                else:
                    resulting_expression += ' ' + current_word
                current_word = None

        i += 1
        
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
                if current:
                    result.append(current)
                    current = ''

                end = expression.find('>', pos)
                cn = expression[pos+1: end]
                result.append(cn)
                pos = end + 1
                continue

        if cur_char in '/*+-()^%<>!=&|':

            if cur_char == '+' or cur_char == '-':
                if current and _ends_in_start_e_notation(current):
                    current += cur_char
                    pos += 1
                    continue

            if current:
                result.append(current)
                current = ''

            if pos + 1 < num_chars and expression[pos + 1] == '=':
                cur_char += '='
                pos += 1
            
            # fix an issue with || and &&
            for c in ['|', '&']:
                if pos + 1 < num_chars and expression[pos + 1] == c and cur_char == c:
                    cur_char += c
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

    dm = model_io.get_model_from_dict_or_default(kwargs)
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
                if ' ' in word:
                    word = '{' + word + '}'
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = _get_object_by_name(kwargs['name'], dm)

        if element is None:
            logger.warning("Couldn't find element {0} to set notes.".format(kwargs['name']))
            return

    if element is None:
        logger.warning("Couldn't find element to set notes.")
        return

    if isinstance(element, COPASI.CDataObject):
        if element.getObjectType() == 'Reference':
            element = element.getObjectParent()
        element = COPASI.CAnnotation.castObject(element)

    if isinstance(element, COPASI.CAnnotation):
        element.setNotes(notes)
    else:
        logger.warning("Unsupported element type for setting notes.")

def _get_object_by_name(name, dm):
    """Helper function to get an object by its display name."""
    model = dm.getModel()
    if model.getObjectName() == name:
        return model
    result = model.getModelValue(name)
    if result:
        return result
    result = model.getMetabolite(name)
    if result:
        return result
    result = model.getCompartment(name)
    if result:
        return result
    result = model.getReaction(name)
    if result:
        return result
    result = model.getEvent(name)
    if result:
        return result
    result = dm.findObjectByDisplayName(name)
    if result:
        return result
    return _get_function(name)

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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = _get_object_by_name(kwargs['name'], dm)

        if element is None:
            logger.warning("Couldn't find element {0} to get notes.".format(kwargs['name']))
            return None

    if element is None:
        logger.warning("Couldn't find element to get notes.")
        return None

    if isinstance(element, COPASI.CDataObject):
        if element.getObjectType() == 'Reference':
            element = element.getObjectParent()
        element = COPASI.CAnnotation.castObject(element)

    if isinstance(element, COPASI.CAnnotation):
        return element.getNotes()
    else:
        logger.warning("Unsupported element type for getting notes.")
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = _get_object_by_name(kwargs['name'], dm)

        if element is None:
            logger.warning("Couldn't find element {0} to get annotations.".format(kwargs['name']))
            return None

    if element is None:
        logger.warning("Couldn't find element to get annotations.")
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
        logger.warning("Unsupported element type for getting annotations.")
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    element = dm.getModel()
    if 'element' in kwargs:
        element = kwargs['element']
    elif 'name' in kwargs:
        element = _get_object_by_name(kwargs['name'], dm)
        if element is None:
            logger.warning("Couldn't find element {0} to set annotations.".format(kwargs['name']))
            return

    if element is None:
        logger.warning("Couldn't find element to set annotations.")
        return

    if not isinstance(element, COPASI.CDataObject):
        logger.warning("Unsupported element type for setting annotations.")
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
    for _ in range(num_entries):
        info.removeModification(info.getModifications().get(0))


def _remove_descriptions(info):
    num_entries = info.getBiologicalDescriptions().size()
    for _ in range(num_entries):
        info.removeBiologicalDescription(info.getBiologicalDescriptions().get(0))


def _remove_references(info):
    num_entries = info.getReferences().size()
    for _ in range(num_entries):
        info.removeReference(info.getReferences().get(0))


def _remove_creators(info):
    num_entries = info.getCreators().size()
    for _ in range(num_entries):
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartment = model.createCompartment(name, initial_size)
    if compartment is None:
        raise ValueError('A compartment named ' + name + ' already exists')

    _set_compartment(compartment, model, **kwargs)

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

    if mapping is None:
        mapping = {}

    if db.findLoadFunction(name) is not None:
        logger.error('A function with name "' + name + '" already exists')
        return

    fun = db.createFunction(name, COPASI.CEvaluationTree.Function)
    if fun is None:
        logger.error('Could not create a function with name "' + name + '" already exists')
        return

    fun.setInfix(infix)
    fun.setReversible(__function_type_to_int(type))

    variables = fun.getVariables()
    assert (isinstance(variables, COPASI.CFunctionParameters))

    for i in range(variables.size()):
        param = variables.getParameter(i)
        assert (isinstance(param, COPASI.CFunctionParameter))
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
    assert (isinstance(db, COPASI.CFunctionDB))

    fun = db.findFunction(name)
    assert (isinstance(fun, COPASI.CFunction))
    if fun is None:
        logger.warning('A function with name "' + name + '" does not exists')
        return

    if fun.isReadOnly():
        logger.error('The function "' + name + '" is readonly and cannot be deleted')
        return

    key = fun.getKey()

    db.removeFunction(key)


def remove_user_defined_functions():
    """Removes all user defined functions along with all elements that still use them
    """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    db = root.getFunctionList()
    assert (isinstance(db, COPASI.CFunctionDB))
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    # create compartment if it does not yet exist
    if not compartment_name:
        if model.getNumCompartments() == 0:
            model.createCompartment('compartment', 1)
        compartment_name = model.getCompartment(0).getObjectName()
    elif not model.getCompartment(compartment_name):
        model.createCompartment(compartment_name, 1)

    species = model.createMetabolite(name, compartment_name, initial_concentration)
    if species is None:
        raise ValueError('A species named ' + name + ' already exists in compartment ' + compartment_name)

    _set_species(species, model, **kwargs)

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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameter = model.createModelValue(name, initial_value)
    if parameter is None:
        raise ValueError('A global parameter named ' + name + ' already exists')

    if len(kwargs) and parameter:
        _set_parameter(parameter, model, **kwargs)

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
             * 'new_name': the new name for the event
             * 'delay': the delay expression
             * 'priority': the priority expression
             * 'persistent': boolean indicating if the event is persistent
             * 'delay_calculation': boolean indicating whether just the assignment is delayed, or the
                                    calculation as well
             * 'fire_at_initial_time': boolean indicating if the event should fire at the initial time

        :return: the newly created event
        """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    event = model.createEvent(name)
    if event is None:
        raise ValueError('An Event named ' + name + ' already exists')
    assert (isinstance(event, COPASI.CEvent))

    _set_event(event, dm, trigger=trigger, assignments=assignments, **kwargs)

    return event


def set_event(name, exact=False, trigger=None, assignments=None, **kwargs):
    """Sets properties of the named event

    :param name: the name of the event (or a substring of the name)
    :type name: str

    :param exact: boolean indicating, that the name has to be exact
    :type exact: bool

    :param trigger: the trigger expression to be used. The expression can consist of all display names.
               for example `Time > 10` would make the event trigger at time 10.
    :type trigger: str or None

    :param assignments: All the assignments that should be made, when the event fires. This should be a
                list of tuples where the first element is the name of the element to change, and the second element
                the assignment expression.
    :type assignments: [(str,str)] or None


    :param kwargs: optional parameters, recognized are:

         * | `model`: to specify the data model to be used (if not specified
           | the one from :func:`.get_current_model` will be taken)
         * 'new_name': the new name for the event
         * 'delay': the delay expression
         * 'priority': the priority expression
         * 'persistent': boolean indicating if the event is persistent
         * 'delay_calculation': boolean indicating whether just the assignment is delayed, or the calculation as well
         * 'fire_at_initial_time': boolean indicating if the event should fire at the initial time

    :return:
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    events = model.getEvents()
    num_events = events.size()

    for i in range(num_events):
        event = events.get(i)
        assert (isinstance(event, COPASI.CEvent))

        current_name = event.getObjectName()
        display_name = event.getObjectDisplayName()

        if name and type(name) is str and exact and name != current_name and name != display_name:
            continue

        if 'name' in kwargs and kwargs['name'] not in current_name and kwargs['name'] not in display_name:
            continue

        if name and type(name) is str and name not in current_name and name not in display_name:
            continue

        _set_event(event, dm, assignments, trigger, **kwargs)


def _set_event(event, dm, assignments, trigger, **kwargs):
    """Sets the event attributes

    :param event: the event to change
    :type event: COPASI.CEvent
    :param dm: the datamodel
    :type dm: COPASI.CDataModel
    :param assignments: dictionary of event assignments
    :param trigger: trigger expression
    :param kwargs: other attributes
       - 'new_name': the new name for the event
       - 'delay': the delay expression
       - 'priority': the priority expression
       - 'persistent': boolean indicating if the event is persistent
       - 'delay_calculation': boolean indicating whether just the assignment is delayed, or the calculation as well
       - 'fire_at_initial_time': boolean indicating if the event should fire at the initial time
       - 'model': the model to use
    :return:
    """

    if not event or not dm:
        return

    need_compile = False
    if 'new_name' in kwargs and not event.setObjectName(kwargs['new_name']):
        logger.warning('could not rename event')

    if 'delay' in kwargs:
        event.setDelayExpression(_replace_names_with_cns(kwargs['delay'], model=dm))
        need_compile = True

    if 'priority' in kwargs:
        event.setPriorityExpression(_replace_names_with_cns(kwargs['priority'], model=dm))
        need_compile = True

    if 'persistent' in kwargs:
        event.setPersistentTrigger(bool(kwargs['persistent']))
        need_compile = True

    if 'delay_calculation' in kwargs:
        event.setDelayAssignment(bool(kwargs['delay_calculation']))
        need_compile = True

    if 'fire_at_initial_time' in kwargs:
        event.setFireAtInitialTime(bool(kwargs['fire_at_initial_time']))
        need_compile = True

    if trigger:
        event.setTriggerExpression(_replace_names_with_cns(trigger, model=dm))
        need_compile = True

    if assignments:
        for assignment in assignments:
            target = dm.findObjectByDisplayName(assignment[0])
            if target is None:
                logger.warning("Couldn't resolve target for event assignment {0}, skipping.".format(assignment[0]))
                continue
            if target.getObjectType() == 'Reference':
                target = target.getObjectParent()
            ea = event.createAssignment(target.getCN())
            assert (isinstance(ea, COPASI.CEventAssignment))
            ea.setExpression(_replace_names_with_cns(assignment[1], model=dm))

        need_compile = True

    if need_compile:
        model_list = COPASI.ContainerList()
        model_list.push_back(dm)
        event.compile(model_list)

    dm.getModel().compileIfNecessary()


def add_event_assignment(name, assignment, exact=False, **kwargs):
    """Adds an event assignment to the named event

    :param name: the name (or substring of name) of an event
    :type name: str

    :param assignment: tuple or list of tuples of event assignments of form (target, expression)
    :type assignment: [(str,str)] or (str, str)

    :param exact: boolean indicating whether the named expression has to be exact
    :type exact: bool

    :return: None
    """
    assignments = assignment
    if not isinstance(assignments, list):
        assignments = [assignment]

    set_event(name, exact, assignments=assignments)


def _get_name_map(dm, include_species=True, include_parameters=True, include_compartments=True, include_reactions=True):
    """Returns a dictionary mapping the display names to underlying DataObjects

    :param dm: the data model
    :type dm: COPASI.CDataModel

    :return: the dictionary mapping the display names to the objects
    :rtype: dict[str, COPASI.CDataObject]
    """
    names = {
        "Time": [dm.getModel()],
        "Avogadro Constant": [dm.getModel()],
        "Quantity Conversion Factor": [dm.getModel()],
    }

    def _append_to_list(function_name):
        for element in function_name():
            name = element.getObjectName()
            if name not in names:
                names[name] = []
            names[name].append(element)

    if include_species:
        _append_to_list(dm.getModel().getMetabolites)

    if include_parameters:
        _append_to_list(dm.getModel().getModelValues)

    if include_compartments:
        _append_to_list(dm.getModel().getCompartments)

    if include_reactions:
        _append_to_list(dm.getModel().getReactions)
    
    return names

def ensure_unique_names(include_species=True, include_parameters=True, include_compartments=True, include_reactions=True, **kwargs):
    """ Ensures that all names in the model are unique

    :param include_species: boolean indicating whether to check species
    :type include_species: bool

    :param include_parameters: boolean indicating whether to check parameters
    :type include_parameters: bool

    :param include_compartments: boolean indicating whether to check compartments
    :type include_compartments: bool

    :param include_reactions: boolean indicating whether to check reactions
    :type include_reactions: bool

    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: boolean indicating whether any names have been changed
    :rtype: bool

    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

    names = _get_name_map(dm, include_species, include_parameters, include_compartments, include_reactions)

    renamed = False

    for name, elements in names.items():
        if len(elements) > 1:
            count = 1
            for element in elements[1:]:
                element.setObjectName(name + f' ({count})')
                count += 1
                renamed = True

    return renamed

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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reaction = model.createReaction(name)
    if reaction is None:
        raise ValueError('A reaction named ' + name + ' already exists')

    assert (isinstance(reaction, COPASI.CReaction))
    _set_reaction(reaction, dm, scheme=scheme, **kwargs)

    return reaction


def get_compartments(name=None, exact=False, **kwargs):
    """Returns all information about the compartments as pandas dataframe.

        :param name: optional filter expression for the compartment, if it is not included in the name,
                     the compartment will not be added to the data set.
        :type name: str

        :param exact: boolean indicating, that the name has to be exact
        :type exact: bool

        :param kwargs: optional arguments:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: a pandas dataframe with the information about the compartment
        :rtype: pandas.DataFrame
        """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()
    assert (isinstance(compartments, COPASI.CompartmentVectorNS))

    num_compartments = compartments.size()
    data = []

    for i in range(num_compartments):
        compartment = compartments.get(i)
        assert (isinstance(compartment, COPASI.CCompartment))

        unit = compartment.getUnitExpression()
        if not unit:
            unit = model.getVolumeUnit()

        current_name = compartment.getObjectName()
        if name and exact and name != current_name:
            continue

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and name not in current_name:
            continue

        current_type = __status_to_string(compartment.getStatus())
        if 'type' in kwargs and kwargs['type'] not in current_type:
            continue

        sbml_id = compartment.getSBMLId()
        if 'sbml_id' in kwargs and kwargs['sbml_id'] != sbml_id:
            continue

        comp_data = {
            'name': current_name,
            'type': current_type,
            'unit': unit,
            'initial_size': compartment.getInitialValue(),
            'initial_expression': _replace_cns_with_names(compartment.getInitialExpression(), model=dm),
            'dimensionality': compartment.getDimensionality(),
            'expression': _replace_cns_with_names(compartment.getExpression(), model=dm),
            'size': compartment.getValue(),
            'rate': compartment.getRate(),
            'key': compartment.getKey(),
            'sbml_id': sbml_id,
            'display_name': compartment.getObjectDisplayName(),
        }

        data.append(comp_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_parameters(name=None, exact=False, **kwargs):
    """Returns all information about the global parameters as pandas dataframe.

        :param name: optional filter expression for the parameters, if it is not included in the name,
                     the parameter will not be added to the data set.
        :type name: str

        :param exact: boolean indicating that the name has to be exact
        :type exact: bool

        :param kwargs: optional arguments:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: a pandas dataframe with the information about the parameter
        :rtype: pandas.DataFrame
        """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameters = model.getModelValues()
    assert (isinstance(parameters, COPASI.ModelValueVectorN))

    num_params = parameters.size()
    data = []

    for i in range(num_params):
        param = parameters.get(i)
        assert (isinstance(param, COPASI.CModelValue))

        unit = param.getUnitExpression()
        if 'unit' in kwargs and not kwargs['unit'] in unit:
            continue

        current_name = param.getObjectName()
        display_name = param.getObjectDisplayName()

        if name and exact and name != current_name and name != display_name:
            continue

        if 'name' in kwargs and (kwargs['name'] not in current_name and kwargs['name'] != display_name):
            continue

        if name and (name not in current_name and name != display_name):
            continue

        current_type = __status_to_string(param.getStatus())
        if 'type' in kwargs and kwargs['type'] not in current_type:
            continue

        sbml_id = param.getSBMLId()
        if 'sbml_id' in kwargs and kwargs['sbml_id'] != sbml_id:
            continue

        param_data = {
            'name': current_name,
            'type': current_type,
            'unit': unit,
            'initial_value': param.getInitialValue(),
            'initial_expression': _replace_cns_with_names(param.getInitialExpression(), model=dm),
            'expression': _replace_cns_with_names(param.getExpression(), model=dm),
            'value': param.getValue(),
            'rate': param.getRate(),
            'key': param.getKey(),
            'sbml_id': sbml_id,
            'display_name': param.getObjectDisplayName(),
        }

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

            * | `suitable_for`: an optional reaction for which to filter the function list. Only functions
              | suitable for the reaction will be returned

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

           :return: a pandas dataframe with the information about the functions
           :rtype: pandas.DataFrame
           """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    functions = root.getFunctionList().loadedFunctions()
    data = []

    suitable_for = None
    num_substrates = None
    num_products = None
    reversibility = False

    if 'suitable_for' in kwargs:
        dm = model_io.get_model_from_dict_or_default(kwargs)
        suitable_for = dm.getModel().getReaction(kwargs['suitable_for'])
        if suitable_for is None:
            logger.error('No reaction {0} found'.format(kwargs['suitable_for']))
            return None
        assert (isinstance(suitable_for, COPASI.CReaction))
        eqn = suitable_for.getChemEq()
        num_substrates = eqn.getSubstrates().size()
        num_products = eqn.getProducts().size()
        reversibility = suitable_for.isReversible()
        functions = COPASI.CRootContainer.getFunctionList().suitableFunctions(
            num_substrates, num_products, reversibility)

    for index in range(functions.size()):
        try:
            kin_function = functions.get(index)
        except AttributeError:
            kin_function = functions[index]

        assert (isinstance(kin_function, COPASI.CFunction))

        fun_data = {
            'name': kin_function.getObjectName(),
            'reversible': kin_function.isReversible() == 1,
            'formula': kin_function.getInfix(),
            'general': kin_function.isReversible() == -1,
        }

        if 'name' in kwargs and kwargs['name'] not in fun_data['name']:
            continue

        if 'reversible' in kwargs and kwargs['reversible'] != fun_data['reversible']:
            continue

        if name and name not in fun_data['name']:
            continue

        fun_data['mapping'] = _get_function_mapping(kin_function)

        data.append(fun_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def _get_function(name):
    """ Resolves the function from name

    :param name: name of a function in the function database
    :type name: str
    :return: the function or None
    :rtype: COPASI.CFunction
    """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    functions = root.getFunctionList().loadedFunctions()

    for i in range(functions.size()):
        fun = functions.get(i)
        if fun.getObjectName() == name:
            return fun

    return None


def _get_function_mapping(kin_function, filter=None):
    """ Returns the mapping for the given function

    :param kin_function: the function to get the mapping for
    :type kin_function: COPASI.CFunction
    :param filter: usage to filter for (e.g. `modifier`)
    :type filter: str
    :return: the mapping as dictionary
    :rtype: Dict
    """
    mapping = {}
    if kin_function is None:
        return mapping

    params = kin_function.getVariables()
    assert (isinstance(params, COPASI.CFunctionParameters))
    for i in range(params.size()):
        p = params.getParameter(i)
        assert (isinstance(p, COPASI.CFunctionParameter))
        n = p.getObjectName()
        u = __usage_to_string(p.getUsage())
        if filter and filter != u:
            continue
        mapping[n] = u

    return mapping


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
    dm = model_io.get_model_from_dict_or_default(kwargs)
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
        info = COPASI.CReactionInterface()
        info.init(reaction)

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
            is_global = not info.isLocalValue(j)
            if is_global and mv and isinstance(mv, COPASI.CModelValue):
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
        return pandas.DataFrame()

    return pandas.DataFrame(data=data).set_index('name')


def get_reactions(name=None, exact=False, **kwargs):
    """Returns all reactions as pandas dataframe.

       :param name: optional filter expression, if it is not included in the name,
                    the reaction will not be added to the data set.
       :type name: str

       :param exact: boolean indicating, that the name has to be exact
       :type exact: bool

       :param kwargs: optional arguments:

        * | `reaction_name`: to further filter for local parameters of only certain reactions
          | (that contain the substring)

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

       :return: a pandas dataframe with the information about local parameters
       :rtype: pandas.DataFrame
       """
    dm = model_io.get_model_from_dict_or_default(kwargs)
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
            'sbml_id': reaction.getSBMLId(),
            'display_name': reaction.getObjectDisplayName(),
        }

        if name and exact and name != reaction_data['name']:
            continue

        if 'name' in kwargs and kwargs['name'] not in reaction_data['name']:
            continue

        if name and name not in reaction_data['name']:
            continue

        if 'sbml_id' in kwargs and kwargs['sbml_id'] != reaction_data['sbml_id']:
            continue

        # add reaction mapping
        reaction_data['mapping'] = get_reaction_mapping(reaction, model=dm)

        data.append(reaction_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_time_unit(**kwargs):
    """Returns the time unit of the model"""
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    time = model.getTimeUnit()

    return time


def set_compartment(name=None, exact=False, **kwargs):
    """Sets properties of the named compartment

    :param name: the name of the compartment (or a substring of the name)
    :type name: str

    :param exact: boolean indicating whether the name has to be exact
    :type exact: bool

    :param kwargs: optional arguments


        - | `new_name`: the new name for the compartment

        - | `initial_value` or `initial_size`: to set the initial size of the compartment

        - | `value` or `size`: to set the transient size of the compartment

        - | `initial_expression`: the initial expression for the compartment

        - | `status` or `type`: the type of the compartment one of `fixed`, `assignment` or `ode`

        - | `expression`: the expression for the compartment (only valid when type is `ode` or `assignment`)

        - | `dimensionality`: sets the dimensionality of the compartment (int value 1..3)

        - | `notes`: sets notes for the compartment (either plain text, or valid xhtml)

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()

    num_compartments = compartments.size()

    for i in range(num_compartments):
        compartment = compartments.get(i)
        assert (isinstance(compartment, COPASI.CCompartment))
        current_name = compartment.getObjectName()

        if name and type(name) is str and exact and name != current_name:
            continue

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        _set_compartment(compartment, model, **kwargs)


def _set_compartment(compartment, c_model, **kwargs):
    """Changes all compartment properties

    :param compartment: the compartment object to change
    :type compartment: COPASI.CCompartment
    :param c_model: the copasi model
    :type c_model: COPASI.CModel
    :param kwargs: all attributes to change
    :return: None
    """
    if not compartment or not c_model:
        return

    if 'new_name' in kwargs:
        compartment.setObjectName(kwargs['new_name'])
    for initial in ['initial_value', 'initial_size']:
        if initial in kwargs:
            c_model.updateInitialValues(compartment.getInitialValueReference())
            compartment.setInitialValue(float(kwargs[initial]))
            c_model.updateInitialValues(compartment.getInitialValueReference())
    for transient in ['value', 'size']:
        if transient in kwargs:
            compartment.setValue(float(kwargs[transient]))
    if 'initial_expression' in kwargs:
        _set_initial_expression(compartment, kwargs['initial_expression'], model=c_model.getObjectDataModel())
        c_model.setCompileFlag(True)
    if 'status' in kwargs:
        compartment.setStatus(__status_to_int(kwargs['status']))
    if 'type' in kwargs:
        compartment.setStatus(__status_to_int(kwargs['type']))
    if 'expression' in kwargs:
        _set_expression(compartment, kwargs['expression'], model=c_model.getObjectDataModel())
        c_model.setCompileFlag(True)
    if 'dimensionality' in kwargs:
        compartment.setDimensionality(int(kwargs['dimensionality']))
    if 'notes' in kwargs:
        compartment.setNotes(kwargs['notes'])
    if 'sbml_id' in kwargs:
        compartment.setSBMLId(kwargs['sbml_id'])


def _set_initial_expression(element, expression, model=None):
    """Utility function to safely set an initial expression

        :param element: model element
        :type element: COPASI.CModelEntity        

        :param expression: infix expression to set
        :param model: the data model to use
        :return: None
        """
    if element is None:
        return

    _set_safe(element.setInitialExpression, expression, model)


def _set_expression(element, expression, model=None):
    """Utility function to safely set an ODE / assignment expression

    :param element: model element
    :type element: COPASI.CModelEntity

    :param expression: infix expression to set
    :param model: the data model to use
    :return: None
    """
    if element is None:
        return
    _set_safe(element.setExpression, expression, model=model)


def _set_safe(fun, expression, model=None):
    """Calls the given function that is supposed to return a COPASI.CIssue

    :param fun: function to call
    :param expression: infix expression
    :param model: the data model to use
    :return:
    """
    result = fun(_replace_names_with_cns(expression, model=model))
    if result.isError():
        logger.error('Invalid expression: {0}'.format(expression))
        # set to empty string avoid crash
        fun('')


def set_parameters(name=None, exact=False, **kwargs):
    """Sets properties of the named parameter(s).

    :param name: the name of the parameter (or a substring of the name)
    :type name: str

    :param exact: boolean indicating whether the name has to be exact or not
    :type exact: bool

    :param kwargs: optional arguments

        - | `new_name`: the new name for the parameter
        - | `unit`: the unit expression to be set
        - | `initial_value`: to set the initial value for the parameter
        - | `value`: set the transient value for the parameter
        - | `initial_expression`: the initial expression
        - | `status` or `type`: the type of the parameter one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the parameter (only valid when type is `ode` or `assignment`)
        - | `notes`: sets notes for the parameter (either plain text, or valid xhtml)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameters = model.getModelValues()
    assert (isinstance(parameters, COPASI.ModelValueVectorN))

    num_params = parameters.size()

    for i in range(num_params):
        param = parameters.get(i)
        assert (isinstance(param, COPASI.CModelValue))
        current_name = param.getObjectName()
        display_name = param.getObjectDisplayName()

        if name and type(name) is str and exact and name != current_name and name != display_name:
            continue

        if 'name' in kwargs and (kwargs['name'] not in current_name and kwargs['name'] != display_name):
            continue

        if name and type(name) is str and (name not in current_name and name != display_name):
            continue

        if name and isinstance(name, Iterable) and (current_name not in name and display_name not in name):
            continue

        _set_parameter(param, model, **kwargs)


def _set_parameter(param, c_model, **kwargs):
    """Changes the parameter attributes

    :param param: the parameter to change
    :type param: COPASI.CModelValue
    :param c_model: the model to change
    :type c_model: COPASI.CModel
    :param kwargs: the attributes to change
    :return:
    """
    if not param or not c_model:
        return

    if 'new_name' in kwargs and not param.setObjectName(str(kwargs['new_name'])):
        logger.warning('could not rename the parameter')

    if 'unit' in kwargs:
        param.setUnitExpression(kwargs['unit'])

    if 'initial_value' in kwargs:
        param.setInitialValue(float(kwargs['initial_value']))
        c_model.updateInitialValues(param.getInitialValueReference())

    if 'value' in kwargs:
        param.setValue(float(kwargs['value']))

    if 'initial_expression' in kwargs:
        _set_initial_expression(param, kwargs['initial_expression'], model=c_model.getObjectDataModel())
        c_model.setCompileFlag(True)

    if 'status' in kwargs:
        param.setStatus(__status_to_int(kwargs['status']))
        c_model.setCompileFlag(True)

    if 'type' in kwargs:
        param.setStatus(__status_to_int(kwargs['type']))
        c_model.setCompileFlag(True)

    if 'expression' in kwargs:
        _set_expression(param, kwargs['expression'], model=c_model.getObjectDataModel())
        c_model.setCompileFlag(True)

    if 'notes' in kwargs:
        param.setNotes(kwargs['notes'])

    if 'sbml_id' in kwargs:
        param.setSBMLId(kwargs['sbml_id'])


def set_reaction_parameters(name=None, **kwargs):
    """Sets local parameter values.

    :param name: the name of the parameter (or a substring of the name)
    :type name: str

    :param kwargs: optional arguments

        - | `reaction_name`: if specified only parameters of the named reaction will be changed
        - | `value`: the new value of the parameter to set. (only one of `value` / `mapped_to` should be defined)
        - | `mapped_to`: the name of a global parameter to map the local parameter to
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
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

            if 'mapped_to' in kwargs and current_param is not None:
                mv = model.getModelValue(kwargs['mapped_to'])
                if not mv:
                    logger.warning('No such parameter "{0}" to map to.'.format(kwargs['mapped_to']))
                    continue

                info = COPASI.CReactionInterface()
                info.init(reaction)
                for k in range(info.size()):
                    p_type = info.getUsage(k)
                    p_name = info.getParameterName(k)
                    if p_name == current_param.getObjectName() and p_type == COPASI.CFunctionParameter.Role_PARAMETER:
                        info.setMapping(k, mv.getObjectName())
                        info.writeBackToReaction(reaction)
                        fun_params = reaction.getFunctionParameters()
                        param_objects = reaction.getParameterObjects()
                        changed = True

        if changed:
            reaction.compile()
            model.setCompileFlag(True)


def set_reaction(name=None, exact=False, **kwargs):
    """Sets attributes of the named reaction.

    :param name: the name of the reaction (or a substring of the name)
    :type name: str

    :param exact: boolean indicating whether the name has to be exact
    :type exact: bool

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

    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()
    num_reactions = reactions.size()

    changed = False

    for i in range(num_reactions):
        reaction = reactions.get(i)
        assert (isinstance(reaction, COPASI.CReaction))

        current_name = reaction.getObjectName()

        if name and type(name) is str and exact and name != current_name:
            continue

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        changed = _set_reaction(reaction, dm, **kwargs)

    if changed:
        model.setCompileFlag(True)


def _set_reaction(reaction, dm, **kwargs):
    """Changes all reaction properties

    :param reaction: the reaction to modify
    :type reaction: COPASI.CReaction
    :param dm: the datamodel
    :type dm: COPASI.CDataModel
    :param kwargs: the attributes to change
    :return: boolean indicating, whether compilation is necessary
    """
    changed = False

    c_model = reaction.getObjectDataModel().getModel()

    if 'new_name' in kwargs:
        reaction.setObjectName(kwargs['new_name'])

    if 'scheme' in kwargs:
        info = COPASI.CReactionInterface()
        info.init(reaction)
        info.setChemEqString(kwargs['scheme'], '')
        info.createMetabolites()
        info.createOtherObjects()
        info.writeBackToReaction(reaction)
        reaction.compile()
        changed = True

    if 'function' in kwargs:
        info = COPASI.CReactionInterface()
        info.init(reaction)
        info.setFunctionAndDoMapping(kwargs['function'])

        missing = _get_parameter_mapping(info, missing_only=True)

        if missing and 'mapping' in kwargs:
            # try and apply mapping directly if we have one
            mapping = kwargs['mapping']
            for entry in missing:
                if entry['is_vector']:
                    continue
                param_name = entry['name']
                if param_name in mapping and _validate_mapping(entry['usage'],
                                                               param_name,
                                                               mapping[param_name], c_model):
                    info.setMapping(entry['index'], mapping[param_name])

        missing = _get_parameter_mapping(info, missing_only=True)
        if missing and ('mapping' not in kwargs or
                        not _valid_with_added_modifiers(
                            reaction, info, kwargs['function'],
                            kwargs['mapping'], dm)):
            # not valid yet, try and see if it were valid when adding modifiers
            logger.error(
                'the mapping for reaction "{0}" with function "{1}" is not '
                'valid and cannot be applied. (missing mapping(s) for {2})'.format(
                    reaction.getObjectName(), kwargs['function'],
                    [entry['usage'] + ': ' + entry['name'] for entry in missing]))

        info.writeBackToReaction(reaction)
        reaction.compile()
        changed = True

    if 'mapping' in kwargs:
        changed = set_reaction_mapping(reaction, kwargs['mapping'], model=dm)

    if 'notes' in kwargs:
        reaction.setNotes(kwargs['notes'])

    if 'sbml_id' in kwargs:
        reaction.setSBMLId(kwargs['sbml_id'])

    return changed


def _get_parameter_mapping(info, missing_only=False):
    """ Returns mapping from the info object

    :param info: the reaction information
    :type info: COPASI.CReactionInterface
    :return: array of mapping entries
    """
    result = []
    for i in range(info.size()):
        name = info.getParameterName(i)
        usage = __usage_to_string(info.getUsage(i))
        is_vector = info.isVector(i)
        mapping = info.getMapping(i)

        if missing_only and mapping != 'unknown':
            continue

        mappings = [s for s in info.getMappings(i)]

        result.append({
            'name': name,
            'usage': usage,
            'is_vector': is_vector,
            'mapping': mapping,
            'mappings': mappings,
            'index': i
        })
    return result


def _validate_mapping(usage, param_name, mapped_value, c_model):
    """Validates whether the mapped value is correct for the function parameter

    :param usage: str (or int) of the usage type of the function paramater
    :param param_name: name of the parameter
    :param mapped_value: the value it should be mapped to
    :param c_model: the model to look in.
    :type c_model: COPASI.CModel
    :return: True, if the value is ok, False otherwise
    """
    if type(usage) is int:
        usage = __usage_to_string(usage)

    if usage == "volume":
        result = c_model.getCompartment(mapped_value) is not None
    elif usage == "parameter":
        result = type(mapped_value) is str and c_model.getModelValue(mapped_value) is not None
    else:
        result = c_model.getMetabolite(mapped_value) is not None

    if not result:
        logger.error('Invalid mapping provilded for {0} of type {1} (invalid value {2})'
                     .format(param_name, usage, mapped_value))

    return result


def _valid_with_added_modifiers(reaction, info, function_name, mapping, dm):
    if not reaction or not info or not dm:
        return False
    kin_function = _get_function(function_name)
    modifiers = list(_get_function_mapping(kin_function, 'modifier').keys())
    if not modifiers:
        return False

    # ensure that the modifiers are mapped
    for modifier in modifiers:
        if modifier not in mapping:
            return False

    current_scheme = reaction.getReactionScheme()
    modifier_index = current_scheme.rfind(';')

    old_modfiers = '' if modifier_index < 0 else current_scheme[modifier_index+1:].strip()
    old_scheme = current_scheme if modifier_index < 0 else current_scheme[:modifier_index].strip()

    new_modifiers = old_modfiers
    for modifier in modifiers:
        if mapping[modifier] not in new_modifiers:
            new_modifiers += ' ' + mapping[modifier]

    new_scheme = old_scheme + '; ' + new_modifiers.strip()

    # now apply and see if it works
    info.setChemEqString(new_scheme, function_name)
    if not info.isValid():
        # set back to old
        info.setChemEqString(current_scheme, function_name)
        return False

    return True


def get_reaction_mapping(reaction, **kwargs):
    """Returns the reaction mapping of the given reaction

    :param reaction: name of a reaction, or the reaction object
    :type reaction: str or COPASI.CReaction

    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the dictionary with the reaction mapping
    :rtype: {}
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if type(reaction) is str:
        r = model.getReaction(reaction)
        if r is None:
            logger.warning('No reaction with name: {0}'.format(reaction))
            return False

        reaction = r

    result = {}

    info = COPASI.CReactionInterface()
    info.init(reaction)
    for j in range(info.size()):
        p_type = info.getUsage(j)
        p_name = info.getParameterName(j)
        if p_type == COPASI.CFunctionParameter.Role_PARAMETER and info.isLocalValue(j):
            result[p_name] = reaction.getParameterValue(p_name)
            continue

        objs = info.getMappings(j)
        obj_size = objs.size()
        if obj_size == 1:
            result[p_name] = objs[0]
            continue

        obj_list = []
        for i in range(obj_size):
            obj_list.append(objs[i])
        result[p_name] = obj_list

    return result


def set_reaction_mapping(reaction, mapping, **kwargs):
    """Sets the reaction mapping of the parameters as specified in the mapping dictionary

    :param reaction: the name of the reaction (or reaction object)
    :type reaction: str or COPASI.CReaction

    :param mapping: dictionary that maps model elements to the function
           parameters. (can be any volume, species, modelvalue or in case of
          local parameters a value)
    :type mapping: {}

    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: boolean indicating whether the reaction was changed
    :rtype: bool

    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if type(reaction) is str:
        r = model.getReaction(reaction)
        if r is None:
            logger.warning('No reaction with name: {0}'.format(reaction))
            return False

        reaction = r

    changed = False

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
                    # version 4.34 and below cannot change back from global to local
                    if changed:
                        info.writeBackToReaction(reaction)
                    objs = COPASI.DataObjectVector()
                    objs.push_back(reaction.getParameters().getParameter(p_name))
                    reaction.setParameterObjects(p_name, objs)
                    reaction.setParameterValue(p_name, value)
                    info.init(reaction)
                    changed = True
                except ValueError:
                    obj = model.getModelValue(mapped_to)
                    if obj is None:
                        obj = dm.findObjectByDisplayName(mapped_to)
                        if obj is not None and type(obj) != COPASI.CModelValue:
                            logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                            continue
                    if obj is None:
                        logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                        continue

                    info.setMapping(j, obj.getObjectName())
                    changed = True

            elif p_type == COPASI.CFunctionParameter.Role_SUBSTRATE or \
                    p_type == COPASI.CFunctionParameter.Role_PRODUCT or \
                    p_type == COPASI.CFunctionParameter.Role_MODIFIER:

                if not info.isVector(j):
                    obj = model.getMetabolite(mapped_to)
                    if obj is None:
                        obj = dm.findObjectByDisplayName(mapped_to)
                        if obj is not None and type(obj) != COPASI.CMetab:
                            logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                            continue
                    if obj is None:
                        logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                        continue
                    info.setMapping(j, obj.getObjectName())
                    changed = True
                    continue

                mapped_list = mapped_to
                if type(mapped_list) is str:
                    mapped_list = [mapped_to]

                info.writeBackToReaction(reaction)
                current = reaction.getParameterObjects(j)
                objs = COPASI.DataObjectVector()
                for obj in current:
                    objs.append(obj)

                current_length = len(current)
                mapped_length = len(mapped_list)

                if current_length != mapped_length:
                    logger.warning('Different length encountered when setting mapping for parameter {0}: {1} != {2}'
                                   .format(p_name, current_length, mapped_length))

                smallest = min(current_length, mapped_length)
                for i in range(smallest):
                    mapped_to = mapped_list[i]
                    obj = model.getMetabolite(mapped_to)
                    if obj is None:
                        obj = dm.findObjectByDisplayName(mapped_to)
                        if obj is not None and type(obj) != COPASI.CMetab:
                            logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                            continue
                    if obj is None:
                        logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                        continue
                    objs[i] = obj

                reaction.setParameterObjects(j, objs)
                info.init(reaction)
                changed = True

            elif p_type == COPASI.CFunctionParameter.Role_VOLUME:
                obj = model.getCompartment(mapped_to)
                if obj is None:
                    obj = dm.findObjectByDisplayName(mapped_to)
                    if obj is not None and type(obj) != COPASI.CCompartment:
                        logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                        continue
                if obj is None:
                    logger.warning("Couldn't map '{0}' to parameter '{1}'".format(mapped_to, p_name))
                    continue

                info.setMapping(j, obj.getObjectName())
                changed = True

    if not changed:
        return False

    if not info.writeBackToReaction(reaction):
        logger.error("Couldn't change the reaction")
    reaction.compile()
    return True


def remove_species(name, **kwargs):
    """Deletes the named species

    :param name: the name of a species in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    metab = model.getMetabolite(name)
    if metab is None:
        logger.warning('no such metabolite {0}'.format(name))
        return

    key = metab.getKey()
    model.compileIfNecessary()
    model.removeMetabolite(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_parameter(name, **kwargs):
    """Deletes the named global parameter

    This will also delete any model element that uses this parameter, 
    so if it appears in any model expression, the elements using these 
    expressions will also be deleted. To prevent that, use the recursive
    parameter.
    
    :param name: the name of a parameter in the model
    :type name: str | List[str]

    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    model.compileIfNecessary()

    if type(name) is str:
        name = [name]

    for n in name:
        mv = model.getModelValue(n)
        if mv is None:
            logger.warning('no such global parameter {0}'.format(n))
            continue

        key = mv.getKey()
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    comp = model.getCompartment(name)
    if comp is None:
        logger.warning('no such compartment {0}'.format(name))
        return

    key = comp.getKey()
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    ev = model.getEvent(name)
    if ev is None:
        logger.warning('no such event {0}'.format(name))
        return
    key = ev.getKey()
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    output_list = dm.getPlotDefinitionList()
    assert (isinstance(output_list, COPASI.COutputDefinitionVector))

    for i in range(output_list.size()):
        plot = output_list.get(i)
        if plot.getObjectName() != name:
            continue

        output_list.remove(i)
        return

    logger.warning('no such plot {0}'.format(name))


def remove_report(name, **kwargs):
    """Deletes the named report

    :param name: the name of a report in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    report_list = dm.getReportDefinitionList()
    assert (isinstance(report_list, COPASI.CReportDefinitionVector))

    for i in range(report_list.size()):
        plot = report_list.get(i)
        if plot.getObjectName() != name:
            continue

        report_list.remove(i)
        return

    logger.warning('no such report {0}'.format(name))


def remove_reaction(name, **kwargs):
    """Deletes the named reaction

    :param name: the name of a reaction in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reaction = model.getReaction(name)
    if reaction is None:
        logger.warning('no such reaction {0}'.format(name))
        return

    key = reaction.getKey()
    model.compileIfNecessary()
    model.removeReaction(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def set_species(name=None, exact=False, **kwargs):
    """Sets properties of the named species

    :param name: the name of the species (or a substring of the name)
    :type name: str

    :param exact: boolean indicating, that the name has to be exact
    :type exact: bool

    :param kwargs: optional arguments

        - | `new_name`: the new name for the species
        - | `initial_concentration`: to set the initial concentration for the species
        - | `initial_particle_number`: to set the initial particle number for the species
        - | `initial_expression`: the initial expression for the species
        - | `concentration`: the new transient concentration for the species
        - | `particle_number`: the new transient particle number for the species
        - | `status` or `type`: the type of the species one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the species (only valid when type is `ode` or `assignment`)
        - | `notes`: sets notes for the species (either plain text, or valid xhtml)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    metabs = model.getMetabolites()
    num_metabs = metabs.size()

    for i in range(num_metabs):
        metab = metabs.get(i)
        assert (isinstance(metab, COPASI.CMetab))

        current_name = metab.getObjectName()
        display_name = metab.getObjectDisplayName()

        if name and type(name) is str and exact and name != current_name and name != display_name:
            continue

        if 'name' in kwargs and kwargs['name'] not in current_name and kwargs['name'] not in display_name:
            continue

        if name and type(name) is str and name not in current_name and name not in display_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name and display_name not in name:
            continue

        _set_species(metab, model, **kwargs)


def _set_species(metab, c_model, **kwargs):
    """Changes all species properties

    :param metab: the species to edit
    :type metab: COPASI.CMetab
    :param c_model: the model to update
    :type c_model: COPASI.CModel
    :param kwargs: the attributes to change
    :return:
    """
    if not metab or not c_model:
        return

    if 'new_name' in kwargs:
        metab.setObjectName(kwargs['new_name'])
    if 'unit' in kwargs:
        metab.setUnitExpression(kwargs['unit'])
    if 'initial_concentration' in kwargs:
        c_model.updateInitialValues(metab.getInitialConcentrationReference())
        metab.setInitialConcentration(float(kwargs['initial_concentration']))
        c_model.updateInitialValues(metab.getInitialConcentrationReference())
    if 'initial_particle_number' in kwargs:
        c_model.updateInitialValues(metab.getInitialValueReference())
        metab.setInitialValue(float(kwargs['initial_particle_number']))
        c_model.updateInitialValues(metab.getInitialValueReference())
    if 'concentration' in kwargs:
        metab.setConcentration(float(kwargs['concentration']))
    if 'particle_number' in kwargs:
        metab.setValue(float(kwargs['particle_number']))
    if 'initial_expression' in kwargs:
        _set_initial_expression(metab, kwargs['initial_expression'], model=c_model.getObjectDataModel())
        c_model.setCompileFlag(True)
    if 'status' in kwargs:
        metab.setStatus(__status_to_int(kwargs['status']))
    if 'type' in kwargs:
        metab.setStatus(__status_to_int(kwargs['type']))
    if 'expression' in kwargs:
        _set_expression(metab, kwargs['expression'], model=c_model.getObjectDataModel())
        c_model.setCompileFlag(True)
    if 'notes' in kwargs:
        metab.setNotes(kwargs['notes'])
    if 'sbml_id' in kwargs:
        metab.setSBMLId(kwargs['sbml_id'])


def set_time_unit(unit, **kwargs):
    """Sets the time unit of the model.

    :param unit: the time unit expression
    :type unit: str
    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'unit' in kwargs:
        model.setTimeUnit(kwargs['unit'])
    else:
        model.setTimeUnit(unit)

def get_model_name(**kwargs):
    """Returns the name of the current model.

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the name of the model
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))
    return model.getObjectName()


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
    dm = model_io.get_model_from_dict_or_default(kwargs)
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
    if isinstance(element, COPASI.CDataObject):
        if not element.setObjectName(new_name):
            logger.warning("couldn't change name of the element")
        return

    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if type(element) is str:
        obj = dm.findObjectByDisplayName(element)
        if obj is not None:
            if not obj.setObjectName(new_name):
                logger.warning("couldn't change name of the element")
            return

    logger.warning("couldn't change name of the element (could not find the object)")


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
    dm = model_io.get_model_from_dict_or_default(kwargs)

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'time_unit' in kwargs:
        model.setTimeUnit(kwargs['time_unit'])

    if 'substance_unit' in kwargs:
        model.setQuantityUnit(str(kwargs['substance_unit']))

    if 'quantity_unit' in kwargs:
        model.setQuantityUnit(str(kwargs['quantity_unit']))

    if 'length_unit' in kwargs:
        model.setLengthUnit(str(kwargs['length_unit']))

    if 'area_unit' in kwargs:
        model.setAreaUnit(str(kwargs['area_unit']))

    if 'volume_unit' in kwargs:
        model.setVolumeUnit(str(kwargs['volume_unit']))

    model.updateInitialValues(COPASI.CCore.Framework_Concentration)


def set_model_name(new_name, **kwargs):
    """Renames the model to the provided new name

    :param new_name: the new name of the model
    :type new_name: str

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None

    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    set_element_name(dm.getModel(), new_name)


def add_amount_expressions(**kwargs):
    """ Utility function that adds model values for all metabolites to the model to compute the amount

    The global parameters created will be named amount(metab_name), and so can be accessed at any time.
    Should the amount already exist, it will not be modified.

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    for metab in model.getMetabolites():
        assert (isinstance(metab, COPASI.CMetab))
        if metab.getCompartment() is None:
            logger.warning('Cannot create an amount expression for {0} as it has no compartment'.format(
                metab.getObjectDisplayName()))
            continue

        if 'ignore_fixed' in kwargs and kwargs['ignore_fixed'] \
                and metab.getStatus() == COPASI.CModelEntity.Status_FIXED:
            continue

        if 'ignore_assignment' in kwargs and kwargs['ignore_assignment'] \
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    keys = []
    for mv in model.getModelValues():
        assert (isinstance(mv, COPASI.CModelValue))
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


def get_miriam_resources(compact=True):
    """Retrieves the current MIRIAM resources from the configuration

    :param compact: whether to return a compact version of the resources (default: True)
    :type compact: bool

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
                'uri': res.getIdentifiersOrgURL(compact)
            })
    except AttributeError:
        logger.error("Couldn't retrieve list of miriam resources, please update the python-copasi version")

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
    except ValueError:
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
                 'csc', 'cot', 'sinh', 'cosh', 'tanh', 'sech',
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
    token = None

    while i < num_chars:
        c_0 = eqn[i]
        c_1 = eqn[i + 1] if i + 1 < num_chars else None
        c_2 = eqn[i + 2] if i + 2 < num_chars else None

        if ord(c_0) > 127:  # skip non-ascii characters
            logger.warning(u'Encountered invalid character {0} while tokenizing equation, skipping it.'.format(c_0))
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
                c_0 = eqn[i] if i < num_chars else None
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

            # remove trailing whitespace
            while i < num_chars and eqn[i] == ' ':
                i += 1

            continue

        elif c_0 == '=':

            if var is None:
                var = chunk

            if not var:
                if token:
                    result['lhs'] = token

                    var = None
                    var_is_species = False
                    var_is_initial = False
                    chunk = ''
                    result['is_ode'] = is_ode
                    tokens.remove(token)
                    token = None
                i += 1
                continue

            token = {
                'var': var,
                'is_species': var_is_species,
                'is_initial': var_is_initial
            }

            result['lhs'] = token

            if var_is_species and var and var not in species:
                species.append(var)
            elif not var_is_species and var and var not in parameters:
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
    if var is not None and var:
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
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


def _annotated_matrix_to_df_1d(ann_matrix):
    assert (isinstance(ann_matrix, COPASI.CDataArray))
    dim = ann_matrix.dimensionality()
    if dim != 1:
        logger.error('only one dimensional matrices are supported by this method')
        return None

    matrix = ann_matrix.getArray()
    index = [s for s in ann_matrix.getAnnotationsString(0)]
    data = []
    v = COPASI.SizeTStdVector()
    v.push_back(0)
    for x in range(len(index)):
        v[0] = x
        data.append(matrix.get(v))
    return pd.DataFrame(data, index=index)


def _annotated_matrix_to_df(ann_matrix):
    """Converts the annotated matrix to a pandas dataframe

    :param ann_matrix: the matrix to convert
    :type ann_matrix: COPASI.CDataArray
    :return: a pandas dataframe representing the matrix
    :rtype: pd.DataFrame
    """
    assert (isinstance(ann_matrix, COPASI.CDataArray))
    dim = ann_matrix.dimensionality()
    if dim != 2:
        if dim == 1:
            return _annotated_matrix_to_df_1d(ann_matrix)

        if dim == 0:
            return ann_matrix.getArray().get(COPASI.SizeTStdVector())

        logger.error('only 0-two dimensional matrices are supported at this time')
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))
    return _annotated_matrix_to_df(model.getStoiAnnotation())


def get_reduced_stoichiometry_matrix(**kwargs):
    """Returns the reduced stoichiometry matrix of the model

    :return: the stoichiometry matrix of the current model
    :rtype: pd.DataFrame

    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
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

        if status == COPASI.CModelEntity.Status_ODE or \
                (status == COPASI.CModelEntity.Status_REACTIONS and entity.isUsed()):
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
    dm = model_io.get_model_from_dict_or_default(kwargs)
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

    i_max = state_template.getNumIndependent()

    for i in range(0, i_max):
        name_vector.append(state_template.getIndependent(i).getObjectName())

    for i in range(0, i_max):
        row = {}
        for j in range(0, i_max):
            row[name_vector[j]] = jacobian.get(i, j)
        data.append(row)

    return pd.DataFrame(data, columns=name_vector, index=name_vector)


def _get_group_as_dict(group, basic_only=True, dm=None):
    """Returns the values from the given parameter group as dictionary

    :param group: the copasi parameter group
    :type group: COPASI.CCopasiParameterGroup

    :param basic_only: boolean indicating, whether only basic parameters should be returned (default)
    :type basic_only: bool

    :param dm: the data model to be used for resolving CN values
    :type dm: COPASI.CDataModel or None
    
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
        elif param_type == COPASI.CCopasiParameter.Type_CN:
            cn = param.getCNValue()
            if cn.getString() != '' and dm is not None: 
                obj = dm.getObject(cn)
                if obj is not None:
                    named = obj.getObjectDisplayName()
                    if dm.findObjectByDisplayName(named) is not None:
                        cn = named
                else:
                    logger.warning('could not find object with CN {0}'.format(cn))
            if isinstance(cn, COPASI.CCommonName):
                cn = cn.getString()
            result[name] = cn

    return result


def _set_group_from_dict(group, values, dm=None):
    """Changes settings in the given parameter group to the values specified in the values dictionary

    :param group: the copasi parameter group to update
    :type group: COPASI.CCopasiParameterGroup
    :param values: dictionary with new values
    :type values: dict
    :param dm: the data model to be used for resolving CN values
    :type dm: COPASI.CDataModel or None
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

        try:
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
            elif param_type == COPASI.CCopasiParameter.Type_CN:
                name_or_cn = str(values[key])
                if dm is not None:
                    obj = dm.getObject(COPASI.CCommonName(name_or_cn))
                    if obj is None:
                        obj = dm.findObjectByDisplayName(name_or_cn)
                    
                    if obj is not None:
                        name_or_cn = obj.getCN()
                    else:
                        logger.warning('could not find object with name or CN {0}'.format(name_or_cn))
                param.setCNValue(name_or_cn)
        except TypeError:
            logger.error('could not set value {0} for parameter {1}'.format(values[key], key))


def get_task_settings(task, basic_only=True, **kwargs):
    """Returns the settings of the given task

    :param task: the task to read the settings of
    :type task: COPASI.CCopasiTask or str

    :param basic_only: boolean flag, indicating that only the basic parameters should be returned
    :type basic_only: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: dict of task settings
    :rtype: {}

    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if not isinstance(task, COPASI.CCopasiTask):
        name = task
        task = dm.getTask(name)

    if not isinstance(task, COPASI.CCopasiTask):
        logger.error('no such task')
        return {}

    result = {
        'scheduled': task.isScheduled(),
        'update_model': task.isUpdateModel(),
    }

    problem = task.getProblem()
    result['problem'] = _get_group_as_dict(problem, basic_only, dm=dm)

    method = task.getMethod()
    result['method'] = _get_group_as_dict(method, basic_only, dm=dm)
    result['method']['name'] = method.getObjectName()

    report = task.getReport()
    assert (isinstance(report, COPASI.CReport))
    report_def = report.getReportDefinition()
    result['report'] = {
        'filename': report.getTarget(),
        'report_definition': report_def.getObjectName() if report_def is not None else None,
        'append': report.getAppend(),
        'confirm_overwrite': report.confirmOverwrite()
    }

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
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    if not isinstance(task, COPASI.CCopasiTask):
        name = task
        task = dm.getTask(name)

    if not isinstance(task, COPASI.CCopasiTask):
        logger.error('no such task')
        return

    if 'is_scheduled' in settings:
        task.setScheduled(settings['is_scheduled'])

    if 'scheduled' in settings:
        task.setScheduled(settings['scheduled'])

    if 'is_update_model' in settings:
        task.setUpdateModel(settings['is_update_model'])

    if 'update_model' in settings:
        task.setUpdateModel(settings['update_model'])

    if 'problem' in settings:
        problem = task.getProblem()
        _set_group_from_dict(problem, settings['problem'], dm=dm)

        if isinstance(problem, COPASI.CTrajectoryProblem):            
            if 'Duration' in settings['problem']:
                problem.setDuration(float(settings['problem']['Duration']))
            if 'StepSize' in settings['problem']:
                problem.setStepSize(float(settings['problem']['StepSize']))
            if 'intervals' in settings['problem']:
                problem.setStepNumber(int(settings['problem']['intervals']))
            if 'StepNumber' in settings['problem']:
                problem.setStepNumber(int(settings['problem']['StepNumber']))

    if 'method' in settings:
        method = task.getMethod()
        m_dict = settings['method']
        if 'name' in m_dict:
            name = m_dict['name']
            if name != method.getObjectName():
                task.setMethodType(COPASI.CCopasiMethod.TypeNameToEnum(name))
                method = task.getMethod()

        _set_group_from_dict(method, m_dict, dm=dm)

    if 'report' in settings:
        r_dict = settings['report']
        report = task.getReport()
        assert (isinstance(report, COPASI.CReport))
        if 'filename' in r_dict:
            report.setTarget(r_dict['filename'])

        if 'append' in r_dict:
            report.setAppend(r_dict['append'])

        if 'confirm_overwrite' in r_dict:
            report.setConfirmOverwrite(r_dict['confirm_overwrite'])

        if 'report_definition' in r_dict:
            name = r_dict['report_definition']
            if name is not None:
                r_def = dm.getReportDefinition(name)
                if r_def is not None:
                    report.setReportDefinition(r_def)

def _get_cn_string(cn):
    if isinstance(cn, COPASI.CCommonName):
        return cn.getString()
    return str(cn)

def _collect_data(names=None, cns=None, **kwargs):
    """Collects data from the model, returning it as dataframe

    :param names: list of names of elements to return
    :type names: list or None
    :param cns: list of common names of references for which to return the results
    :type cns: list or None
    :return: data frame with the results
    :rtype: pd.DataFrame
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    data = []

    value = None

    if cns:
        for cn in cns:
            c_cn = COPASI.CCommonName(cn)
            obj = model.getObject(c_cn)
            if obj is None:
                # couldn't find that object in the model
                logger.warning('No object for cn: {0}'.format(str(cn)))
                continue
            assert (isinstance(obj, COPASI.CDataObject))
            value = _get_value_from_reference(obj)

            data.append({'name': obj.getObjectDisplayName(), 'value': value})

    if names:
        for name in names:
            obj = model.findObjectByDisplayName(name)
            if obj is None:
                # couldn't find that object in the model
                logger.warning('No object for name: {0}'.format(name))
                continue
            assert (isinstance(obj, COPASI.CDataObject))
            if obj.getObjectType() == 'Reference':
                value = _get_value_from_reference(obj)
            else:
                if isinstance(obj, COPASI.CMetab):
                    value = _get_value_from_reference(obj.getConcentrationReference())
                elif isinstance(obj, COPASI.CModelValue) or \
                        isinstance(obj, COPASI.CCompartment) or isinstance(obj, COPASI.CModel):
                    value = _get_value_from_reference(obj.getValueReference())
                elif isinstance(obj, COPASI.CReaction):
                    value = _get_value_from_reference(obj.getFluxReference())
                elif isinstance(obj, COPASI.CCopasiParameter):
                    value = _get_value_from_reference(obj.getValueReference())
                else:
                    value = None

            data.append({'name': obj.getObjectDisplayName(), 'value': value})

    return pandas.DataFrame(data=data).set_index('name')


def _get_value_from_reference(obj):
    """ Utility function returning a value from the given reference object

    :param obj: the reference object
    :type obj: COPASI.CDataObject
    :return: the value, if it could be resolved or None
    :rtype: float or None
    """
    if obj is None:
        return None
    parent = obj.getObjectParent()
    if parent is None:
        return None
    name = obj.getObjectName()
    value = _get_named_value(parent, name)
    return value


def _get_named_value(obj, name):
    """ Utility function that returns the value of the given copasi object

    :param obj: a copasi object, that could be a compartment, species, parameter, reaction
    :param name: the reference name to return
    :return:
    """
    is_metab = isinstance(obj, COPASI.CMetab)
    is_reaction = isinstance(obj, COPASI.CReaction)
    is_model = isinstance(obj, COPASI.CModel)
    is_cparam = isinstance(obj, COPASI.CCopasiParameter)

    value = None

    if is_reaction:
        value = {
            'Flux': obj.getFlux(),
            'ParticleFlux': obj.getParticleFlux(),
        }.get(name, None)

    elif is_metab:
        value = {
            'Concentration': obj.getConcentration(),
            'ParticleNumber': obj.getValue(),
            'Rate': obj.getConcentrationRate(),
            'ParticleNumberRate': obj.getRate(),
            'InitialConcentration': obj.getInitialConcentration(),
            'InitialParticleNumber': obj.getInitialValue(),            
        }.get(name, None)

    elif is_model:
        value = {
            'Initial Time': obj.getInitialTime(),
            'Time': obj.getValue(),
        }.get(name, None)

    elif is_cparam:
        # this will be the case if it is a local parameter
        parent = obj.getObjectParent().getObjectParent()
        assert (isinstance(parent, COPASI.CReaction))
        value = parent.getParameterValue(obj.getObjectName())

    if pd.isna(value):
        value = {
            'Time': obj.getValue(),
            'Volume': obj.getValue(),
            'Value': obj.getValue(),
            'Rate': obj.getRate(),
            'InitialValue': obj.getInitialValue(),
            'InitialVolume': obj.getInitialValue(),
            'InitialParticleNumber': obj.getInitialValue(),
        }.get(name, None)

    return value


def _set_value_from_reference(obj, new_value):
    """ Utility function setting a value from the given reference object

    :param obj: the reference object
    :type obj: COPASI.CDataObject
    :param new_value: the new value to set
    :type new_value: float
    :return: None
    """
    if obj is None:
        return None
    parent = obj.getObjectParent()
    if parent is None:
        return None
    name = obj.getObjectName()
    _set_named_value(parent, name, new_value, obj)
    return


def _set_named_value(obj, name, new_value, ref):
    """ Utility function that sets the value of the given copasi object

    :param obj: a copasi object, that could be a compartment, species, parameter, reaction
    :param name: the reference name to set
    :param new_value: the new value for the element
    :param ref: the reference object
    :return:None
    """
    is_metab = isinstance(obj, COPASI.CMetab)
    is_reaction = isinstance(obj, COPASI.CReaction)
    is_model = isinstance(obj, COPASI.CModel)
    is_cparam = isinstance(obj, COPASI.CCopasiParameter)

    p_name = None
    set_function = None

    if is_reaction:
        set_function = {
            'Flux': obj.setFlux,
            'ParticleFlux': obj.setParticleFlux,
        }.get(name, None)

    elif is_metab:
        set_function = {
            'Concentration': obj.setConcentration,
            'ParticleNumber': obj.setValue,
            'InitialParticleNumber': obj.setInitialValue,
            'InitialConcentration': obj.setInitialConcentration,
        }.get(name, None)

    elif is_model:
        set_function = {
            'Initial Time': obj.setInitialTime,
            'Time': obj.setValue,
        }.get(name, None)

    elif is_cparam:
        # this will be the case if it is a local parameter
        parent = obj.getObjectParent().getObjectParent()
        assert (isinstance(parent, COPASI.CReaction))
        p_name = obj.getObjectName()
        set_function = parent.setParameterValue

    if pd.isna(set_function):
        set_function = {
            'Time': obj.setValue,
            'Volume': obj.setValue,
            'Value': obj.setValue,
            'InitialValue': obj.setInitialValue,
            'InitialVolume': obj.setInitialValue,
            'InitialParticleNumber': obj.setInitialValue,
        }.get(name, None)

    dm = basico.get_current_model()
    model = dm.getModel()

    if set_function is not None:
        if p_name is not None:
            set_function(p_name, new_value)
            model.updateInitialValues(ref)
        else:
            set_function(new_value)
            model.updateInitialValues(ref)


def set_value(name_or_reference, new_value, initial=False, **kwargs):
    """Gets the value of the named element or nones

    :param name_or_reference: display name of model element
    :type name_or_reference: str or COPASI.CDataObject

    :param new_value: the new value to set
    :type new_value: float

    :param initial: if True, an initial value will be set, rather than a transient one. If set to `None`, the
                    default reference will be returned and not coerced.
    :type initial: bool or None

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the value if found or None
    :rtype: float or None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    obj = _get_object(name_or_reference, initial=initial, model=model)

    if obj is None:
        return None

    return _set_value_from_reference(obj, new_value)


def _get_object(name_or_reference, initial=False, **kwargs):
    """Returns the reference object for the given name

    :param name_or_reference: display name of model element
    :type name_or_reference: str or COPASI.CDataObject

    :param initial: if True, an initial reference will be returned, rather than a transient one. If set to `None`, the
                    default reference will be returned and not coerced.
    :type initial: bool or None

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the reference object or None
    :rtype: COPASI.CDataObject or None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    if isinstance(name_or_reference, COPASI.CDataObject):
        obj = name_or_reference
    else:
        obj = model.findObjectByDisplayName(name_or_reference)
        if obj is None:
            return None
        if obj.getObjectType() == 'Metabolite':
            if initial:
                obj = obj.getInitialConcentrationReference()
            else:
                obj = obj.getConcentrationReference()
        elif obj.getObjectType() != 'Reference':
            if initial and not isinstance(obj, COPASI.CCopasiParameter):
                obj = obj.getInitialValueReference()
            else:
                obj = obj.getValueReference()

        # ensure reference is initial or transient as required
        if initial is not None:
            if initial:
                obj_name = obj.getObjectName()
                if obj_name == 'Concentration':
                    obj = obj.getObjectParent().getInitialConcentrationReference()
                if obj_name in ['Value', 'Volume', 'ParticleNumber']:
                    parent = obj.getObjectParent()
                    if not isinstance(parent, COPASI.CCopasiParameter):
                        obj = parent.getInitialValueReference()
            else:
                obj_name = obj.getObjectName()
                if obj_name == 'InitialConcentration':
                    obj = obj.getObjectParent().getConcentrationReference()
                if obj_name in ['InitialValue', 'InitialVolume', 'InitialParticleNumber']:
                    parent = obj.getObjectParent()
                    obj = parent.getValueReference()
    return obj


def get_value(name_or_reference, initial=False, **kwargs):
    """Gets the value of the named element or nones

    :param name_or_reference: display name of model element
    :type name_or_reference: str or COPASI.CDataObject

    :param initial: if True, an initial value will be returned, rather than a transient one. If set to `None`, the
                    default reference will be returned and not coerced.
    :type initial: bool or None

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the value if found or None
    :rtype: float or None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    obj = _get_object(name_or_reference, initial=initial, model=model)

    if obj is None:
        return None

    return _get_value_from_reference(obj)


def get_cn(name_or_reference, initial=False, **kwargs):
    """Gets the cn of the named element or none

    :param name_or_reference: display name of model element
    :type name_or_reference: str or COPASI.CDataObject

    :param initial: if True, an initial reference cn will be returned, rather than a transient one
    :type initial: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the cn if found or None
    :rtype: str or None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    obj = _get_object(name_or_reference, initial=initial, model=model)

    if obj is None:
        return None

    return obj.getCN().getString()


def assign_report(name, task, filename='', append=True, confirm_overwrite=True, **kwargs):
    """Assigns the named report to the specified task

    :param name: the name of the report definition to assign
    :type name: str

    :param task: the task to assign the report to
    :type task: Union[int, str, COPASI.CCopasiTask]

    :param filename: the filename to write the result to or `''`, if it is the empty, it resets the target
           of the task, and COPASI will not create that report
    :type filename: str

    :param append: boolean indicating whether output should be appended (defaults to True)
    :type append: bool

    :param confirm_overwrite: boolean indicating whether the copasi should ask before overwriting a file
    :type confirm_overwrite: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    if isinstance(task, int) or isinstance(task, str):
        obj = model.getTask(task)
        if obj is None:
            logger.error('No task {0}'.format(task))
            return
        task = obj

    report_definition = model.getReportDefinition(name)
    if not report_definition:
        logger.error('No report definition: {0}'.format(name))

    assert (isinstance(report_definition, COPASI.CReportDefinition))
    assert (isinstance(task, COPASI.CCopasiTask))

    r = task.getReport()
    assert (isinstance(r, COPASI.CReport))
    r.setAppend(append)
    r.setConfirmOverwrite(confirm_overwrite)
    r.setTarget(filename)
    r.setReportDefinition(report_definition)


def remove_report_from_task(task, **kwargs):
    """Clears the report filename from the specified task

    :param task: the task to assign the report to
    :type task: Union[int, str, COPASI.CCopasiTask]

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    if isinstance(task, int) or isinstance(task, str):
        obj = model.getTask(task)
        if obj is None:
            logger.error('No task {0}'.format(task))
            return
        task = obj

    assert (isinstance(task, COPASI.CCopasiTask))
    task.getReport().setTarget('')


def get_scheduled_tasks(**kwargs):
    """Returns the list of scheduled tasks

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: list of tasks that are scheduled
    :rtype: [str]
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))
    result = []
    for task in model.getTaskList():
        if task.isScheduled():
            result.append(task.getObjectName())
    return result


def set_scheduled_tasks(task_name, **kwargs):
    """Sets the scheduled tasks

    Only the tasks with the listed names will be set to be scheduled.

    :param task_name: name or list of names of tasks set to be scheduled
    :type task_name: str or [str]
    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    if isinstance(task_name, str):
        task_name = [task_name]

    for c_task in model.getTaskList():
        assert (isinstance(c_task, COPASI.CCopasiTask))
        c_task.setScheduled(c_task.getObjectName() in task_name)


def _invert_dict(d):
    """Utility function that inverts / reverses the given dictionary

    :param d: the dictionary to invert / revert
    :type d: dict

    :return: a dictionary that has the values as keys, and keys as values of d
    :rtype: dict
    """
    result = {}

    for k, v in d.items():
        result[v] = k

    return result


def _get_name_for_object(obj, model):
    """ Tries to get a nice display name for the given object, but falls back to cn, if name cannot be resolved

    :param obj: the copasi object to get the name for
    :type obj: COPASI.CDataObject

    :param model: the data model in which to resolve the object
    :type model: COPASI.CDataModel

    :return: name or cn of the object
    :rtype: str
    """
    name = obj.getObjectDisplayName()
    resolved = model.findObjectByDisplayName(name)

    if resolved is None:
        return obj.getCN().getString()

    if resolved.getCN().getString() != obj.getCN().getString():
        return obj.getCN().getString()

    return name


def as_dict(df, fold_list=True):
    """Convenience function returning the data frame as dictionary

    :param df: the data frame
    :type df: pd.DataFrame
    :param fold_list: optional boolean indicating whether to fold lists into a single dictionary,
                      if there is only one entry (defaults to true)
    :type fold_list: bool

    :return: the contents of the dataframe as [{}] if there are multiple ones,
             otherwise the dictionary if just one, or None
    :rtype: List[Dict] or Dict or None
    """
    if df is None:
        return None

    res = df.reset_index().to_dict(orient='records')
    if not res:
        return None

    if fold_list and len(res) == 1:
        return res[0]

    return res


def get_parameter_sets(name=None, exact=False, values_only=False, **kwargs):
    """
    Returns the list of parameter sets

    :param name: name of the parameter set to return (or a substring of the name)
    :type name: str

    :param exact: boolean indicating whether the name has to be exact or not (default: False)
    :type exact: bool

    :param values_only: boolean indicating whether to return only the values of the entries of the
                parameter set or a dictionary describing it (default: False)
    :type values_only: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    result = []

    sets = model.getModelParameterSets()
    assert (isinstance(sets, COPASI.ModelParameterSetVectorN))

    for i in range(sets.size()):
        pset = sets.get(i)
        set_name = pset.getObjectName()

        if name and name not in set_name:
            continue

        if name and type(name) is str and exact and name != set_name:
            continue

        result.append(_parameterset_to_dict(pset, dm, values_only))

    return result


def remove_parameter_sets(name=None, exact=False, **kwargs):
    """
    remove the named parameter set(s)

    :param name: name of the parameter set to remove (or a substring of the name)
    :type name: str

    :param exact: boolean indicating whether the name has to be exact
    :type exact: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    sets = model.getModelParameterSets()
    assert (isinstance(sets, COPASI.ModelParameterSetVectorN))

    num_sets = sets.size()

    for i in reversed(range(num_sets)):
        pset = sets.get(i)
        set_name = pset.getObjectName()

        if name and name not in set_name:
            continue

        if name and type(name) is str and exact and name != set_name:
            continue

        sets.remove(i)


def add_parameter_set(name, param_set_dict=None, **kwargs):
    """
    Adds a new parameter set to the model with the values from the dictionary

    :param name: name of the parameter set to add
    :type name: str

    :param param_set_dict: dictionary with the parameter set values if empty, the
                           current state of the model will be used
    :type param_set_dict: dict or None

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    sets = model.getModelParameterSets()
    assert (isinstance(sets, COPASI.ModelParameterSetVectorN))

    if sets.getByName(name) is not None:
        raise ValueError('Parameter set with name "{}" already exists'.format(name))

    # if we are here, the parameter set does not exist yet, unfortunately
    # the test added a message, so lets remove it
    if COPASI.CCopasiMessage.peekLastMessage().getNumber() == 5501:
        COPASI.CCopasiMessage.getLastMessage()

    if param_set_dict is None:
        # create parameter set from current state
        new_set = COPASI.CModelParameterSet(name)
        sets.addAndOwn(new_set)
        new_set.createFromModel()
        return

    new_set = COPASI.CModelParameterSet(name)
    sets.addAndOwn(new_set)

    _set_parameter_set(new_set, param_set_dict, dm, False)


def set_parameter_set(name, exact=False, param_set_dict=None, remove_others=False, **kwargs):
    """
    sets the named parameter sets to the given dictionary values

    :param name: name of the parameter set to change (or a substring of the name)
    :type name: str

    :param exact: boolean indicating whether the name has to be exact
    :type exact: bool

    :param param_set_dict: dictionary with the parameter set values
    :type param_set_dict: dict or None

    :param remove_others: boolean indicating whether to remove entries, that are not specified in the dictionary
                          (default: False)
    :type remove_others: bool

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    _run_functions_on_selected_parameter_sets(
        name, exact, False,
        _set_parameter_set,
        param_set_dict, dm, remove_others, True,
        **kwargs
    )


def _set_parameter_set(p_set, param_set_dict, dm, remove_others, rename_set=False):
    """ CHanges the specified parameter set

    :param p_set: the parameter set to change
    :param param_set_dict:  the dictionary with new values
    :param dm: the data model
    :param remove_others: boolean indicating whether to remove entries, that are not specified in the dictionary
    :param rename_set: boolean indicating whether to rename the parameter set
    :return: None
    """
    if not p_set:
        return

    if not param_set_dict:
        return

    for key in param_set_dict:
        if key == 'description':
            p_set.setNotes(param_set_dict['description'])
            continue

        if key == 'name' and rename_set:
            p_set.setObjectName(param_set_dict['name'])
            continue

        param = p_set.getModelParameter(COPASI.CDataString(key).getCN())
        if not param:
            continue

        _update_paramgroup(param, param_set_dict[key], key, dm, remove_others)

    p_set.compile()


def _update_paramgroup(param, group_dict, name, dm, remove_others):
    """ Updates the given model parameter group

    :param param: the parameter group to update
    :type param: COPASI.CModelParameterGroup
    :param group_dict: the dictionary with new values
    :param name: name of the group
    :param dm: the data model
    :param remove_others: boolean indicating whether to remove entries, that are not specified in the dictionary
    :return:
    """
    if remove_others:
        param.clear()
    for key in group_dict:
        current = group_dict[key]
        if isinstance(current, dict):
            value = current['value'] if 'value' in current else None
        else:
            value = float(current)
        p_type = _group_to_ptype_int(name, current)
        s_type = _guess_simulation_type(p_type, current)

        obj = _get_object_by_ptype(p_type, key, dm)
        if not obj:
            logger.warning('Could not find object for "{}", skipping'.format(key))
            continue

        new_param = param.getModelParameter(obj.getCN())
        if not new_param:
            new_param = param.add(p_type)
            new_param.setCN(obj.getCN())
            new_param.setSimulationType(s_type)

        if p_type == COPASI.CModelParameter.Type_Model:
            new_param.setValue(value)
            continue

        if p_type == COPASI.CModelParameter.Type_ModelValue:
            new_param.setValue(value)
            continue

        if p_type == COPASI.CModelParameter.Type_Compartment:
            new_param.setValue(value, COPASI.CCore.Framework_Concentration)
            continue

        if p_type == COPASI.CModelParameter.Type_Species:
            if isinstance(current, dict):
                if 'particle_number' in current:
                    new_param.setValue(current['particle_number'], COPASI.CCore.Framework_ParticleNumbers)
                if 'concentration' in current:
                    new_param.setValue(current['concentration'], COPASI.CCore.Framework_Concentration)
            else:
                new_param.setValue(value, COPASI.CCore.Framework_Concentration)
            continue

        if p_type == COPASI.CModelParameter.Type_Reaction:
            for param_key in current:
                current_p = current[param_key]
                if isinstance(current_p, dict):
                    value = current_p['value'] if 'value' in current_p else None
                    p_type = _parameter_type_to_int(
                        current_p['parameter_type']) if 'parameter_type' in current_p else None
                    s_type = __status_to_int(current_p['simulation_type']) if 'simulation_type' in current_p else None
                else:
                    value = float(current_p)
                    p_type = COPASI.CModelParameter.Type_ReactionParameter
                    s_type = COPASI.CModelEntity.Status_FIXED

                param_name = '({}).{}'.format(key, param_key)
                local_param_obj = dm.findObjectByDisplayName(param_name)

                if not local_param_obj:
                    logger.warning('Could not find local parameter "{}", skipping'.format(param_name))
                    continue

                local_param = new_param.add(p_type)
                local_param.setCN(local_param_obj.getCN())
                local_param.setValue(value)
                local_param.setSimulationType(s_type)


def apply_parameter_set(name, exact=False, **kwargs):
    """ Applies the parameter set with the given name to the model

    :param name: the name of the parameter set or a substring of the name
    :param exact: boolean indicating whether the name has to match exactly

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    _run_functions_on_selected_parameter_sets(
        name, exact, False,
        lambda pset: pset.updateModel(),
        **kwargs
    )


def _run_functions_on_selected_parameter_sets(_name, _exact, _reversed, function, *args, **kwargs):
    """ Runs the given function on all parameter sets in the model

    :param dm: the data model
    :param function: the function to run
    :param args: arguments for the function
    :param kwargs: keyword arguments for the function
    :return:
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    sets = model.getModelParameterSets()
    assert (isinstance(sets, COPASI.ModelParameterSetVectorN))

    num_sets = sets.size()
    this_range = range(num_sets)
    if _reversed:
        this_range = reversed(this_range)
    for i in this_range:
        pset = sets.get(i)
        set_name = pset.getObjectName()

        if _name and _name not in set_name:
            continue

        if _name and type(_name) is str and _exact and _name != set_name:
            continue

        function(pset, *args, **kwargs)


def update_parameter_set(name, exact=False, **kwargs):
    """ Updates the specified parameter set with values from the model

    :param name: the name of the parameter set or a substring of the name
    :param exact: boolean indicating whether the name has to match exactly

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:

    """
    _run_functions_on_selected_parameter_sets(
        name, exact, False,
        lambda pset: pset.refreshFromModel(True), **kwargs)


def _get_object_by_ptype(p_type, name, dm):
    if p_type == COPASI.CModelParameter.Type_Model:
        return dm.getModel()
    if p_type == COPASI.CModelParameter.Type_ModelValue:
        return dm.getModel().getModelValue(name)
    if p_type == COPASI.CModelParameter.Type_Compartment:
        return dm.getModel().getCompartment(name)
    if p_type == COPASI.CModelParameter.Type_Species:
        return dm.getModel().getMetabolite(name)
    if p_type == COPASI.CModelParameter.Type_Reaction:
        return dm.getModel().getReaction(name)
    return None


def _parametergroup_to_dict(pgroup, dm, values_only):
    result = {}
    for i in range(pgroup.size()):
        child = pgroup.getChild(i)
        if isinstance(child, COPASI.CModelParameterGroup):
            result[child.getName()] = _parametergroup_to_dict(child, dm, values_only)
            continue

        if values_only:
            if isinstance(child, COPASI.CModelParameterSpecies):
                result[child.getName()] = child.getValue(COPASI.CCore.Framework_Concentration)
            else:
                result[child.getName()] = child.getValue()
            continue

        new_dict = {}
        if isinstance(child, COPASI.CModelParameterSpecies):
            new_dict['concentration'] = child.getValue(COPASI.CCore.Framework_Concentration)
            new_dict['particle_number'] = child.getValue(COPASI.CCore.Framework_ParticleNumbers)
        else:
            new_dict['value'] = child.getValue()

        new_dict['parameter_type'] = _parameter_type_to_string(child.getType())
        new_dict['simulation_type'] = __status_to_string(child.getSimulationType())

        result[child.getName()] = new_dict

    return result


def _group_to_ptype_int(group_name, value_or_dict):
    if isinstance(value_or_dict, dict):
        p_type = _parameter_type_to_int(value_or_dict['parameter_type']) if 'parameter_type' in value_or_dict else None
        if p_type:
            return p_type

    values = {
        'Initial Time': COPASI.CModelParameter.Type_Model,
        "Initial Compartment Sizes": COPASI.CModelParameter.Type_Compartment,
        "Initial Species Values": COPASI.CModelParameter.Type_Species,
        "Initial Global Quantities": COPASI.CModelParameter.Type_ModelValue,
        "Kinetic Parameters": COPASI.CModelParameter.Type_Reaction,
    }

    return values.get(group_name, COPASI.CModelParameter.Type_Reaction)


def _guess_simulation_type(p_type, value_or_dict):
    if isinstance(value_or_dict, dict):
        s_type = __status_to_int(value_or_dict['simulation_type']) if 'simulation_type' in value_or_dict else None
        if s_type:
            return s_type

    if p_type == COPASI.CModelParameter.Type_Model:
        s_type = COPASI.CModelEntity.Status_TIME
    elif p_type == COPASI.CModelParameter.Type_Species:
        s_type = COPASI.CModelEntity.Status_REACTIONS
    else:
        s_type = COPASI.CModelEntity.Status_FIXED

    return s_type


def _parameter_type_to_string(p_type):
    # type: (int)->str
    strings = {
        COPASI.CModelParameter.Type_Model: "model",
        COPASI.CModelParameter.Type_ReactionParameter: "reaction_parameter",
        COPASI.CModelParameter.Type_Reaction: "reaction",
        COPASI.CModelParameter.Type_Set: "set",
        COPASI.CModelParameter.Type_Group: "group",
        COPASI.CModelParameter.Type_Compartment: "compartment",
        COPASI.CModelParameter.Type_ModelValue: "parameter",
        COPASI.CModelParameter.Type_Species: "species",
        COPASI.CModelParameter.Type_unknown: "unknown",
    }
    return strings.get(p_type, 'unknown')


def _parameter_type_to_int(p_type):
    # type: (str)->int
    values = {
        "model": COPASI.CModelParameter.Type_Model,
        "reaction_parameter": COPASI.CModelParameter.Type_ReactionParameter,
        "reaction": COPASI.CModelParameter.Type_Reaction,
        "set": COPASI.CModelParameter.Type_Set,
        "group": COPASI.CModelParameter.Type_Group,
        "compartment": COPASI.CModelParameter.Type_Compartment,
        "parameter": COPASI.CModelParameter.Type_ModelValue,
        "species": COPASI.CModelParameter.Type_Species,
        "unknown": COPASI.CModelParameter.Type_unknown,
    }
    return values.get(p_type, COPASI.CModelParameter.Type_unknown)


def _parameterset_to_dict(pset, dm, values_only):
    """
    Converts the given parameter set to a dictionary

    :param pset: the parameter set
    :type pset: COPASI.CModelParameterSet
    :param dm: the datamodel
    :return: dictionary of the parameter set
    """

    result = {'name': pset.getObjectName(),
              'description': pset.getNotes()}

    for entry in [
        'Initial Time',
        "Initial Compartment Sizes",
        "Initial Species Values",
        "Initial Global Quantities",
        "Kinetic Parameters"
    ]:
        result[entry] = _parametergroup_to_dict(
            pset.getModelParameter(COPASI.CDataString(entry).getCN()), dm, values_only)

    return result


def _simplify_name(name, drop=None):
    """
    Simplifies the given name by removing all special characters and replacing them with underscores
    additionally a list of substrings can be given that will be removed from the name

    :param name: the name to simplify
    :type name: str
    :param drop: a list of substrings to drop
    :type drop: list[str] or None
    :return: the simplified name
    """
    if drop:
        for substr in drop:
            name = name.replace(substr, '')

    # replace all non-alphanumeric characters with underscores
    name = re.sub(r'[^a-zA-Z0-9_]', '_', name)

    # remove double underscores
    name = name.replace('__', '_')

    # remove trailing underscores
    while name.endswith('_'):
        name = name[:-1]

    if drop:
        for substr in drop:
            name = name.replace(substr, '')

    return name


def simplify_names(**kwargs):
    """
    Simplifies the names of the model elements by removing all special characters and replacing them with underscores

    :param kwargs:

    - model: the model to simplify
    - drop: a list of substrings to drop from the names

    :return: None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)
    drop = kwargs.get('drop', None)

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    for i in range(model.getNumReactions()):
        reaction = model.getReaction(i)
        reaction.setObjectName(_simplify_name(reaction.getObjectName(), drop))

    for i in range(model.getNumMetabs()):
        metab = model.getMetabolite(i)
        metab.setObjectName(_simplify_name(metab.getObjectName(), drop))

    for i in range(model.getNumCompartments()):
        comp = model.getCompartment(i)
        comp.setObjectName(_simplify_name(comp.getObjectName(), drop))

    for i in range(model.getNumModelValues()):
        gq = model.getModelValue(i)
        gq.setObjectName(_simplify_name(gq.getObjectName(), drop))


def run_scheduled_tasks(include_plots=True, include_general_plots=False, plots=None, reports=None, **kwargs):
    """
    Runs all scheduled tasks, optionally producing plots and reports

    :param include_plots: boolean indicating whether to produce the plots associated with the task
    :param include_general_plots: boolean indicating whether to produce the general plots
    :param plots: optional list of plot dataframes computed by the task
    :param reports: optional list of report dataframes computed by the task
    :return: Figure produced if `include_plots` is true, otherwise None
    """
    for name in get_scheduled_tasks():
        run_task(name, include_plots, include_general_plots, plots, reports, **kwargs)


def _create_plot(plot_spec, data):
    """
    Creates a plot from the given plot specification and data

    :param plot_spec: the plot specification as dictionary produced from get_plot_specification
    :param data: pandas dataframe with the data for the plot
    :return: figure and axes element as tuple
    """
    cn_to_index = {}
    count = 0
    fig = plt.figure()
    ax = plt.subplot(111)
    for curve in plot_spec['curves']:
        for channel in curve['channels']:
            cn_to_index[channel] = count
            count += 1

        ax.plot(data[cn_to_index[curve['channels'][0]]].values, data[cn_to_index[curve['channels'][1]]].values,
                label=curve['name'])
    if plot_spec['log_x']:
        ax.set_xscale('log')
    if plot_spec['log_y']:
        ax.set_yscale('log')

    fig.suptitle(plot_spec['name'])

    # Shrink current axis's height by 10% on the bottom
    box = ax.get_position()
    ax.set_position([box.x0, box.y0 + box.height * 0.1,
                     box.width, box.height * 0.9])
    # add legend below
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.05),
              fancybox=True, shadow=True, ncol=5)
    return fig, ax


def run_task(task_name, include_plots=True, include_general_plots=False, plots=None, reports=None, **kwargs):
    """
    Utility function that runs the named task and returns the result

    :param task_name: the name of the task e.g. 'Time-Course' to run the timecourse task. See the
        basico.T for all the task names.
    :type task_name: str
    :param include_plots: boolean indicating whether to produce the plots associated with the task
    :type include_plots: bool
    :param include_general_plots: boolean indicating whether to produce the general plots (those not specified to
         a particular task)
    :type include_general_plots: bool
    :param plots: optional list of plot dataframes computed by the task
    :type plots: list[pandas.DataFrame] or None
    :param reports: optional list of report dataframes computed by the task
    :type reports: list[pandas.DataFrame] or None
    :return: Figures produced if `include_plots` is true, otherwise None
    """
    dm = model_io.get_model_from_dict_or_default(kwargs)

    report_defs = []
    plot_defs = []

    # find reports and plots
    for i in range(dm.getNumReportDefinitions()):
        spec = get_report_dict(i)
        if spec is None:
            continue
        if spec['task'] != task_name:
            continue
        report_defs.append(spec)

    for i in range(dm.getNumPlotSpecifications()):
        spec = get_plot_dict(i)
        if spec is None:
            continue
        if not spec['tasks']:
            if not include_general_plots:
                continue
        elif task_name not in spec['tasks']:
            continue

        plot_defs.append(spec)

    # create data handlers for reports and plots
    report_handlers = []
    if reports is not None and report_defs:
        for spec in report_defs:
            if spec['is_table']:
                # just go through the table entries and add them to handler
                pass
            else:
                # add header, body and footer separately
                pass

    plot_handlers = []
    for spec in plot_defs:
        dh = COPASI.CDataHandler()
        for curve in spec['curves']:
            if curve['activity'] != 'during':
                continue
            for channel in curve['channels']:
                dh.addDuringName(_get_registered_common_name(channel, dm))
            pass
        plot_handlers.append({
            'handler': dh,
            'spec': spec
        })

    # bail if no outputs
    if not report_handlers and not plot_handlers:
        logger.error('No reports or plots for the task {}'.format(task_name))
        return

    for handler in report_handlers + plot_handlers:
        dm.addInterface(handler['handler'])

    # run task
    task = dm.getTask(task_name)
    task.initializeRawWithOutputHandler(COPASI.CCopasiTask.OUTPUT_UI, dm)
    task.processRaw(True)
    task.restore()

    for handler in report_handlers + plot_handlers:
        dm.removeInterface(handler['handler'])

    # produce dataframes for reports and plots
    for handler in report_handlers:
        pass
    for handler in plot_handlers:
        data = []
        for i in range(handler['handler'].getNumRowsDuring()):
            data.append(handler['handler'].getNthRow(i))
        handler['df'] = pd.DataFrame(data)
        if plots is not None:
            plots.append(handler['df'])
    # produce plots
    if not include_plots:
        return

    figures = []
    for handler in plot_handlers:
        fig, ax = _create_plot(handler['spec'], handler['df'])
        figures.append((fig, ax))

    return figures


def get_copasi_messages(num_messages_before, filters=None):
    """ Returns error messages that occurred while initializing or running the simulation

    :param num_messages_before: number of messages before calling initialization or process
    :param filters: optional list of filter expressions of what messages to ignore
    :type filters: list of str or str or None

    :return: error messages in form of a string

    """
    messages = []
    if filters is None:
        filters = []
    if type(filters) == str:
        filters = [filters]
    while COPASI.CCopasiMessage.size() > num_messages_before:
        message = COPASI.CCopasiMessage.getLastMessage()
        skip = False
        for filter_text in filters:
            if filter_text in message.getText():
                skip = True
                break
        if not skip:
            messages.insert(0, message.getText())
    return "".join(messages)
