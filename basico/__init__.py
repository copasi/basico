from .model_io import *
from .model_info import *

from .task_timecourse import *
from .task_parameterestimation import *
from .task_steadystate import *

from .array_tools import *

settings = {}


def run_test():
    # load_biomodel_from_caltech(10)
    load_example('LM')
    data = get_experiment_data_from_model()
    df = run_time_course(4000, automatic=True)
    df.plot()
    return df


if __name__ == "__main__":
    run_test()
