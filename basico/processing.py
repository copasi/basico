import logging
import subprocess
from multiprocessing import Pool
from functools import partial
import os

COPASI_SE = 'CopasiSE'
logger = logging.getLogger(__name__)


def process_files(files, pool_size=4, copasi_se=None, max_time=None):
    """Executes all the given files in a multiprocessing pool

    :param files: list of copasi filenames
    :param pool_size: pool size for the multiprocessing pool that will be created (defaults to 4)
    :param copasi_se: path to the copasi SE executable to execute (defaults to COPASI_SE if None)
    :param max_time: maximum time to allow for the execution of each file in seconds (defaults to None for no maximum

    """
    if copasi_se is None:
        copasi_se = COPASI_SE

    logger.info(f'Processing {len(files)} files with a pool of size {pool_size} with CopasiSE {copasi_se}')

    # for debugging purposes use the following line instead of the multiprocessing pool
    # from multiprocessing.dummy import Pool

    with Pool(pool_size) as p:
        p.map(partial(process_file_with_se, copasi_se=copasi_se, max_time=max_time), files)
    logger.info('Processing complete')


def process_file_with_se(filename, copasi_se=None, max_time=None):
    """Executes the specified copasi file with CopasiSE

    :param filename: copasi file containing executable tasks to run
    :param copasi_se: path to the copasi SE executable to execute
    :param max_time: maximum time to allow for the execution of each file in seconds (defaults to None for no maximum)

    """    
    if copasi_se is None:
        copasi_se = COPASI_SE

    args = [copasi_se, '--nologo']
    if max_time is not None:
        args += ['--maxTime', str(max_time)]
    args.append(filename)
    logger.info(f"processing: {filename} with args: {args}")
    subprocess.call(args, cwd=os.path.dirname(filename))
