""" Utility functions for geerating profile likelihood plots

   This module contains utility functions for generating scans
   around the current solution of a parameter estimation. The method
   is described in detail in:

   Schaber J (2012) Easy parameter identifiability analysis with COPASI.
   Biosystems 110:183–185 http://dx.doi.org/10.1016/j.biosystems.2012.09.003

"""
import basico
import numpy as np
import pandas as pd
import sys
import os
import matplotlib.pyplot as plt
import subprocess
from multiprocessing import Pool, Lock
import tempfile
import logging
import shutil
import COPASI

try:
    from . import model_io
except ImportError:
    from basico import model_io

COPASI_SE = 'CopasiSE'
logger = logging.getLogger(__name__)


def _processfile_with_se(filename, copasi_se=COPASI_SE):
    """Executes the specified copasi file with CopasiSE

    :param filename: copasi file containing executable tasks to run
    :param copasi_se: path to the copasi SE executable to execute
    """
    logger.info(f"processing: {filename}")
    args = [copasi_se, '--nologo', filename]
    subprocess.call(args, cwd=os.path.dirname(filename))
    return


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


def process_dir(data_dir, pool_size=4):
    """Executes all generated copasi files from the given directory in a multiprocessing pool

    :param data_dir: directory containing high / low files generated
    :param pool_size: pool size for the multiprocessing pool that will be created (defaults to 4)
    """
    files = _get_scan_files(data_dir)
    process_files(files, pool_size)


def process_files(files, pool_size=4):
    """Executes all of the given files in a multiprocessing pool

    :param files: list of copasi filenames
    :param pool_size: pool size for the multiprocessing pool that will be created (defaults to 4)
    """
    logging.debug(f'Processing {len(files)} files with a pool of size {pool_size}')
    with Pool(pool_size) as p:
        result = p.map(_processfile_with_se, files)
    logging.debug(f'Processing complete')


def plot_data(data_dir, problem_size=None):
    """Plots all files from the given data directory

    :param data_dir: data directory containing the report files
    :return: list of Axes created
    :rtype: List[matplotlib.axes.Axes]
    """
    file_map = _get_report_filemap(data_dir)
    plots = []
    for entry in file_map:
        df, obj_val, param_val = _combine_files(file_map[entry])
        ax = df.plot(legend=False)
        ax.set_ylabel('obj')
        v_line = ax.axvline(param_val, color='silver', ls='dotted')
        h_line = ax.axhline(obj_val, color='silver', ls='dotted')
        if problem_size:
            m, n = problem_size
            threshold = obj_val+np.sqrt(obj_val/(n-m))
            h_line = ax.axhline(threshold, color='blue', ls='dashed')
            ax.set_ylim(top=np.abs(threshold)*1.1)
        title = ax.set_title(f'{df.index.name} obj={obj_val}, value={param_val}')
        plots.append(ax)

    return plots

def _combine_files(report_files):
    df = None
    param_val = 0
    obj_val = 0
    for filename in report_files:
        if df is None:
            df = _get_data_from_file(filename)
            param_val = df.index[0]
            obj_val = df.values[0][0]
        else:
            df = pd.concat([df, _get_data_from_file(filename)])
    df.sort_index(inplace=True, axis=0)
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


def _convert_opt_items(optItems):
    optItemList = []
    for index in range(len(optItems)):
        optItemList.append(
            {
                'cn': optItems[index].getObjectCN().getString(),
                'start_value': optItems[index].getStartValue(),
                'index': index
            }
        )

    return optItemList


def _generate_scan_for_item(item, index, data_dir, updateModel=False, lower=False):
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
    fitTask = _get_fit_task()
    fitTask.setUpdateModel(updateModel)

    if Arguments["use_hooke"] == True:
        fitTask.setMethodType(COPASI.CTaskEnum.Method_HookeJeeves)
        fitTask.getMethod().getParameter("Iteration Limit").setIntValue(Arguments["iterations"])
        fitTask.getMethod().getParameter("Tolerance").setDblValue(Arguments["tolerance"])
    else:
        fitTask.setMethodType(COPASI.CTaskEnum.Method_LevenbergMarquardt)
        fitTask.getMethod().getParameter("Iteration Limit").setIntValue(Arguments["iterations"])
        fitTask.getMethod().getParameter("Modulation").setDblValue(Arguments["modulation"])
        fitTask.getMethod().getParameter("Tolerance").setDblValue(Arguments["tolerance"])

    problem1 = fitTask.getProblem()
    logger.debug("... Remove OptItem")
    problem1.removeOptItem(item["index"])
    logger.debug("... Generate Scan")
    scanTask = _get_scan()
    scanTask.setScheduled(True)
    problem2 = scanTask.getProblem()
    problem2.setSubtask(COPASI.CTaskEnum.Task_parameterFitting)
    problem2.setContinueFromCurrentState(False)
    problem2.setOutputInSubtask(False)
    problem2.clearScanItems()
    problem2.addScanItem(1, Arguments["scan_interval"])
    scanItem = problem2.getScanItem(0)
    scanItem.getParameter("Object").setCNValue(COPASI.CRegisteredCommonName(item["cn"]))

    start_value = item["start_value"]
    lower_value = _adjust_value(start_value, Arguments["lower_adjustment"])
    upper_value = _adjust_value(start_value, Arguments["upper_adjustment"])

    if not updateModel:
        middle = "_noupdate"
        scanItem.getParameter("Maximum").setDblValue(upper_value)
        scanItem.getParameter("Minimum").setDblValue(lower_value)
    elif lower:
        middle = "_update_low"
        scanItem.getParameter("Minimum").setDblValue(start_value)
        scanItem.getParameter("Maximum").setDblValue(lower_value)
    else:
        middle = "_update_high"
        scanItem.getParameter("Maximum").setDblValue(upper_value)
        scanItem.getParameter("Minimum").setDblValue(start_value)

    scanTask.updateMatrices()
    logger.debug("... Generate Report")
    COPASI.COutputAssistant.createDefaultOutput(1251, scanTask, _DataModel)
    report_file = os.path.abspath("{0}/{1}_{2:05d}_{3}.txt".format(data_dir, Arguments['prefix'], index, middle))
    logger.debug(f"   Report target: '{report_file}'.")
    report = scanTask.getReport()
    report.setTarget(report_file)
    report.setAppend(False)
    report.setConfirmOverwrite(False)
    logger.debug("... Generate Plot")
    COPASI.COutputAssistant.createDefaultOutput(251, scanTask, _DataModel)
    out_file = os.path.abspath("{0}/{1}_{2:05d}_{3}.cps".format(data_dir, Arguments['prefix'], index, middle))
    logger.debug(f"Writing '{out_file}'.")
    _DataModel.saveModel(out_file, True)


