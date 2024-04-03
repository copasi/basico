""" Utility functions for generating profile likelihood plots

   This module contains utility functions for generating scans
   around the current solution of a parameter estimation. The method
   is described in detail in:

   Schaber J (2012) Easy parameter identifiability analysis with COPASI.
   Biosystems 110:183–185 http://dx.doi.org/10.1016/j.biosystems.2012.09.003

"""
import math

import basico
import numpy as np
import pandas as pd
import scipy.stats as stats
import sys
import os

from basico.processing import process_files
import tempfile
import logging
import shutil
import COPASI
import yaml

try:
    from . import model_io
except ImportError:
    from basico import model_io

COPASI_SE = 'CopasiSE'
logger = logging.getLogger(__name__)


def _get_scan_files(data_dir):
    """Collects any of the scans generated from the given data directory

    :param data_dir: the data directory
    :return: list of absolute filenames from the directory
    """
    files = []
    for filename in os.listdir(data_dir):
        if not (filename.endswith('_update_high.cps') or filename.endswith('_update_low.cps')):
            continue
        files.append(os.path.abspath(os.path.join(data_dir, filename)))
    return files


def process_dir(data_dir, pool_size=4, copasi_se=COPASI_SE, max_time=None):
    """Executes all generated copasi files from the given directory in a multiprocessing pool

    :param data_dir: directory containing high / low files generated
    :param pool_size: pool size for the multiprocessing pool that will be created (defaults to 4)
    :param copasi_se: path to the copasi SE executable to execute
    :param max_time: maximum time to allow for the execution of each file in seconds (defaults to None for no maximum
    """
    files = _get_scan_files(data_dir)
    process_files(files, pool_size, copasi_se, max_time)


