# Example showing how to use basico in multiprocessing
# here we sample initial conditions of a given model
# and sample it 10000 times

from basico import *

import random       # for drawing from the uniform distribution
import itertools    # for preparing the repeated argument

from  timeit import default_timer as timer  # timing the computation

from multiprocessing import Pool  # the multip processing pool

import matplotlib.pyplot as plt

def worker(args):
    """This is the worker function

    :param args: the tuple with the arguments for the worker, that is expected 
                 to consist of the seed to be used, as well as the model 
                 string, that should be loaded in case no model is loaded yet. 
    :type args: (int, str)

    :return: tuple of: (initial concentration of cysteine, and adomed used, 
                        flux of CGS, and TS)
    :rtype: (float, float, float, float)
    """
    seed, model_string = args

    # we set the seed for reproducibility purposes only
    # you probably wouldnt do that normally
    random.seed(seed)
    
    
    # check if a model is already loaded into the worker
    # since the workers are being reused, and we are just sampling
    # here, we dont want to reload the model multiple times. 
    
    if get_num_loaded_models() == 0:
        # no model is loaded, so we load the model string
        m = load_model_from_string(model_string)
    else:
        # otherwise we take the current model
        m = get_current_model()

    # we sample the model as described in Mendes (2009)
    cysteine = 0.3 * 10 ** random.uniform(0, 3)
    adomed = random.uniform(0, 100)    
    
    # set the sampled initial concentration. 
    set_species('Cysteine', initial_concentration=cysteine, model=m)
    set_species('S-adenosylmethionine', initial_concentration=adomed, model=m)

    # compute the steady state
    _ = run_steadystate(model=m)

    # retrieve the current flux values
    fluxes = get_reactions(model=m).flux

    # and return as tuple
    return (cysteine, adomed, fluxes[1], fluxes[2])


def run_in_parallel(model_string):
    """Performs the computation

    :param model_string: the COPASI model string to use

    :return: array of tuples with the computed results
    :rtype: [(float, float, float, float)]
    """
    num_runs=10000

    # initialize the pool with 6 workers
    with Pool(6) as p:
        # create iterators for seed and the repeat of the model string
        # to be passed into the worker as arguments
        result = p.map(worker, zip(range(num_runs), itertools.repeat(model_string, num_runs)))
        return result


def plot_result(result):
    """Create plot, and show it with matplotlib

    :param result: the results computed by `.run_in_parallel`

    """
    cys = [x[0] for x in result]
    ado = [x[1] for x in result]
    y1 = [x[2] for x in result]
    y2 = [x[3] for x in result]

    plt.plot(ado, y1, 'x')
    plt.plot(ado, y2, 'o')
    plt.show()


if __name__ == "__main__":

    # download biomodel #68
    bm = load_biomodel(68);

    # save it to string (that way we can easily pass it to any worker, no matter 
    # whether the pool is local or MPI is used)
    cps_model_string = save_model_to_string()

    # we are done with the model and unload it
    remove_datamodel(bm)

    # measure computation time
    start = timer()
    
    # compute results
    result = run_in_parallel(cps_model_string)

    # print how long the computation took
    print('calculation took {0}'.format(timer() - start))
    
    # plot results
    plot_result(result)
