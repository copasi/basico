from libssr.SSRSimAPI import SSRSimAPI
import libsbml 
import os
import numpy as np
from typing import List, Dict, Union
import basico

class CopasiSSR(SSRSimAPI):
    """A COPASI implementation of the SSR simulation API.

    This class provides an interface between COPASI and the SSR (Stochastic Simulation Reproducibility) 
    simulation framework. It handles loading SBML models, converting annotations, and managing 
    the mapping between SBML IDs and COPASI references.

    >>> sim = CopasiSSR()
    >>> sim.load_model(model_normal_function)
    >>> model_names = ['S', 'I', 'R', 'V']
    >>> time_final = 10.0
    >>> num_steps = 100
    >>> sample_size = 1000
    >>> results_times = np.linspace(0., time_final, num_steps)
    >>> results = sim.produce_results(model_names, results_times, sample_size)

    """

    def __init__(self):
        self.dm = None
        self.map = {}
        self.initial_map = {}

    @staticmethod
    def _convert_sbml_annotations(sbml_file_or_string: str) -> str:
        if os.path.exists(sbml_file_or_string):
            doc = libsbml.readSBMLFromFile(sbml_file_or_string)
        else:
            doc = libsbml.readSBMLFromString(sbml_file_or_string)
        if doc.getNumErrors(libsbml.LIBSBML_SEV_ERROR) > 0:
            raise ValueError(f"Error loading model: {doc.getErrorLog().toString()}")

        # convert distrib functions in the sbml document
        props = libsbml.ConversionProperties()
        props.addOption("convert distrib to annotations", True, "convert distrib to annotations");
        # we wont write means, so calculation will fail if we dont support a distribution
        props.addOption("writeMeans", False, "Created functions return means of distributions instead of NaN");

        doc.convert(props)

        sbml = libsbml.writeSBMLToString(doc)

        # replace the all wikipedia url with the uncertml ones
        for old, new in [
            ("http://en.wikipedia.org/wiki/Uniform_distribution_(continuous)", "http://www.uncertml.org/distributions/uniform"), 
            ("http://en.wikipedia.org/wiki/Uniform_distribution", "http://www.uncertml.org/distributions/uniform"), 
            ("http://en.wikipedia.org/wiki/Gamma_distribution", "http://www.uncertml.org/distributions/gamma"), 
            ("http://en.wikipedia.org/wiki/Normal_distribution", "http://www.uncertml.org/distributions/normal"), 
            ("http://en.wikipedia.org/wiki/Poisson_distribution", "http://www.uncertml.org/distributions/poisson"), 
            ]:
            sbml = sbml.replace(old, new)

        return sbml

    def load_model(self, *args, **kwargs):
        # for now assume the first arg is a filename to an sbml file 
        sbml = self._convert_sbml_annotations(args[0])

        # create a basico datamodel from the sbml document
        try:
            self.dm = basico.load_model_from_string(sbml)
        except Exception:
            raise ValueError(f"Error loading model: {sbml}")

        # create a map of sbml_ids to COPASI references
        self.map = {}
        for entry in basico.as_dict(basico.get_species(model=self.dm)[['sbml_id', 'display_name']]):
            # initial concentration reference
            self.map[entry['sbml_id']] = f'[{entry["display_name"]}]' 
            self.initial_map[entry['sbml_id']] = f'[{entry["display_name"]}]_0'
        for entry in basico.as_dict(basico.get_parameters(model=self.dm)[['sbml_id', 'display_name']]):
            self.map[entry['sbml_id']] = f'{entry["display_name"]}'
            self.initial_map[entry['sbml_id']] = f'{entry["display_name"]}.InitialValue'

    def produce_results(self, names: List[str], times: List[float], sample_info: Union[int, List[Dict[str, float]]]) -> Dict[str, np.ndarray]:
        if isinstance(sample_info, int):
            sample_size = sample_info
            do_sampling = False
        else:
            sample_size = len(sample_info)
            do_sampling = True

        output_selection = ['Time'] + [self.map[n] for n in names]

        results = {n: np.ndarray((sample_size, len(times)), dtype=float) for n in names}
        for i in range(sample_size):
            if do_sampling:
                for n, v in sample_info[i].items():
                    basico.set_value(self.initial_map[n], v, initial=True, model=self.dm)
            res = basico.run_time_course_with_output(output_selection, use_initial_values=True, update_model=False, values=times, model=self.dm)
            for n in names:
                results[n][i, :] = res[f'[{n}]']                
        return results