def plot_data(data_dir, problem_size=None, **kwargs):
    """Plots all files from the given data directory

    :param data_dir: data directory containing the report files

    :param problem_size: tuple containing the number of parameters (m) and number of data points (n)

    :param kwargs: additional keyword arguments to pass to the plot function

        - scale_mode: scale_mode to use for the y-axis (defaults to None for automatic scaling). If scale_mode
          is a float, we compute a scale between objective value and threshold with the given steps.
          If scale_mode is a dict, we use the given dict as the scale for `set_ylim`.

        - obj_val: objective value to use for the plot (defaults to None for using the value from the info file)

        - alpha: alpha value to use for the calculation of thresholds (defaults to 0.05)

        - thresholds: list of thresholds to calculate and display. if not specified, we plot the thresholds
                      for the 95% interval, and 68% interval according to obj*(1+chi2/(n-m)). Valid values are:

            - 'default_68: threshold for 68%
            - 'default_95: threshold for 95%
            - 'schaber_chi2_1p': threshold for one parameter according to Schaber using chi2 with 1 parameter
            - 'schaber_chi2_p': threshold for one parameter according to Schaber using chi2 with p parameters
            - 'schaber_fratio_p': threshold for one parameter according to Schaber using fratio with p parameters
            - `donaldson_fratio_1p`: threshold for one parameter according to Donaldson using fratio with 1 parameter

    :return: list of Axes created
    :rtype: List[matplotlib.axes.Axes]
    """

    if os.path.exists(os.path.join(data_dir, '.info.yaml')):
        with open(os.path.join(data_dir, '.info.yaml'), 'r', encoding='utf8') as f:
            info = yaml.safe_load(f)
        param_sds = info.get('param_sds', {})
    else:
        info = None
        param_sds = {}

    file_map = _get_report_filemap(data_dir)
    plots = []
    first = True
    for entry in file_map:
        df, obj_val, param_val = _combine_files(file_map[entry])
        if 'obj_val' in kwargs:
            obj_val = kwargs['obj_val']
        elif info is not None:
            obj_val = info['obj']

        if not problem_size and info is not None:
            problem_size = (info['num_params'], info['num_data'])
        param_name = df.index.name
        ax = df.plot(legend=False)
        ax.set_ylabel('obj')
        ax.axvline(param_val, color='silver', ls='dotted')
        if param_name in param_sds:
            ax.axvline(param_val + param_sds[param_name], color='lightblue', ls='dotted')
            ax.axvline(param_val + 2 * param_sds[param_name], color='lavender', ls='dotted')
            ax.axvline(param_val - param_sds[param_name], color='lightblue', ls='dotted')
            ax.axvline(param_val - 2 * param_sds[param_name], color='lavender', ls='dotted')
        ax.axhline(obj_val, color='silver', ls='dotted')
        thresholds_to_plot = kwargs.get('thresholds', ['default_95', 'default_68'])
        if problem_size:
            m, n = problem_size
            scale_mode = kwargs.get('scale_mode', 3)
            log_level = kwargs.get('log_level', logging.INFO)
            if type(log_level) is str:
                log_level = logger.getLevelName(log_level.upper())

            if scale_mode is not None:
                if type(scale_mode) is float:
                    scale = _make_y_axis(obj_val, threshold, scale_mode)
                    ax.set_ylim(top=scale[-1], bottom=scale[0])

                if type(scale_mode) is dict:
                    ax.set_ylim(**scale_mode)

            # threshold for COPASI chi2 alpha is 68% (sahle)
            if 'default_68' in thresholds_to_plot:
                c0 = stats.chi2.isf(0.32, 1, loc=0, scale=1)
                threshold = obj_val * (1 + c0/(n-m))
                if first:
                    logger.log(log_level, f'blue, dashed : COPASI threshold {threshold} for alpha=0.32')
                ax.axhline(threshold, color='blue', ls='dashed')

            # for remaining thresholds we use alpha = 0.05 unless otherwise specified
            alpha = kwargs.get('alpha', 0.05)

            # threshold for COPASI chi2 alpha is 95% (sahle)
            if 'default_95' in thresholds_to_plot:
                c0 = stats.chi2.isf(alpha, 1, loc=0, scale=1)
                threshold = obj_val * (1 + c0/(n-m))
                if first:
                    logger.log(log_level, f'blue, dotted : COPASI threshold {threshold} for alpha={alpha}')
                ax.axhline(threshold, color='blue', ls='dotted')

            # estimating chi-square value fitting one parameter (schaber)
            if 'schaber_chi2_1p' in thresholds_to_plot:
                c1 = stats.chi2.isf(alpha, 1, loc=0, scale=1)
                t1 = obj_val * math.exp(c1 / n)
                if first:
                    logger.log(log_level, f'green, dashed: Schaber threshold {t1} for alpha={alpha}, 1 parameter, chi2')
                ax.axhline(y=t1, color='green', linestyle='dashed')

            # estimating chi-square value fitting m parameters (schaber)
            if 'schaber_chi2_p' in thresholds_to_plot:
                c2 = stats.chi2.isf(alpha, m, loc=0, scale=1)
                t2 = obj_val * math.exp(c2 / n)
                if first:
                    logger.log(log_level, f'green, dotted: Schaber threshold {t2} for alpha={alpha}, m parameter, chi2')
                ax.axhline(y=t2, color='green', linestyle='dotted')

            # estimating fratio value fitting m parameters (schaber)
            if 'schaber_fratio_p' in thresholds_to_plot:
                c3 = stats.f.isf(alpha, m, n-m, loc=0, scale=1)
                t3 = obj_val * (1 + (m / (n-m)) * c3)
                if first:
                    logger.log(log_level, f'red: Schaber threshold {t3} for alpha={alpha}, m parameter, Fratio')
                ax.axhline(y=t3, color='red', linestyle='dotted')

            # estimating chi-square value fitting 1 parameter (donaldson)
            if 'donaldson_fratio_1p' in thresholds_to_plot:
                c4 = stats.f.isf(alpha, 1, n-m, loc=0, scale=1)
                t4 = obj_val * (1 + c4/(n-m))
                if first:
                    logger.log(log_level, f'orange: Donaldson threshold {t4} for alpha={alpha}, 1 parameter, Fratio')
                ax.axhline(y=t4, color='orange', linestyle='dashed')

            first = False

        ax.set_title(f'{df.index.name} obj={obj_val}, value={param_val}')
        plots.append(ax)

    return plots


