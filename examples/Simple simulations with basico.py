#!/usr/bin/env python
# coding: utf-8

# # Simulating a model with basico
# First some jupyter magic for plotting and convenience

# In[1]:


get_ipython().magic(u'pylab')
get_ipython().magic(u'matplotlib inline')


# Now import basico

# In[2]:


from basico import *


# now we are ready to load a model, just adjust the file_name variable, to match yours. 
# The file can be a COPASI or SBML file. For this example, the filename lies in the folder where i started the notebook from. 

# In[3]:


file_name = './brusselator.cps'


# In[4]:


model = load_model(file_name)


# now we are ready to simulate. Calling `run_time_course` will run the simulation as specified in the COPASI file and return a pandas dataframe for it. 

# In[5]:


run_time_course().head()


# for plotting you would then just plot that as one does

# In[6]:


df = run_time_course()
df.plot()


# ## The run_time_course command
# you can change different options for the time course by adding named parameters into the `run_time_course_command`. Supported are: 
# 
# * `model`: incase you want to use another model than the one last loaded
# * `scheduled`: to mark the model as scheduled
# * `update_model`: to update the initial state after the simulation is run
# * `duration`: to specify how long the simulation is run
# * `automatic`: in case you would like automatic step size being used
# * `output_event`: in case you would like to have the event values before and after the event hit listed
# * `start_time`: to change the start time
# * `step_number` or `interals`: to overwrite the number of steps being used
# 

# so lets run two simulations that will be different slightly, as we will use the `update_model` flag:

# In[7]:


df1 = run_time_course(update_model=True)
df2 = run_time_course(update_model=True)


# In[8]:


df1.plot(), df2.plot()


# And now you could plot the difference between them too: 

# In[9]:


(df1-df2).plot()


# In[10]:


(df1-df2).describe()


# In[ ]:




