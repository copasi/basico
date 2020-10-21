try:
    import urllib2
except:
    import urllib
import json


END_POINT = 'https://www.ebi.ac.uk/biomodels/'


def download_from(url):
    try:
        content = urllib2.urlopen(url).read()
    except:
        content = urllib.request.urlopen(url).read().decode('utf-8')
    return content


def download_json(url):
    content = download_from(url)
    return json.loads(content)


def get_model_info(model_id):
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
    print (info['name'], info['files']['main'][0]['name'])

    # get all files for one model
    files = get_files_for_model(12)
    print (files['main'][0]['name'])

    # get content of specific model
    sbml = get_content_for_model(12)
    print(sbml)

    # search for model
    models = search_for_model('repressilator')
    for model in models:
        print (model['id'], model['name'], model['format'])