def _make_y_axis(y_min, y_max, ticks=10):
    """

    This routine creates the Y axis values for a graph.

    Calculate Min amd Max graphical labels and graph
    increments.  The number of ticks defaults to
    10 which is the SUGGESTED value.  Any tick value
    entered is used as a suggested value which is
    adjusted to be a 'pretty' value.

    Output will be an array of the Y axis values that
    encompass the Y values.

    translated from this SO post:
    https://stackoverflow.com/questions/326679/choosing-an-attractive-linear-scale-for-a-graphs-y-axis/9007526#9007526

    :param y_min: min value of y-axis
    :param y_max: max value of y-axis
    :param ticks: number of ticks to return (defaults to 10)
    :return: array with the suggested scale
    """

    result = []

    # If y_min and y_max are identical, then
    # adjust the y_min and y_max values to actually
    # make a graph. Also avoids division by zero errors.

    if y_min == y_max:
        y_min = y_min - 10
        # some small value
        y_max = y_max + 10

    # Determine Range
    y_range = y_max - y_min

    # Adjust ticks if needed
    if ticks < 2:
        ticks = 2
    else:
        if ticks > 2:
            ticks -= 2

    # Get raw step value
    temp_step = y_range / ticks

    # Calculate pretty step value
    mag = math.floor(np.log10(temp_step))
    mag_pow = math.pow(10, mag)
    mag_msd = int(temp_step / mag_pow + 0.5)
    step_size = mag_msd * mag_pow

    # build Y label array.
    # Lower and upper bounds calculations
    lb = step_size * math.floor(y_min / step_size)
    ub = step_size * math.ceil(y_max / step_size)

    # Build array
    val_ = lb
    while True:
        result.append(val_)
        val_ += step_size
        if val_ > ub:
            break

    return result


def _combine_files(report_files):
    df = None
    for filename in report_files:
        if df is None:
            df = _get_data_from_file(filename)
        else:
            df = pd.concat([df, _get_data_from_file(filename)])
    df.sort_index(inplace=True, axis=0)
    param_val = df[['TaskList[Parameter Estimation].(Problem)Parameter Estimation.Best Value']].idxmin().values[0]
    obj_val = df[['TaskList[Parameter Estimation].(Problem)Parameter Estimation.Best Value']].min().values[0]
    return df, obj_val, param_val


def _get_report_filemap(data_dir):
    """Returns the map of report files from the given data director

    :param data_dir: the directory to search for the update report files.
    :return: a map of id, and list of files for it
    :rtype: Dict[str, List[str]]
    """
    file_map = {}
    for filename in os.listdir(data_dir):
        if not (filename.endswith('_update_high.txt') or filename.endswith('_update_low.txt')):
            continue
        new_name = filename
        for replacement in [('__', '_'),
                            ('_update_high.txt', ''),
                            ('_update_low.txt', '')]:
            new_name = new_name.replace(replacement[0], replacement[1])
        pos = new_name.rfind('_')
        if pos < 0:
            continue

        index = new_name[pos + 1:]
        if index not in file_map:
            file_map[index] = []
        file_map[index].append(os.path.abspath(os.path.join(data_dir, filename)))
    return file_map


def _get_data_from_file(filename):
    """Returns the data from the given file als pandas dataframe

    :param filename: filename to report file
    :return: the pandas dataframe for the file
    :rtype: pd.DataFrame
    """
    df = pd.read_csv(filename, sep='\t', header=0)
    cols = df.columns.to_list()
    if 'Time' in cols:
        df = df.drop(labels=['Time'], axis=1, errors='ignore')
    df = df.set_index(df.columns[0])
    return df


_Problem = None
_Task = None
Arguments = {
    "lower_adjustment": '-50%',
    "upper_adjustment": '+50%',
    "modulation": 0.01,
    "tolerance": 1e-06,
    "iterations": 50,
    "scan_interval": 40,
    "disable_plots": True,
    "disable_tasks": True,
    "use_hooke": False,
    "prefix": "out_",
    "filename": ""
}
_DataModel = None


def _get_time_course():
    for index in range(_DataModel.getTaskList().size()):

        task = _DataModel.getTask(index)
        if isinstance(task, COPASI.CTrajectoryTask):
            return task

    return None


