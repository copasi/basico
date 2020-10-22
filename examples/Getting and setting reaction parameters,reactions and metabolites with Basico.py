##!/usr/bin/env python
# coding: utf-8

# # Getting and setting reaction parameters and reactions with Basico

# In[1]:


import sys
sys.path.append('..')
get_ipython().magic(u'matplotlib inline')


# In[2]:


from basico import *


# ### Load model

# In[3]:


biomod = load_example("LM-test1")


# ## Getting/setting global quantities

#         It is possible to set:
#             'initial_value'
#             'initial_expression'
#             'expression'
#             'status'
#             'type'

# In[4]:


get_parameters()


# In[5]:


set_parameters(name= 'offset', initial_value = 50)


# In[6]:


get_parameters()


# ## Getting/setting species (metabolites)

# In[7]:


get_species()


# In[8]:


get_species(name = 'E')['initial_concentration']


# #### Setting

#         if 'name' in kwargs:
#             metab.setObjectName(kwargs['name'])
# 
#         if 'unit' in kwargs:
#             metab.setUnitExpression(kwargs['unit'])
# 
#         if 'initial_concentration' in kwargs:
#             metab.setInitialConcentration(kwargs['initial_concentration']),
# 
#         if 'initial_particle_number' in kwargs:
#             metab.setInitialValue(kwargs['initial_particle_number']),
# 
#         if 'initial_expression' in kwargs:
#             metab.setInitialExpression(kwargs['initial_expression'])
# 
#         if 'expression' in kwargs:
#             metab.setExpression(kwargs['expression'])

# In[9]:


set_species(name = 'E', new_name = 'Lilija')


# In[10]:


set_species(name = 'Lilija', initial_concentration = 123456)


# In[11]:


get_species(name = 'Lilija')


# In[12]:


# change it back
set_species(new_name = 'E', name = 'Lilija')


# ## Getting/setting reaction parameters

# In[13]:


get_reaction_parameters()


#         Setting only the following is possible:
#         'new_name'
#         'value'

# In[14]:


set_reaction_parameters(name='(R1).k1', new_name='Ilse')


# In[15]:


set_reaction_parameters(name='(R1).Ilse', value=123)


# In[16]:


get_reaction_parameters()


# In[17]:


# change back parameters
set_reaction_parameters(name='Ilse', new_name='(R1).k1')


# ## Getting/setting reactions

# In[18]:


get_reactions()


# ### Setting scheme

# In[25]:


set_reaction(name = 'R1', scheme = 'S + E + F = ES')


# In[26]:


get_reactions()


# ### Setting reaction name

# In[27]:


set_reaction(name = 'R1', new_name = 'Reaction 1')


# In[28]:


get_reactions()


# In[ ]:




