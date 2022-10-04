"""Utility functions for dealing with scan tasks

While usually it is easier to encode scan functionality directly in python code, the utility methods here
make it easy to set up scan tasks as supported by COPASI directly. That way they can be carried out from the
command line version of COPASI, or from the graphical user interface.

"""
import logging

import COPASI
import pandas as pd

import basico
from . import model_io


def _scan_type_to_name(type):
    names = {
        COPASI.CScanProblem.SCAN_LINEAR: 'scan',
        COPASI.CScanProblem.SCAN_REPEAT: 'repeat',
        COPASI.CScanProblem.SCAN_RANDOM: 'random',
    }
    return names.get(type, 'scan')


def _name_to_scan_type(name):
    types = {
        'scan': COPASI.CScanProblem.SCAN_LINEAR,
        'repeat': COPASI.CScanProblem.SCAN_REPEAT,
        'random': COPASI.CScanProblem.SCAN_RANDOM,
    }
    return types.get(name, COPASI.CScanProblem.SCAN_LINEAR)


def _scan_distribution_type_to_name(type):
    names = {
        0: 'uniform',
        1: 'normal',
        2: 'poisson',
        3: 'gamma',
    }
    return names.get(type, 'uniform')


def _name_to_scan_distribution_type(name):
    values = {
        'uniform': 0,
        'normal': 1,
        'poisson': 2,
        'gamma': 3,
    }
    return values.get(name, 0)


def get_scan_items_frame(**kwargs):
    """Returns all the scan items as pandas DataFrame

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: data frame of scan items
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    task = model.getTask('Scan')
    assert (isinstance(task, COPASI.CScanTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CScanProblem))

    data = get_scan_items(model=model, problem=problem)

    return pd.DataFrame(data=data)


def get_scan_items(**kwargs):
    """Retrieves the scan items specified on the scan task:

       >>> get_scan_items()
       [
          {
            'type': 'scan',
            'num_steps': 10,
            'log': False,
            'min': 0.5,
            'max': 2.0,
            'item': '(R1).k1',
          }
       ]

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: array of dictionary with the scan items specified
    :rtype: [{}]
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    problem = kwargs.get('problem', model.getTask('Scan').getProblem())

    data = []
    for i in range(problem.getNumberOfScanItems()):
        item = problem.getScanItem(i)
        current = _scan_item_to_dict(item, model)
        data.append(current)
    return data


def _scan_item_to_dict(item, model=None):
    if model is None:
        model = basico.get_current_model()

    if isinstance(item, int):
        problem = model.getTask('Scan').getProblem()
        if item >= problem.getNumberOfScanItems():
            logging.error('No Scan item: {0}'.format(item))
            return None
        item = problem.getScanItem(item)

    assert (isinstance(item, COPASI.CCopasiParameter))
    int_type = item.getParameter('Type').getIntValue()
    type_name = _scan_type_to_name(int_type)
    cn = item.getParameter('Object').getCNValue().getString() if item.getParameter('Object') else None
    num_steps = item.getParameter('Number of steps').getIntValue() if item.getParameter('Number of steps') else None
    min_val = item.getParameter('Minimum').getDblValue() if item.getParameter('Minimum') else None
    max_val = item.getParameter('Maximum').getDblValue() if item.getParameter('Maximum') else None
    log = item.getParameter('log').getBoolValue() if item.getParameter('log') else None
    current = {
        'type': type_name,
        'num_steps': num_steps,
    }

    if log is not None:
        current['log'] = log

    if min_val is not None:
        current['min'] = min_val

    if max_val is not None:
        current['max'] = max_val

    if int_type == COPASI.CScanProblem.SCAN_RANDOM:
        dist = _scan_distribution_type_to_name(item.getParameter('Distribution type').getUIntValue()) \
            if item.getParameter('Distribution type') else None
        current['distribution'] = dist

    elif int_type == COPASI.CScanProblem.SCAN_LINEAR:
        values = item.getParameter('Values').getStringValue() if item.getParameter('Values') else None
        if values:
            values = values.replace(',', ' ')
            values = values.split(' ')
            values = [float(v) for v in values]
        use_values = item.getParameter('Use Values').getBoolValue() if item.getParameter('Use Values') else None
        current['values'] = values
        current['use_values'] = use_values

    if cn:
        obj = model.getObject(COPASI.CCommonName(cn))
        if not obj:
            logging.warning('missing object in scan item: {0}'.format(cn))
        else:
            current['item'] = obj.getObjectDisplayName()
        current['cn'] = cn
    return current


