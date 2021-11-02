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
    model = kwargs.get('model', model_io.get_current_model())

    task = model.getTask('Scan')
    assert (isinstance(task, COPASI.CScanTask))

    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CScanProblem))

    data = get_scan_items(model=model, problem=problem)

    return pd.DataFrame(data=data)


def get_scan_items(**kwargs):
    model = kwargs.get('model', model_io.get_current_model())
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
    type = _scan_type_to_name(int_type)
    cn = item.getParameter('Object').getStringValue() if item.getParameter('Object') else None
    num_steps = item.getParameter('Number of steps').getIntValue() if item.getParameter('Number of steps') else None
    min = item.getParameter('Minimum').getDblValue() if item.getParameter('Minimum') else None
    max = item.getParameter('Maximum').getDblValue() if item.getParameter('Maximum') else None
    log = item.getParameter('log').getBoolValue() if item.getParameter('log') else None
    current = {
        'type': type,
        'num_steps': num_steps,
        'log': log,
        'min': min,
        'max': max,
    }

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
    """Returns the scan settings

        :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

        :return:
    """
    model = kwargs.get('model', model_io.get_current_model())
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


def add_scan_item(**kwargs):
    """Adds the scan item to the model

      :param kwargs: optional parameters
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)
      :return:
    """
    model = kwargs.get('model', model_io.get_current_model())
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
        copasi_item.getParameter('Values').setStringValue(values)
        copasi_item.getParameter('Use Values').setBoolValue(True)

    if 'use_values' in scan_item:
        copasi_item.getParameter('Use Values').setBoolValue(scan_item['use_values'])

    if 'min' in scan_item:
        copasi_item.getParameter('Minimum').setDblValue(scan_item['min'])

    if 'max' in scan_item:
        copasi_item.getParameter('Maximum').setDblValue(scan_item['max'])

    if 'log' in scan_item:
        copasi_item.getParameter('log').setBoolValue(scan_item['log'])

    if 'distribution' in scan_item:
        copasi_item.getParameter('Distribution type').setUIntValue(
            _name_to_scan_distribution_type(scan_item['distribution']))


def set_scan_items(scan_items, **kwargs):
    """Changes the scan items

    :param scan_items:
    :param kwargs: optional parameters
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    model = kwargs.get('model', model_io.get_current_model())
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
        -  scan_items: a list of scan items
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return:
    """
    model = kwargs.get('model', model_io.get_current_model())
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

    :param kwargs:
    :return:
    """
    model = kwargs.get('model', model_io.get_current_model())

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
