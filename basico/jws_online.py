"""Convenience module to access JWS models

This module provides convenience functions for accessing models from JWS Online <https://jjj.mib.ac.uk>
using the netherlands endpoint.

Example:

    >>> # get all models with ATP
    >>> atp_models = get_models_for_species('atp')

    >>> # get all models with PFK
    >>> pfk_models = get_models_for_reaction('pfk')

    >>> # get all_models (this will take a while)
    >>> all = get_all_models()

    >>> # get manuscript information
    >>> manuscript = get_manuscript('teusink')
    >>> print(manuscript['title'], manuscript['abstract'], manuscript['url'])

    >>> # get info for a specific model
    >>> info = get_model_info('teusink')
    >>> print(info['name'], info['status'])

    >>> # get content of specific model
    >>> sbml = get_sbml_model('teusink')
    >>> print(sbml)

"""
try:
    import urllib2
    _use_urllib2 = True
except ImportError:
    import urllib
    import urllib.request
    _use_urllib2 = False
import json


END_POINT = 'http://jjj.bio.vu.nl/rest/'
MODEL_END_POINT = END_POINT + 'models/'


def download_from(url):
    """Convenience method reading content from a URL.

    This convenience method uses urlopen on either python 2.7 or 3.x

    :param url: the url to read from
    :type url: str
    :return: the contents of the URL as str
    :rtype: str
    """
    if _use_urllib2:
        content = urllib2.urlopen(url).read()
    else:
        content = urllib.request.urlopen(url).read().decode('utf-8')
    return content


def download_json(url):
    """Convenience method reading the content of the url as JSON.

    :param url: the url to read from
    :type url: str
    :return: a python object representing the json content loaded
    :rtype: dict
    """
    content = download_from(url)
    return json.loads(content)


def get_model_info(model_id):
    """Returns information about the JWS model

    >>> get_model_info('wolf')
    {
        'slug': 'wolf',
        'id': 'wolf',
        'name': 'wolf',
        'cbm': False,
        'status': 'CURATED',
        'species_set': ['at (ATP)', ... ],
        'reaction_set': ['v_1 (glucose transporter)', ...],
        'event_set': [],
        'parameter_set': ['atot',...]
    }

    :param model_id: a valid jws slug
    :return: structure with information about the model [{}]
    """
    return download_json(MODEL_END_POINT + model_id + '/')


def get_sbml_model(model_id):
    """Returns the SBML for the model.

    :param model_id: valid model slug
    :return: the model as sbml string
    """
    return download_json(MODEL_END_POINT + model_id + '/sbml')[model_id]


def get_mathematica_model(model_id):
    """Return the mathematica model for the slug

    :param model_id: valid model slug
    :return: the model as mathematica notebook
    """
    return download_from(MODEL_END_POINT + model_id + '/nb')


def get_manuscript(model_id):
    """Returns information about the model manuscript

    >>> get_manuscript('wolf')

    :param model_id: valid model slug
    :return: manuscript structure (list of dictionary)
    """
    return download_json(MODEL_END_POINT + model_id + '/manuscript/')


def get_models_for_species(species):
    """Searches for models containing a specific chemical species

    >>> get_models_for_species('atp')

    :param species: the species name to search for
    :return: (list of dictionary) of all models containing this species
    """
    return download_json(END_POINT + 'models/species/?search=' + species)


def get_models_for_reaction(reaction):
    """Searches for models containing a specific reaction

    >>> get_models_for_reaction('pfk')

    :param reaction: name of the reaction to search for
    :return:  (list of dictionary) of all models containing the reaction
    """
    return download_json(END_POINT + 'models/reactions/?search=' + reaction)


def get_all_models():
    """Returns the list of all models

    >>> get_all_models()
    [...,
        {
        'slug': 'zi1',
        'name': 'zi1',
        'cbm': False,
        'status': 'CURATED',
        'details': 'https://jjj.bio.vu.nl/rest/models/zi1/',
        'manuscript': 'https://jjj.bio.vu.nl/rest/models/zi1/manuscript/',
        'experiments': 'https://jjj.bio.vu.nl/rest/models/zi1/experiments/'
        }
    ]

    :return: list of model ids
    """
    return download_json(END_POINT + 'models')