def get_scan_settings(**kwargs):
    """Returns the scan settings as dictionary

        >>> get_scan_settings()
        {
            'update_model': False,
            'scheduled': False,
            'subtask': 'Steady-State',
            'output_during_subtask': False,
            'continue_from_current_state': False,
            'continue_on_error': False,
            'scan_items': [ ... ]
        }

        :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

        :return: dictionary of scan settings
        :rtype: {}
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    task = model.getTask('Scan')
    assert (isinstance(task, COPASI.CScanTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CScanProblem))

    s = {
        'update_model': task.isUpdateModel(),
        'scheduled': task.isScheduled(),
        'subtask': basico.T.from_enum(problem.getSubtask()),
        'output_during_subtask': problem.getOutputInSubtask(),
        'continue_from_current_state': problem.getContinueFromCurrentState(),
        'continue_on_error': problem.getContinueOnError(),
        'scan_items': get_scan_items(model=model, problem=problem)
    }

    return s


def _set_parameter_from_value(parameter, value):
    """Utility function that sets the parameter value

    :param parameter: copasi parameter to change
    :type parameter: COPASI.CCopasiParameter

    :param value: the value to set will be cast to the appropriate type
    :type value: Union[str, float, int, bool]

    """
    if parameter is None:
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_DOUBLE:
        parameter.setDblValue(float(value))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_INT:
        parameter.setIntValue(int(value))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_BOOL:
        parameter.setBoolValue(bool(value))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_STRING \
            or parameter.getType() == COPASI.CCopasiParameter.Type_EXPRESSION:
        parameter.setStringValue(str(value))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_CN:
        parameter.setCNValue(COPASI.CCommonName(str(value)))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_FILE:
        parameter.setFileValue(str(value))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_UDOUBLE:
        parameter.setUDblValue(float(value))
        return

    if parameter.getType() == COPASI.CCopasiParameter.Type_UINT:
        parameter.setUIntValue(int(value))
        return


def _set_parameter_from_dict(parameter, values_dict, key):
    """Utility function that sets the given copasi parameter

    :param parameter: copasi parameter to change
    :type parameter: COPASI.CCopasiParameter
    :param values_dict: dictionary of values
    :param key: key that might be in the dictionary
    :return: None
    """
    if not parameter:
        return

    if key not in values_dict:
        return

    _set_parameter_from_value(parameter, values_dict[key])


def add_scan_item(**kwargs):
    """Adds the scan item to the model

      :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

        - | `type (str)`: the type for the scan item can be one of `scan`,
          | `repeat` or `random`. If not specified `scan` will be used.

        - | `cn (str)`: the cn of the element to use in the scan item (use when
          | no suitable display names for the item you are interested in exist)
          | if you specify cn, don't use the `item` optional paramter

        - | `item (str)`: the display name of the item you want to use, for example
          | `[Signal]_0` for the initial concentration of species `Signal`, or
          | `(r1).k` for the local parameter `k` of reaction `r1`.

        - | `values(str or [float])`: if you want to scan over specific values,
          | rather than a range, specify them here e.g.: `[0.1, 0.5, 1, 2]`. Using
          | this parameter also sets `use_values` to `True`

        - | `use_values (bool)`: indicates that the values specified should be used
          | rather than the min / max range

        - | `num_steps (int)`: the number of steps in the range of [min, max] or the
          | number of repeats.

        - | `min (float)`: minimum value for the range or first distribution parameter

        - | `max (float)`: maximum value for the range, or the 2nd distributon parameter

        - | `log (bool)`: boolean indicating that the range should be used logarithmically.

        - | `distribution (str)`: one of `uniform`, `normal`, `poisson` or `gamma`

      :return:
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    problem = kwargs.get('problem', model.getTask('Scan').getProblem())
    assert (isinstance(problem, COPASI.CScanProblem))

    scan_item = kwargs.get('scan_item', kwargs)

    obj = None
    if 'cn' in scan_item:
        obj = model.getObject(COPASI.CCommonName(scan_item['cn']))

    if 'item' in scan_item:
        obj = model.findObjectByDisplayName(scan_item['item'])

    copasi_item = problem.addScanItem(_name_to_scan_type(scan_item['type'] if 'type' in scan_item else 'scan'),
                                      scan_item['num_steps'] if 'num_steps' in scan_item else 0,
                                      obj)
    assert (isinstance(copasi_item, COPASI.CCopasiParameterGroup))

    if 'values' in scan_item:
        values = scan_item['values']
        if isinstance(values, list):
            values = [str(v) for v in values]
            values = ' '.join(values)

        _set_parameter_from_value(copasi_item.getParameter('Values'), values)
        _set_parameter_from_value(copasi_item.getParameter('Use Values'), True)

    _set_parameter_from_dict(copasi_item.getParameter('Use Values'), scan_item, 'use_values')
    _set_parameter_from_dict(copasi_item.getParameter('Minimum'), scan_item, 'min')
    _set_parameter_from_dict(copasi_item.getParameter('Maximum'), scan_item, 'max')
    _set_parameter_from_dict(copasi_item.getParameter('log'), scan_item, 'log')

    if 'distribution' in scan_item:
        _set_parameter_from_value(copasi_item.getParameter('Distribution type'),
                                  _name_to_scan_distribution_type(scan_item['distribution']))