def _adjust_value(value, mulitiplier):
    if type(mulitiplier) is str:
        is_additive = mulitiplier.startswith('+')
        if '%' in mulitiplier:
            mulitiplier = float(mulitiplier.rstrip('%')) / 100.0
            if mulitiplier < 0 or is_additive:
                return value + value * mulitiplier
        else:
            mulitiplier = float(mulitiplier)
    return value * mulitiplier

def get_profiles_for_model(data_dir=None, **kwargs):
    """ Convenience function, combining the steps of preparing, running, and plotting

    :param data_dir: optional data directory to use, if not specified a temp directory will be used,
                     and deleted afterwards
    :param kwargs: optional parameters to use, all options from :func:`.prepare_files` can be specified.
    :return: the plot axis
    """
    delete_files = False

    if data_dir == None:
        delete_files = True
        data_dir = tempfile.mkdtemp()

    filename = os.path.join(data_dir, 'model.cps')
    basico.save_model_and_data(filename)
    model = basico.get_current_model()
    task = model.getTask(basico.T.PARAMETER_ESTIMATION)
    assert (isinstance(task, COPASI.CFitTask))
    problem = task.getProblem()
    assert (isinstance(problem, COPASI.CFitProblem))
    num_params = problem.getOptItemSize()
    experiments = problem.getExperimentSet()
    num_data = experiments.getDataPointCount()
    prepare_files(filename, data_dir, **kwargs)
    process_dir(data_dir, kwargs.get('pool_size', 4))
    result = plot_data(data_dir, problem_size=(num_params, num_data))
    if delete_files:
        shutil.rmtree(data_dir, ignore_errors=True)
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
                  prefix="out_"):
    """Generates all files needed for the profile likelihood runs

    :param filename: filename of template copasi file. this file should already have a good fit, to be analyzed
    :param data_dir: directory in which the files will be generated
    :param lower_adjustment: adjustment of the current parameter value for the lower bound of the scan, this
           can be either a double multiplier, or a string with a percentage. By default, half of the current value
           will be substracted from it '-50%'.
    :param upper_adjustment: adjustment of the current parameter value for the upper bound of the scan, this
           can be either a double multiplier, or a string with a percentage. By default, half of the current value
           will be added from it '+50%'.
    :param modulation: In case Levenberg Marquardt is used, this is the modulation parameter, defaults to 0.01
    :param tolerance: optimization tolerance, defaults to 1e-6
    :param iterations: number of iterations to perform, defaults to 50
    :param scan_interval: number of scan intervals in each direction, defaults to 40, wich means that 80 total
           optimnization runs will be taken by default
    :param disable_plots: boolean, indicating whether other plots in the model should be disabled (defaults to True)
    :param disable_tasks: boolean, indicating whether other tasks in the model should be disabled (defaults to True)
    :param use_hooke: boolean indicating whether Hooks & Jeeves should be used (if True), or Levenberg Marquardt
           (if False) defaults to False.
    :param prefix: Prefix to be used for the files that will be generated in the `data_dir`, Defaults to 'out_'
    :return: None
    """
    # remove old warnigns
    COPASI.CCopasiMessage.clearDeque()

    global Arguments
    Arguments = locals()

    global _DataModel
    _DataModel = COPASI.CRootContainer.addDatamodel()
    if not _DataModel.loadModel(filename):
        logger.error("Could not load model")
        logger.error(COPASI.CCopasiMessage.getAllMessageText())
        sys.exit(2)

    global _Task
    _Task = _get_fit_task()
    if _Task == None:
        logger.error("No Fit Task.")
        return

    if not data_dir:
        data_dir = os.path.abspath(os.path.dirname(Arguments['prefix']))
    if not os.path.exists(data_dir):
        os.makedirs(data_dir, exist_ok=True)
    logger.info(f"Copy Experimental Data to: {data_dir}")
    _DataModel.copyExperimentalDataTo(data_dir)

    global _Problem
    _Problem = _Task.getProblem()
    optItemList = _convert_opt_items(_Problem.getOptItemList())
    logger.debug(f"Have: {len(optItemList)} optItems")
    for index in range(len(optItemList)):
        logger.debug(f"Handling: {optItemList[index]['cn']}")
        # _generate_scan_for_item(optItemList[index], index, data_dir)
        _generate_scan_for_item(optItemList[index], index, data_dir, True, True)
        _generate_scan_for_item(optItemList[index], index, data_dir, True)

    # free the data model
    COPASI.CRootContainer.removeDatamodel(_DataModel)
    _DataModel = None


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
        logger.exception("Exception occured while preparing files")