def _get_scan():
    for index in range(_DataModel.getTaskList().size()):

        task = _DataModel.getTask(index)
        if isinstance(task, COPASI.CScanTask):
            return task

    return None


def _get_fit_task():
    for index in range(_DataModel.getTaskList().size()):

        task = _DataModel.getTask(index)
        if isinstance(task, COPASI.CFitTask):
            return task

    return None


def _convert_opt_items(opt_items):
    opt_item_list = []
    for index in range(len(opt_items)):
        obj = _DataModel.getObject(COPASI.CCommonName(opt_items[index].getObjectCN()))
        opt_item_list.append(
            {
                'cn': opt_items[index].getObjectCN().getString(),
                'start_value': opt_items[index].getStartValue(),
                'lower_bound': opt_items[index].getLowerBound(),
                'upper_bound': opt_items[index].getUpperBound(),
                'index': index,
                'name': obj.getObjectDisplayName() if obj is not None else '',
            }
        )

    return opt_item_list


def _generate_scan_for_item(item, index, data_dir, update_model=False, lower=False, **kwargs):
    global _DataModel
    _DataModel.loadModel(Arguments["filename"])
    if Arguments["disable_plots"]:

        logger.info("... Disable other Plots")
        num = _DataModel.getPlotDefinitionList().size()
        for index1 in range(num):
            _DataModel.getPlotSpecification(index1).setActive(False)

    if Arguments["disable_tasks"]:
        logger.info("... Disable other Tasks")
        num = _DataModel.getTaskList().size()
        for index2 in range(num):
            _DataModel.getTask(index2).setScheduled(False)

    _get_time_course().getMethod().getParameter("Relative Tolerance").setDblValue(1E-09)
    fit_task = _get_fit_task()
    fit_task.setUpdateModel(update_model)

    if Arguments["use_hooke"]:
        fit_task.setMethodType(COPASI.CTaskEnum.Method_HookeJeeves)
        fit_task.getMethod().getParameter("Iteration Limit").setIntValue(Arguments["iterations"])
        fit_task.getMethod().getParameter("Tolerance").setDblValue(Arguments["tolerance"])
    else:
        fit_task.setMethodType(COPASI.CTaskEnum.Method_LevenbergMarquardt)
        fit_task.getMethod().getParameter("Iteration Limit").setIntValue(Arguments["iterations"])
        fit_task.getMethod().getParameter("Modulation").setDblValue(Arguments["modulation"])
        fit_task.getMethod().getParameter("Tolerance").setDblValue(Arguments["tolerance"])

    problem1 = fit_task.getProblem()
    problem1.setCalculateStatistics(False)
    logger.debug("... Remove OptItem")
    problem1.removeOptItem(item["index"])
    logger.debug("... Generate Scan")
    scan_task = _get_scan()
    scan_task.setScheduled(True)
    problem2 = scan_task.getProblem()
    problem2.setSubtask(COPASI.CTaskEnum.Task_parameterFitting)
    problem2.setContinueFromCurrentState(False)
    problem2.setOutputInSubtask(False)
    problem2.clearScanItems()
    problem2.addScanItem(1, Arguments["scan_interval"])
    scan_item = problem2.getScanItem(0)
    scan_item.getParameter("Object").setCNValue(COPASI.CRegisteredCommonName(item["cn"]))

    start_value = item["start_value"]
    param_sd = kwargs.get('param_sds', {}).get(item["name"], None)
    lower_value = _adjust_value(start_value, Arguments["lower_adjustment"],
                                item['lower_bound'], param_sd)
    upper_value = _adjust_value(start_value, Arguments["upper_adjustment"],
                                item['upper_bound'], param_sd)

    if not update_model:
        middle = "_noupdate"
        scan_item.getParameter("Maximum").setDblValue(upper_value)
        scan_item.getParameter("Minimum").setDblValue(lower_value)
    elif lower:
        middle = "_update_low"
        scan_item.getParameter("Minimum").setDblValue(start_value)
        scan_item.getParameter("Maximum").setDblValue(lower_value)
    else:
        middle = "_update_high"
        scan_item.getParameter("Maximum").setDblValue(upper_value)
        scan_item.getParameter("Minimum").setDblValue(start_value)

    scan_task.updateMatrices()
    logger.debug("... Generate Report")
    COPASI.COutputAssistant.createDefaultOutput(1251, scan_task, _DataModel)
    report_file = os.path.abspath("{0}/{1}_{2:05d}_{3}.txt".format(data_dir, Arguments['prefix'], index, middle))
    logger.debug(f"   Report target: '{report_file}'.")
    report = scan_task.getReport()
    report.setTarget(report_file)
    report.setAppend(False)
    report.setConfirmOverwrite(False)
    logger.debug("... Generate Plot")
    plot = COPASI.COutputAssistant.createDefaultOutput(251, scan_task, _DataModel)
    if plot is not None: 
        plot.setObjectName('{0} = {1}'.format('opt', start_value))
    out_file = os.path.abspath("{0}/{1}_{2:05d}_{3}.cps".format(data_dir, Arguments['prefix'], index, middle))
    logger.debug(f"Writing '{out_file}'.")
    _DataModel.saveModel(out_file, True)