def set_scan_items(scan_items, **kwargs):
    """Replaces the scan items in the task, with the scan items passed in

       If you just wanted to change a specific entry, you could would retrieve
       the current set of scan items, make the change and then set them again:

       >>> scan_items = get_scan_items()

       the list of scan items is returned as array of dictionary items, and
       can be freely modified (say change the number of
       steps of the first item to a new value), or add new entries, remove some

       >>> scan_items[0]['num_steps'] = 20

       Finally a call to scan items, will replace the ones in the model with the
       ones from the array.

       >>> set_scan_items(scan_items)

    :param scan_items: list of dictionaries as returned by :func:`.get_scan_items`.
    :type scan_items: [{}]

    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    problem = kwargs.get('problem', model.getTask('Scan').getProblem())
    assert (isinstance(problem, COPASI.CScanProblem))

    if isinstance(scan_items, dict):
        scan_items = [scan_items]

    problem.clearScanItems()

    for scan_item in scan_items:
        add_scan_item(scan_item=scan_item, model=model, problem=problem)


def set_scan_settings(**kwargs):
    """Changes the scan settings

    :param kwargs: optional parameters

        -  settings: dictionary with the scan settings
        -  subtask: sub task name
        -  output_during_subtask: boolean, indicating whether ouput should be collected during the subtask execution
        -  continue_from_current_state: boolean indicating, whether the subtask should be reset to initial values (False)
                or not  (True)
        -  continue_on_error: boolean indicating, whether executions should continue, in case one subtask execution failed
           (True) or not.
        -  scan_items: a list of scan items see :func:`.set_scan_items`
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    task = model.getTask('Scan')
    assert (isinstance(task, COPASI.CScanTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CScanProblem))

    settings = kwargs.get('settings', kwargs)

    if 'update_model' in settings:
        task.setUpdateModel(settings['update_model'])

    if 'scheduled' in settings:
        task.setScheduled(settings['scheduled'])

    if 'subtask' in settings:
        problem.setSubtask(basico.T.to_enum(settings['subtask']))

    if 'output_during_subtask' in settings:
        problem.setOutputInSubtask(settings['output_during_subtask'])

    if 'continue_from_current_state' in settings:
        problem.setContinueFromCurrentState(settings['continue_from_current_state'])

    if 'continue_on_error' in settings:
        problem.setContinueOnError(settings['continue_on_error'])

    if 'scan_items' in settings:
        set_scan_items(settings['scan_items'], model=model, problem=problem)


def run_scan(**kwargs):
    """Runs the scan task

    :param kwargs: optional parameters

        - | settings: optional dictionary with the scan settings

        - | scan_items: a list of scan items see :func:`.set_scan_items`

        - | output ([(str)]): optional list of cns or display names, of elements
          | to collect in the scan.

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None if output is not specified, otherwise the collected output as dataframe.
    :rtype: None or pd.DataFrame
    """
    model = model_io.get_model_from_dict_or_default(kwargs)

    if 'settings' in kwargs:
        set_scan_settings(settings=kwargs['settings'], model=model)

    if 'scan_items' in kwargs:
        set_scan_items(kwargs['scan_items'], model=model)

    dh = None
    cols = []
    if 'output' in kwargs:
        dh, cols = basico.task_timecourse.create_data_handler(kwargs['output'], after=kwargs['output'], model=model)
        model.addInterface(dh)

    task = model.getTask('Scan')
    assert (isinstance(task, COPASI.CScanTask))

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logging.warning("Couldn't initialize scan task")

    use_initial_values = kwargs.get('use_initial_values', True)
    if not task.processRaw(use_initial_values):
        logging.warning("Couldn't process scan task")

    if dh:
        model.removeInterface(dh)
        data = basico.task_timecourse.get_data_from_data_handler(dh, cols)
        del dh
        dh = None
        return data

    return None
