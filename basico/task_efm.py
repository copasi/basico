""" Utility methods for working with the Elementary Flux Modes task
"""

import logging
import basico
import COPASI

from . import model_io

logger = logging.getLogger(__name__)

def get_elementary_flux_modes(**kwargs):
    """ Computes and returns the Elementary Flux Modes

    Returns a list of dictionaries, each containing the following keys:
    - index: the index of the flux mode
    - reaction_name: the reactions in the flux mode, one ``coefficient * name``
      string per line
    - reversible: a boolean indicating if the flux mode is reversible
    - net_reaction: the net reaction of the flux mode
    - internal_species: the internal species balanced by the flux mode, as a
      comma-separated string

    Example:
        [
            {
                'index': 0,
                'reaction_name': ['1 * R3', '1 * R2'],
                'reversible': False,
                'net_reaction': 'B -> D',
                'internal_species': 'Y, X'
            },
            # ...
        ]
 

    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    assert (isinstance(model, COPASI.CDataModel))

    model.getModel().compileIfNecessary()

    if 'settings' in kwargs:
        basico.set_task_settings(basico.T.EFM, kwargs['settings'], model=model)

    task = model.getTask(basico.T.EFM)
    assert (isinstance(task, COPASI.CEFMTask))

    # remember messages before running the task
    num_messages_before = COPASI.CCopasiMessage.size()

    use_initial_values = kwargs.get('use_initial_values', True)

    if not task.initializeRaw(COPASI.CCopasiTask.OUTPUT_UI):
        logger.error('Could not initialize Elementary Flux Modes Task: {0}'.format(
            basico.model_info.get_copasi_messages(num_messages_before, 'No output')))
        return None

    task.processRaw(use_initial_values)
    task.restore(True)

    fms = task.getFluxModes()
    flux_modes = []
    for i in range(fms.size()):
        mode = fms[i]
        flux_modes.append({
            'index': i,
            'reaction_name': task.getFluxModeDescription(mode).strip().split('\n'),
            'reversible': mode.isReversible(),
            'net_reaction': task.getNetReaction(mode),
            'internal_species': task.getInternalSpecies(mode),
            })

    return flux_modes