import urllib2
import json


END_POINT = 'http://jjj.bio.vu.nl/rest/'


def download_from(url):
    content = urllib2.urlopen(url).read()
    return content


def download_json(url):
    content = download_from(url)
    return json.loads(content)


def get_model_info(model_id):
    return download_json(END_POINT + 'models/' + model_id + '/')


def get_sbml_model(model_id):
    return download_from(END_POINT + 'models/' + model_id + '/sbml')


def get_mathematica_model(model_id):
    return download_from(END_POINT + 'models/' + model_id + '/nb')


def get_manuscript(model_id):
    return download_json(END_POINT + 'models/' + model_id + '/manuscript/')


def get_models_for_species(species):
    return download_json(END_POINT + 'models/species/?search=' + species)


def get_models_for_reaction(reaction):
    return download_json(END_POINT + 'models/reactions/?search=' + reaction)


def get_all_models():
    return download_json(END_POINT + 'models')


if __name__ == "__main__":
    print('JWS online')

    # get all models with ATP
    atp_models = get_models_for_species('atp')

    # get all models with PFK
    pfk_models = get_models_for_reaction('pfk')

    # get all_models (this will take a while)
    all = get_all_models()

    # get manuscript information
    manuscript = get_manuscript('teusink')
    print(manuscript['title'], manuscript['abstract'], manuscript['url'])

    # get info for a specific model
    info = get_model_info('teusink')
    print(info['name'], info['status'])

    # get content of specific model
    sbml = get_sbml_model('teusink')
    print(sbml)
