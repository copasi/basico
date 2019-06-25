#!/usr/bin/env python
# coding: utf-8

# # Simple simulations and plotting with basico

# In[1]:


import sys
sys.path.append('..')
get_ipython().magic(u'matplotlib inline')


# In[2]:


from basico import *


# ### Load a model

# In[3]:


biomod = load_biomodel(10)


# ### Run time course

# #### Time course duration 100

# In[4]:


tc = run_time_course(duration = 100)
tc.plot()


# #### Time course duration 3000

# In[5]:


tc = run_time_course(duration = 3000)
tc.plot()


# ### Get compartments

# In[6]:


get_compartments()


# ### Get parameters ("global quantities")

# In[7]:


get_parameters() # no global quantities


# ### Show experimental data from the model

# In[8]:


get_experiment_data_from_model()


# ### Run steady state

# In[9]:


run_steadystate()
get_species()


# ## Use pandas syntax for indexing and plotting

# In[10]:


tc = run_time_course(model = biomod, duration = 4000)
tc.plot()


# In[11]:


tc.loc[:, ['Mek1', 'Mek1-P', 'Mos']].plot()


# ## Get parameter sets

# In[12]:


model = biomod.getModel()
sets = model.getModelParameterSets()
sets.size()