def _adjust_value(value, adjustment, explicit=None, std_dev=None):
    """ adjusts the given value according to the multiplier

    :param value: the value to be adjusted

    :param adjustment: the adjustment to be made to the value
        adjustment is a float: the value will be adjusted to `value * adjustment`
        adjustment is a string starting with '+', the value will be adjusted to `value + value * adjustment`
        adjustment contains a '%', the adjustment value is adjusted by dividing by 100
        adjustment starts with '=', the value will be adjusted to `adjustment`
        adjustment is None, or 'default': the explicit value given will be used

    :param explicit: the explicit value to be used if adjustment is None or 'default'

    :return: the adjusted value
    """

    if not adjustment or adjustment == 'default':
        return float(explicit)

    if type(adjustment) is str and adjustment.endswith('SD') and std_dev is not None:
        return value + float(adjustment[:-2]) * std_dev

    if type(adjustment) is str:
        is_additive = adjustment.startswith('+')
        if is_additive:
            adjustment = adjustment[1:]

        is_declarative = adjustment.startswith('=')

        if is_declarative:
            adjustment = adjustment[1:]

        has_percent = '%' in adjustment
        if has_percent:
            adjustment = float(adjustment.rstrip('%')) / 100.0
            adjustment *= value

        adjustment = float(adjustment)
        if (adjustment < 0 or is_additive) and not is_declarative:
            return value + adjustment

        if has_percent or is_declarative:
            return adjustment

    return value * adjustment


def get_profiles_for_model(data_dir=None, **kwargs):
    """ Convenience function, combining the steps of preparing, running, and plotting

    :param data_dir: optional data directory to use, if not specified a temp directory will be used,
                     and deleted afterwards
    :param kwargs: optional parameters to use, all options from :func:`.prepare_files` and
                   :func:`.process_dir` can be specified.
    :return: the plot axis
    """
    delete_files = False

    if data_dir is None:
        delete_files = True
        data_dir = tempfile.mkdtemp()

    model = basico.get_current_model()
    old_filename = model.getFileName()
    filename = os.path.join(data_dir, 'model.cps')
    basico.save_model_and_data(filename)

    info = prepare_files(filename, data_dir, **kwargs)

    process_dir(data_dir,
                kwargs.get('pool_size', 4),
                kwargs.get('copasi_se', COPASI_SE),
                kwargs.get('max_time', None))

    result = plot_data(data_dir,
                       problem_size=(info['num_params'], info['num_data']),
                       **kwargs)
    if delete_files:
        shutil.rmtree(data_dir, ignore_errors=True)
    # restore old filename to ensure that relative files can still be found
    model.setFileName(old_filename)
    return result


