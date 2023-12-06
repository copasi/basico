#!/usr/bin/env python
# coding: utf-8

# ## Accessing Models from the BioModels Database

# In[1]:


import sys
if '..' not in sys.path:
    sys.path.append('..')

import basico.biomodels as biomodels


# the BioModels REST API allows searching for models, just as one would do in the web interface on http://biomodels.net. So one can search by pathway, species or reactions or submitter / author by just entering them.

# In[2]:


glycolysis_models = biomodels.search_for_model('glycolysis')
for model in glycolysis_models:
    print ('Id: %s' % model['id'])
    print ('Name: %s' % model['name'])
    print ('Format: %s' % model['format'])
    print ('')


# to get more information about a particular model, the `get_model_info` function provides basic information. As all the runctions in this module they take either an integer or string biomodels id as parameter

# In[3]:


info = biomodels.get_model_info(206)


# In[4]:


print (info['name'])
print (info['description'])


# the model information object also contains the list of file names associated with the entry. To just get that list the convenience function `get_files_for_model` exists. The main document is contained in a sublist called `main`. So the main entry can be retrieved using

# In[5]:


first_entry = info['files']['main'][0]


# In[6]:


print ("Main FileName is: '{0}' and has size {1} kb".format(first_entry['name'], first_entry['fileSize']))


# to actually get hold of the model itself, you can use the `get_content_for_model` function, that takes a model id, as well as an optional filename. If the filename is not given, the first main content will be chosen automatically. So to download the model of biomodel #206, once could simply call:

# In[7]:


sbml = biomodels.get_content_for_model(206)


# In[8]:


print(sbml[:1000])  # just printing the first couple of lines


# of course you can simply call `load_biomodel(206)` to load a biomodel into basico.

# ## JWS Online
# we also provide access to models from JWS online.

# In[9]:


import basico.jws_online as jws


# with `get_all_models` you would get a list of all the models in JWS online. To search for models, you have 2 options. One is to search for models by species. For example to search for all models involving 'atp'

# In[10]:


atp_models = jws.get_models_for_species('atp')
for model in atp_models:
    print(model['slug'])


# or you could get the models for a specific reaction for example, all models involving 'pfk' would be:

# In[11]:


pfk_models = jws.get_models_for_reaction('pfk')
for model in pfk_models:
    print(model['slug'])


# for each of these ids, you can get the manuscript, to find out what the model is all about, or the sbml model itself

# In[12]:


manuscript = jws.get_manuscript('wolf')


# In[13]:


print(manuscript['title'])


# In[14]:


print(manuscript['abstract'])


# In[15]:


sbml = jws.get_sbml_model('wolf')


# In[16]:


print(sbml[:1000])


# In[ ]:




