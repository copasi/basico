"""A submodule for accessing the BioModels API.

This submodule accesses the BioModels REST api as described on:

    <https://www.ebi.ac.uk/biomodels/docs/>


"""

try:
    import urllib2
    _use_urllib2 = True
except ModuleNotFoundError:
    import urllib
    import urllib.request
    _use_urllib2 = False

import json


END_POINT = 'https://www.ebi.ac.uk/biomodels/'


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
    """Return the model info for the provided `model_id`.

    :param model_id: either an integer, or a valid model id
    :return: a python object describing the model
    """
    if type(model_id) is int:
        model_id = 'BIOMD{0:010d}'.format(model_id)
    result = download_json(END_POINT + model_id + '?format=json')
    return result


def get_files_for_model(model_id):
    if type(model_id) is int:
        model_id = 'BIOMD{0:010d}'.format(model_id)
    result = download_json(END_POINT + 'model/files/' + model_id + '?format=json')
    return result


def get_content_for_model(model_id, file_name=None):
    if type(model_id) is int:
        model_id = 'BIOMD{0:010d}'.format(model_id)
    if file_name is None:
        file_name = get_files_for_model(model_id)['main'][0]['name']
    return download_from(END_POINT + 'model/download/' + model_id + '?filename=' + file_name)


def search_for_model(query, offset=0, num_results=10, sort='id-asc'):
    url = END_POINT + 'search?query=' + query
    url += '&offset=' + str(offset)
    url += "&numResults=" + str(num_results)
    url += '&sort=' + sort
    result = download_json(url + '&format=json')
    return result['models']


if __name__ == "__main__":
    print('BioModels')

    # get info for a specific model
    info = get_model_info(12)
    print(info['name'], info['files']['main'][0]['name'])

    # get all files for one model
    files = get_files_for_model(12)
    print(files['main'][0]['name'])

    # get content of specific model
    sbml = get_content_for_model(12)
    print(sbml)

    # search for model
    models = search_for_model('repressilator')
    for model in models:
        print(model['id'], model['name'], model['format'])