def prepare_files(filename,
                  data_dir,
                  lower_adjustment='-50%',
                  upper_adjustment='+50%',
                  modulation=0.01,
                  tolerance=1e-06,
                  iterations=50,
                  scan_interval=40,
                  disable_plots=True,
                  disable_tasks=True,
                  use_hooke=False,
                  prefix="out_",
                  **kwargs):
    """Generates all files needed for the profile likelihood runs

    :param filename: filename of template copasi file. this file should already have a good fit, to be analyzed
    :param data_dir: directory in which the files will be generated
    :param lower_adjustment: adjustment of the current parameter value for the lower bound of the scan, this
           can be either a double multiplier, or a string with a percentage. By default, half of the current value
           will be substracted from it '-50%'. To take the current lower bound value as lower bound, use 'default'.
    :param upper_adjustment: adjustment of the current parameter value for the upper bound of the scan, this
           can be either a double multiplier, or a string with a percentage. By default, half of the current value
           will be added from it '+50%'. To take the current upper bound value as upper bound, use 'default'.
    :param modulation: In case Levenberg Marquardt is used, this is the modulation parameter, defaults to 0.01
    :param tolerance: optimization tolerance, defaults to 1e-6
    :param iterations: number of iterations to perform, defaults to 50
    :param scan_interval: number of scan intervals in each direction, defaults to 40, which means that 80 total
           optimization runs will be taken by default
    :param disable_plots: boolean, indicating whether other plots in the model should be disabled (defaults to True)
    :param disable_tasks: boolean, indicating whether other tasks in the model should be disabled (defaults to True)
    :param use_hooke: boolean indicating whether Hooks & Jeeves should be used (if True), or Levenberg Marquardt
           (if False) defaults to False.
    :param prefix: Prefix to be used for the files that will be generated in the `data_dir`, Defaults to 'out_'
    :return: dictionary, containing the number of parameters, the number of data sets, and the current objective value
    :rtype: dict
    """
    # remove old warnings
    COPASI.CCopasiMessage.clearDeque()

    global Arguments
    Arguments = locals()

    global _DataModel
    _DataModel = COPASI.CRootContainer.addDatamodel()
    if not _DataModel.loadModel(filename):
        logger.error("Could not load model")
        logger.error(COPASI.CCopasiMessage.getAllMessageText())
        sys.exit(2)

    logger.info(f"Copy Experimental Data to: {data_dir}")

    if os.path.abspath(filename) != os.path.abspath(os.path.join(data_dir, 'model.cps')):
        # copy files if needed
        basico.save_model_and_data(os.path.join(data_dir, 'original.cps'), model=_DataModel)
        _DataModel.loadModel(os.path.join(data_dir, 'original.cps'))

    # convert experiments to relative paths, so they'll work in cluster environment
    experiments = basico.save_experiments_to_dict(model=_DataModel)
    basico.load_experiments_from_dict(experiments, model=_DataModel)
    experiments_verify = basico.save_experiments_to_dict(model=_DataModel)

    global _Task
    _Task = _get_fit_task()
    if _Task is None:
        logger.error("No Fit Task.")
        return

    if not data_dir:
        data_dir = os.path.abspath(os.path.dirname(Arguments['prefix']))
    if not os.path.exists(data_dir):
        os.makedirs(data_dir, exist_ok=True)

    global _Problem
    _Problem = _Task.getProblem()

    num_params = _Problem.getOptItemSize()
    exp_set = _Problem.getExperimentSet()
    exp_set.compile(_DataModel.getModel().getMathContainer())
    num_data = exp_set.getDataPointCount()

    if 'obj' in kwargs:
        current_obj = kwargs['obj']
        param_sds = kwargs.get('param_sds', {})
    else:
        basico.run_parameter_estimation(method=basico.PE.CURRENT_SOLUTION, model=_DataModel)
        statistic = basico.get_fit_statistic(model=_DataModel, include_parameters=True)
        current_obj = statistic['obj']
        param_sds = {}
        for param in statistic['parameters']:
            param_sds[param['name']] = param['std_dev']

    info = {
        'num_params': num_params,
        'num_data': num_data,
        'obj': current_obj,
        'param_sds': param_sds,
    }

    with open(os.path.join(data_dir, '.info.yaml'), 'w', encoding='utf8') as f:
        yaml.dump(info, f)

    opt_item_list = _convert_opt_items(_Problem.getOptItemList())
    logger.debug(f"Have: {len(opt_item_list)} optItems")
    for index in range(len(opt_item_list)):
        logger.debug(f"Handling: {opt_item_list[index]['cn']}")
        # _generate_scan_for_item(optItemList[index], index, data_dir)
        _generate_scan_for_item(opt_item_list[index], index, data_dir, True, True, param_sds=param_sds)
        _generate_scan_for_item(opt_item_list[index], index, data_dir, True, param_sds=param_sds)

    # free the data model
    COPASI.CRootContainer.removeDatamodel(_DataModel)
    _DataModel = None
    return info


def printUsageAndExit():
    print("This program generates scans over each parameter of a parameter estimation. ")
    print()
    print("Usage: -f | --file <filename>")
    print("       -l | --lower <adjustment for current parameter value>")
    print("       -u | --upper <adjustment for current parameter value>")
    print("       -m | --modulation <levenberg marquardt modulation>")
    print("       -e | --tolerance <levenberg marquardt tolerance>")
    print("       -i | --iteration <iteration for parameter estimation run>")
    print("       -s | --steps <numer of steps for the scan>")
    print("       -o | --output-prefix <prefix for output files and reports>")
    print("       -p | --dont-disable-plots")
    print("       -t | --dont-disable-other-tasks")
    print("       -h | --help | /?")
    print()
    sys.exit(0)


def printStatus():
    print(f"Filename          : {Arguments['filename']}")
    print(f"Lower Adjustment  : {Arguments['lower_adjustment']}")
    print(f"Upper Adjustment  : {Arguments['upper_adjustment']}")
    print(f"modulation        : {Arguments['modulation']}")
    print(f"LM Toleratnce     : {Arguments['tolerance']}")
    print(f"iterations        : {Arguments['iterations']}")
    print(f"Disable Plots     : {Arguments['disable_plots']}")
    print(f"Disable Tasks     : {Arguments['disable_tasks']}")
    print(f"Output prefix     : {Arguments['prefix']}")
    print(f"Use Hooke & Jeeves: {Arguments['use_hooke']}")
    print()


def parse_args(args):
    global Arguments
    num_args = len(args)
    for index in range(num_args):
        lowerInvariant = args[index].strip().lower()
        s = args[index + 1] if index + 1 < num_args else None
        flag = s is not None
        if flag and (lowerInvariant == "-f" or lowerInvariant == "--file"):
            Arguments["filename"] = s
        elif flag and (lowerInvariant == "-o" or lowerInvariant == "--output-prefix"):
            Arguments["prefix"] = s
        elif flag and (lowerInvariant == "-l" or lowerInvariant == "--lower"):
            Arguments["lower_adjustment"] = float(s)
        elif flag and (lowerInvariant == "-u" or lowerInvariant == "--upper"):
            Arguments["upper_adjustment"] = float(s)
        elif flag and (lowerInvariant == "-m" or lowerInvariant == "--modulation"):
            Arguments["modulation"] = float(s)
        elif flag and (lowerInvariant == "-e" or lowerInvariant == "--tolerance"):
            Arguments["tolerance"] = float(s)
        elif flag and (lowerInvariant == "-i" or lowerInvariant == "--iteration"):
            Arguments["iterations"] = int(s)
        elif flag and (lowerInvariant == "-s" or lowerInvariant == "--steps"):
            Arguments["scan_interval"] = int(s)
        elif lowerInvariant == "-p" or lowerInvariant == "--dont-disable-plots":
            Arguments["disable_plots"] = False
        elif lowerInvariant == "-t" or lowerInvariant == "--dont-disable-other-tasks":
            Arguments["disable_tasks"] = False
        elif lowerInvariant == "-j" or lowerInvariant == "--use-hooke-and-jeeves":
            Arguments["use_hooke"] = True
        elif lowerInvariant == "/?" or lowerInvariant == "-h" or lowerInvariant == "--help":
            printUsageAndExit()


if __name__ == "__main__":
    print("generate_scans")
    print("==============")
    parse_args(sys.argv)
    if not os.path.exists(Arguments["filename"]):
        printUsageAndExit()

    printStatus()

    try:
        prepare_files(**Arguments)
    except:
        logger.exception("Exception occurred while preparing files")
