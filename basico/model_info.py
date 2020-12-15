"""The model_info module contains basic functionality for interrogating the model.

Here all functionality for interrogating and manipulating the model is hosted. For each of the elements:

 * compartments
 * species
 * parameters
 * events
 * reactions

you will find functions to add, get, set, and remove them.

"""

from . import model_io
import pandas
import COPASI
import logging

try:
    from collections.abc import Iterable  # noqa
except ImportError:
    from collections import Iterable  # noqa


def __status_to_int(status):
    # type: (str)->int
    codes = {
        "fixed": COPASI.CModelEntity.Status_FIXED,
        "assignment": COPASI.CModelEntity.Status_ASSIGNMENT,
        "ode": COPASI.CModelEntity.Status_ODE,
        "reactions": COPASI.CModelEntity.Status_REACTIONS,
        "time": COPASI.CModelEntity.Status_TIME,
    }
    return codes.get(status.lower(), COPASI.CModelEntity.Status_FIXED)


def __status_to_string(status):
    # type: (int)->str
    strings = {
        COPASI.CModelEntity.Status_FIXED: "fixed",
        COPASI.CModelEntity.Status_ASSIGNMENT: "assignment",
        COPASI.CModelEntity.Status_ODE: "ode",
        COPASI.CModelEntity.Status_REACTIONS: "reactions",
        COPASI.CModelEntity.Status_TIME: "time",
    }
    return strings.get(status, 'fixed')


def get_species(name=None, **kwargs):
    """Returns all information about the species as pandas dataframe.

    Example:

    Assume you have the brusselator example loaded `load_example('brusselator')`

        >>> get_species()

    returns you a dataframe of all species with the species name as index.

        >>> get_species('X')

    returns you only those species, that include `X` in the name.


    :param name: optional filter expression for the species, if it is not included in the species name,
                 the species will not be added to the data set.
    :type name: str
    :param kwargs: optional arguments to further filter down the species. recognized are:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)
     * `compartment`: to filter down only species in specific compartments
     * `type`: to filter for species of specific simulation type

    :return: a pandas dataframe with the information about the species
    :rtype: pandas.DataFrame
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    model.compileIfNecessary()

    metabs = model.getMetabolitesX()
    assert(isinstance(metabs, COPASI.MetabVector))

    num_metabs = metabs.size()
    data = []

    for i in range(num_metabs):
        metab = metabs.get(i)
        assert (isinstance(metab, COPASI.CMetab))

        unit = metab.getUnitExpression()
        if not unit:
            unit = model.getQuantityUnit() + '/' + model.getVolumeUnit()

        metab_data = {
            'name': metab.getObjectName(),
            'compartment': metab.getCompartment().getObjectName(),
            'type': __status_to_string(metab.getStatus()),
            'unit': unit,
            'initial_concentration': metab.getInitialConcentration(),
            'initial_particle_number': metab.getInitialValue(),
            'initial_expression': _replace_cns_with_names(metab.getInitialExpression()),
            'expression': _replace_cns_with_names(metab.getExpression()),
            'concentration': metab.getConcentration(),
            'particle_number': metab.getValue(),
            'rate': metab.getConcentrationRate(),
            'particle_number_rate': metab.getRate(),
            'key': metab.getKey(),
        }

        display_name = metab.getObjectDisplayName()

        if 'name' in kwargs and not kwargs['name'] in metab_data['name']:
            continue

        if name and type(name) is str and name not in metab_data['name'] and name not in display_name:
            continue

        if name and isinstance(name, Iterable) and name not in metab_data['name'] and display_name not in name:
            continue

        if 'compartment' in kwargs and not kwargs['compartment'] in metab_data['compartment']:
            continue

        if 'type' in kwargs and kwargs['type'] not in metab_data['type']:
            continue

        data.append(metab_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_events(name=None, **kwargs):
    """Returns all information about the events as pandas dataframe.

    :param name: optional filter expression for the event, if it is not included in the event name,
                 the event will not be added to the data set.
    :type name: str
    :param kwargs: optional arguments:

     * | `model`: to specify the data model to be used (if not specified
       | the one from :func:`.get_current_model` will be taken)

    :return: a pandas dataframe with the information about the event
    :rtype: pandas.DataFrame
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    events = model.getEvents()

    num_events = events.size()
    data = []

    for i in range(num_events):
        event = events.get(i)
        assert (isinstance(event, COPASI.CEvent))

        assignments = []
        for j in range(event.getNumAssignments()):
            ea = event.getAssignment(j)
            assert (isinstance(ea, COPASI.CEventAssignment))
            target = ea.getTargetObject()
            if target is None:
                continue
            assignments.append(
                {
                    'target': target.getObjectDisplayName(),
                    'expression': _replace_cns_with_names(ea.getExpression(), model=dm)
                })

        event_data = {
            'name': event.getObjectName(),
            'trigger': _replace_cns_with_names(event.getTriggerExpression(), model=dm),
            'delay': _replace_cns_with_names(event.getDelayExpression(), model=dm),
            'assignments': assignments,
            'key': event.getKey(),
        }

        if 'name' in kwargs and not kwargs['name'] in event_data['name']:
            continue

        if name and name not in event_data['name']:
            continue

        data.append(event_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def _replace_names_with_cns(expression, **kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    resulting_expression = ''
    expression = expression.replace('{', ' {')
    expression = expression.replace('}', '} ')
    for word in expression.split():
        if word.startswith('{') and word.endswith('}'):
            word = word[1:-1]

        obj = dm.findObjectByDisplayName(word)
        if obj is not None:
            if isinstance(obj, COPASI.CModel):
                obj = obj.getValueReference()
            resulting_expression += ' <{0}>'.format(obj.getCN())
        else:
            resulting_expression += ' ' + word

    return resulting_expression.strip()


def _split_by_cn(expression):
    result = []
    current = ''
    num_chars = len(expression)
    pos = 0
    while pos < num_chars:
        has_more = pos + 4 < num_chars
        cur_char = expression[pos]

        if cur_char == '<' and has_more:

            next_3 = expression[pos:pos+4]

            if next_3.startswith('<CN='):
                end = expression.find('>', pos)
                cn = expression[pos+1: end]
                result.append(cn)
                pos = end + 1
                current = ''
                continue

        if cur_char in '/*+-()^%<>!=&|':

            if current:
                result.append(current)
                current = ''

            if pos + 1 < num_chars and expression[pos + 1] == '=':
                cur_char += '='
                pos += 1
            result.append(cur_char)

        elif cur_char != ' ':
            current += cur_char

        pos += 1

    if current:
        result.append(current)

    return result


def _replace_cns_with_names(expression, **kwargs):
    if not expression:
        return expression

    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    resulting_expression = ''
    words = _split_by_cn(expression)
    skip = -1
    for i in range(len(words)):
        if i < skip: 
            continue

        word = words[i]
        if word.startswith('<CN') and word.endswith('>'):
            word = word[1:-1]
            cn = word
            word = ''
        elif word.startswith('<CN'):
            cn = word[1:] 
            i = i + 1
            while not words[i].endswith('>'):
                cn += ' ' + words[i]
                i = i + 1
            cn += ' ' + words[i][:-1]
            i = i + 1
            skip = i
            word = ''
        elif word.startswith('CN='):
            cn = word
            word = ''
        else: 
            cn = None

        if cn is not None: 
            obj = dm.getObject(COPASI.CCommonName(cn))
            if obj is not None:
                word = obj.getObjectDisplayName()
        resulting_expression += ' ' + word

    return resulting_expression.strip()


def add_compartment(name, initial_size=1.0, **kwargs):
    """Adds a new compartment to the model.

    :param name: the name for the new compartment
    :type name: str
    :param initial_size: the initial size for the compartment
    :type initial_size: float
    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)
        * all other parameters from :func:`set_compartment`.

    :return: the compartment added
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartment = model.createCompartment(name, initial_size)
    if compartment is None:
        raise ValueError('A compartment named ' + name + ' already exists')

    set_compartment(name, **kwargs)

    return compartment


def add_species(name, compartment_name='', initial_concentration=1.0, **kwargs):
    """Adds a new species to the model.

        :param name: the name for the new species
        :type name: str
        :param compartment_name: optional the name of the compartment in which the species should be
               created, it will default to the first compartment. If no compartment is present,
               a unit compartment named `compartment` will be created.
        :type compartment_name: str
        :param initial_concentration: optional the initial concentration of the species
        :type initial_concentration: float
        :param kwargs: optional parameters, recognized are:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)
            * all other parameters from :func:`set_species`.

        :return: the newly created species
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    # create compartment if it does not yet exist
    if not compartment_name:
        if model.getNumCompartments() == 0:
            model.createCompartment('compartment', 1)
        compartment_name = model.getCompartment(0).getObjectName()

    species = model.createMetabolite(name, compartment_name, initial_concentration)
    if species is None:
        raise ValueError('A species named ' + name + ' already exists in compartment ' + compartment_name)

    set_species(name, **kwargs)

    return species


def add_parameter(name, initial_value=1.0, **kwargs):
    """Adds a new global parameter to the model.

        :param name: the name for the new global parameter
        :type name: str
        :param initial_value: optional the initial value of the parameter (defaults to 1)
        :type initial_value: float
        :param kwargs: optional parameters, recognized are:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)
            * all other parameters from :func:`set_parameters`.

        :return: the newly created parameter
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameter = model.createModelValue(name, initial_value)
    if parameter is None:
        raise ValueError('A global parameter named ' + name + ' already exists')

    set_parameters(name, **kwargs)

    return parameter


def add_event(name, trigger, assignments, **kwargs):
    """Adds a new event to the model.

        :param name: the name for the new event
        :type name: str
        :param trigger: the trigger expression to be used. The expression can consist of all display names.
               for example `Time > 10` would make the event trigger at time 10.
        :type trigger: str
        :param assignments: All the assignments that should be made, when the event fires. This should be a
                list of tuples where the first element is the name of the element to change, and the second element
                the assignment expression.
        :type assignments: [(str,str)]
        :param kwargs: optional parameters, recognized are:

             * | `model`: to specify the data model to be used (if not specified
               | the one from :func:`.get_current_model` will be taken)

        :return: the newly created event
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    event = model.createEvent(name)
    if event is None:
        raise ValueError('An Event named ' + name + ' already exists')
    assert (isinstance(event, COPASI.CEvent))

    event.setTriggerExpression(_replace_names_with_cns(trigger, model=dm))
    for assignment in assignments:
        ea = event.createAssignment()
        assert (isinstance(ea, COPASI.CEventAssignment))
        target = dm.findObjectByDisplayName(assignment[0])
        if target is None:
            continue
        ea.setTargetCN(target.getCN())
        ea.setExpression(_replace_names_with_cns(assignment[1], model=dm))

    model.compileIfNecessary()
    return event


def add_reaction(name, scheme, **kwargs):
    """Adds a new reaction to the model

        :param name: the name for the new reaction
        :type name: str
        :param scheme: the reaction scheme for the new reaction, if it includes Species that do not exist yet
               in the model they will be created. So for example a scheme of `A -> B` would create species `A`
               and `B` if they would not exist in the model, before creating the irreversible reaction.
        :type scheme: str
        :param kwargs: optional parameters, recognized are:

           * | `model`: to specify the data model to be used (if not specified
             | the one from :func:`.get_current_model` will be taken)
           * all other parameters from :func:`set_reaction`.

        :return: the newly created reaction
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reaction = model.createReaction(name)
    if reaction is None:
        raise ValueError('A reaction named ' + name + ' already exists')

    assert (isinstance(reaction, COPASI.CReaction))
    set_reaction(name, scheme=scheme, **kwargs)

    return reaction


def get_compartments(name=None, **kwargs):
    """Returns all information about the compartments as pandas dataframe.

        :param name: optional filter expression for the compartment, if it is not included in the name,
                     the compartment will not be added to the data set.
        :type name: str
        :param kwargs: optional arguments:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: a pandas dataframe with the information about the compartment
        :rtype: pandas.DataFrame
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()
    assert(isinstance(compartments, COPASI.CompartmentVectorNS))

    num_compartments = compartments.size()
    data = []

    for i in range(num_compartments):
        compartment = compartments.get(i)
        assert (isinstance(compartment, COPASI.CCompartment))

        unit = compartment.getUnitExpression()
        if not unit:
            unit = model.getVolumeUnit()

        comp_data = {
            'name': compartment.getObjectName(),
            'type': __status_to_string(compartment.getStatus()),
            'unit': unit,
            'initial_size': compartment.getInitialValue(),
            'initial_expression': _replace_cns_with_names(compartment.getInitialExpression()),
            'dimensionality': compartment.getDimensionality(),
            'expression': _replace_cns_with_names(compartment.getExpression()),
            'size': compartment.getValue(),
            'rate': compartment.getRate(),
            'key': compartment.getKey(),
        }

        if 'name' in kwargs and kwargs['name'] not in comp_data['name']:
            continue

        if name and name not in comp_data['name']:
            continue

        if 'type' in kwargs and kwargs['type'] not in comp_data['type']:
            continue

        data.append(comp_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_parameters(name=None, **kwargs):
    """Returns all information about the global parameters as pandas dataframe.

        :param name: optional filter expression for the parameters, if it is not included in the name,
                     the parameter will not be added to the data set.
        :type name: str
        :param kwargs: optional arguments:

            * | `model`: to specify the data model to be used (if not specified
              | the one from :func:`.get_current_model` will be taken)

        :return: a pandas dataframe with the information about the parameter
        :rtype: pandas.DataFrame
        """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameters = model.getModelValues()
    assert(isinstance(parameters, COPASI.ModelValueVectorN))

    num_params = parameters.size()
    data = []

    for i in range(num_params):
        param = parameters.get(i)
        assert (isinstance(param, COPASI.CModelValue))

        unit = param.getUnitExpression()
        if 'unit' in kwargs and not kwargs['unit'] in unit:
            continue

        param_data = {
            'name': param.getObjectName(),
            'type': __status_to_string(param.getStatus()),
            'unit': unit,
            'initial_value': param.getInitialValue(),
            'initial_expression': _replace_cns_with_names(param.getInitialExpression()),
            'expression': _replace_cns_with_names(param.getExpression()),
            'value': param.getValue(),
            'rate': param.getRate(),
            'key': param.getKey(),
        }

        if 'name' in kwargs and kwargs['name'] not in param_data['name']:
            continue

        if name and name not in param_data['name']:
            continue

        if 'type' in kwargs and kwargs['type'] not in param_data['type']:
            continue

        data.append(param_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_functions(name=None, **kwargs):
    """Returns all available functions as pandas dataframe.

           :param name: optional filter expression for the functions, if it is not included in the name,
                        the function will not be added to the data set.
           :type name: str
           :param kwargs: optional arguments:

            * `reversible`: to further filter for functions that are only reversible

           :return: a pandas dataframe with the information about the functions
           :rtype: pandas.DataFrame
           """
    root = COPASI.CRootContainer.getRoot()
    assert (isinstance(root, COPASI.CRootContainer))
    functions = root.getFunctionList().loadedFunctions()
    data = []
    for index in range(functions.size()):
        function = functions.get(index)
        assert (isinstance(function, COPASI.CFunction))

        fun_data = {
            'name': function.getObjectName(),
            'reversible': function.isReversible() == 1,
            'formula': function.getInfix(),
            'general': function.isReversible() == -1,
        }

        if 'name' in kwargs and kwargs['name'] not in fun_data['name']:
            continue

        if 'reversible' in kwargs and kwargs['reversible'] != fun_data['reversible']:
            continue

        if name and name not in fun_data['name']:
            continue

        data.append(fun_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_reaction_parameters(name=None, **kwargs):
    """Returns all local parameters as pandas dataframe.

       This also includes global parameters that are mapped to local ones.

       :param name: optional filter expression, if it is not included in the name,
                    the function will not be added to the data set.
       :type name: str
       :param kwargs: optional arguments:

        * | `reaction_name`: to further filter for local parameters of only certain reactions
          | (that contain the substring)

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

       :return: a pandas dataframe with the information about local parameters
       :rtype: pandas.DataFrame
       """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()

    num_reactions = reactions.size()
    data = []

    for i in range(num_reactions):
        reaction = reactions.get(i)

        if 'reaction_name' in kwargs and kwargs['reaction_name'] != reaction.getObjectName():
            continue

        parameter_group = reaction.getParameters()
        fun_params = reaction.getFunctionParameters()
        num_params = fun_params.size()
        param_objects = reaction.getParameterObjects()

        for j in range(num_params):
            fun_parameter = fun_params.getParameter(j)
            if fun_parameter.getUsage() != COPASI.CFunctionParameter.Role_PARAMETER:
                continue
            parameter = parameter_group.getParameter(fun_parameter.getObjectName())
            if parameter is None: 
                continue

            current_param = param_objects[j][0] if param_objects[j] else None
            cn = current_param.getCN() if current_param else None
            mv = dm.getObject(current_param.getCN()) if cn else None
            if mv and isinstance(mv, COPASI.CModelValue):
                param_type = 'global'
                mapped_to = mv.getObjectName()
                value = mv.getInitialValue()
            else:
                param_type = 'local'
                mapped_to = ''
                value = reaction.getParameterValue(parameter.getObjectName())

            param_data = {
                'name': parameter.getObjectDisplayName(),
                'value': value,
                'reaction': reaction.getObjectName(),
                'type': param_type,
                'mapped_to': mapped_to
            }

            if 'name' in kwargs and kwargs['name'] not in param_data['name']:
                continue

            if name and name not in param_data['name']:
                continue

            if 'type' in kwargs and kwargs['type'] not in param_data['type']:
                continue

            data.append(param_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_reactions(name=None, **kwargs):
    """Returns all reactions as pandas dataframe.

       :param name: optional filter expression, if it is not included in the name,
                    the reaction will not be added to the data set.
       :type name: str
       :param kwargs: optional arguments:

        * | `reaction_name`: to further filter for local parameters of only certain reactions
          | (that contain the substring)

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

       :return: a pandas dataframe with the information about local parameters
       :rtype: pandas.DataFrame
       """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()

    num_reactions = reactions.size()
    data = []

    for i in range(num_reactions):
        reaction = reactions.get(i)
        assert (isinstance(reaction, COPASI.CReaction))

        reaction_data = {
            'name': reaction.getObjectName(),
            'scheme': reaction.getReactionScheme(),
            'flux': reaction.getFlux(),
            'particle_flux': reaction.getParticleFlux(),
            'function': reaction.getFunction().getObjectName()
        }

        if 'name' in kwargs and kwargs['name'] not in reaction_data['name']:
            continue

        if name and name not in reaction_data['name']:
            continue

        data.append(reaction_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_time_unit(**kwargs):
    """Returns the time unit of the model"""
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    time = model.getTimeUnit()

    return time


def set_compartment(name=None, **kwargs):
    """Sets properties of the named compartment

    :param name: the name of the compartment (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `initial_value` or `initial_size`: to set the initial size of the compartment
        - | `initial_expression`: the initial expression for the compartment
        - | `status` or `type`: the type of the compartment one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the compartment (only valid when type is `ode` or `assignment`)
        - | `dimensionality`: sets the dimensionality of the compartment (int value 1..3)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartments = model.getCompartments()

    num_compartments = compartments.size()

    for i in range(num_compartments):
        compartment = compartments.get(i)
        assert (isinstance(compartment, COPASI.CCompartment))
        current_name = compartment.getObjectName()

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        if 'initial_value' in kwargs:
            compartment.setInitialValue(kwargs['initial_value'])

        if 'initial_size' in kwargs:
            compartment.setInitialValue(kwargs['initial_size'])

        if 'initial_expression' in kwargs:
            compartment.setInitialExpression(_replace_names_with_cns(kwargs['initial_expression']))
            model.setCompileFlag(True)

        if 'status' in kwargs:
            compartment.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            compartment.setStatus(__status_to_int(kwargs['type']))

        if 'expression' in kwargs:
            compartment.setExpression(_replace_names_with_cns(kwargs['expression']))
            model.setCompileFlag(True)

        if 'dimensionality' in kwargs:
            compartment.setDimensionality(kwargs['dimensionality'])

    model.compileIfNecessary()


def set_parameters(name=None, **kwargs):
    """Sets properties of the named parameter(s).

    :param name: the name of the parameter (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `unit`: the unit expression to be set
        - | `initial_value`: to set the initial value for the parameter
        - | `initial_expression`: the initial expression
        - | `status` or `type`: the type of the parameter one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the parameter (only valid when type is `ode` or `assignment`)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    parameters = model.getModelValues()
    assert (isinstance(parameters, COPASI.ModelValueVectorN))

    num_params = parameters.size()

    for i in range(num_params):
        param = parameters.get(i)
        assert (isinstance(param, COPASI.CModelValue))
        current_name = param.getObjectName()

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        if 'unit' in kwargs:
            param.setUnitExpression(kwargs['unit'])

        if 'initial_value' in kwargs:
            param.setInitialValue(kwargs['initial_value'])

        if 'initial_expression' in kwargs:
            param.setInitialExpression(_replace_names_with_cns(kwargs['initial_expression']))
            model.setCompileFlag(True)

        if 'status' in kwargs:
            param.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            param.setStatus(__status_to_int(kwargs['type']))

        if 'expression' in kwargs:
            param.setExpression(_replace_names_with_cns(kwargs['expression']))
            model.setCompileFlag(True)

    model.compileIfNecessary()


def set_reaction_parameters(name=None, **kwargs):
    """Sets local parameter values.

    :param name: the name of the parameter (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `reaction_name`: if specified only parameters of the named reaction will be changed
        - | `value`: the new value of the parameter to set.
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()
    num_reactions = reactions.size()

    for i in range(num_reactions):
        reaction = reactions.get(i)

        if 'reaction_name' in kwargs and kwargs['reaction_name'] != reaction.getObjectName():
            continue

        changed = False

        parameter_group = reaction.getParameters()
        fun_params = reaction.getFunctionParameters()
        num_params = fun_params.size()
        param_objects = reaction.getParameterObjects()

        for j in range(num_params):
            fun_parameter = fun_params.getParameter(j)
            if fun_parameter.getUsage() != COPASI.CFunctionParameter.Role_PARAMETER:
                continue
            param = parameter_group.getParameter(fun_parameter.getObjectName())
            if param is None: 
                continue
            current_param = param_objects[j][0] if param_objects[j] else None
            cn = current_param.getCN() if current_param else None
            mv = dm.getObject(current_param.getCN()) if cn else None

            current_name = param.getObjectDisplayName()

            if 'name' in kwargs and kwargs['name'] not in current_name:
                continue

            if name and type(name) is str and name not in current_name:
                continue

            if name and isinstance(name, Iterable) and current_name not in name:
                continue

            if 'value' in kwargs:
                if mv and isinstance(mv, COPASI.CModelValue):
                    mv.setInitialValue(kwargs['value'])
                    model.updateInitialValues(mv)
                else:
                    param.setDblValue(kwargs['value'])
                    model.updateInitialValues(param)
                changed = True

        if changed:
            reaction.compile()
            model.setCompileFlag(True)


def set_reaction(name=None, **kwargs):
    """Sets attributes of the named reaction.

    :param name: the name of the reaction (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `new_name`: new name of the reaction
        - | `scheme`: the reaction scheme, new species will be created automatically
        - | `function`: the function from the function database to set
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """

    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()
    num_reactions = reactions.size()

    changed = False

    for i in range(num_reactions):
        reaction = reactions.get(i)
        assert(isinstance(reaction, COPASI.CReaction))

        current_name = reaction.getObjectName()

        if 'name' in kwargs and kwargs['name'] not in current_name:
            continue

        if name and type(name) is str and name not in current_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name:
            continue

        if 'new_name' in kwargs:
            reaction.setObjectName(kwargs['new_name'])

        if 'scheme' in kwargs:
            reaction.setReactionScheme(kwargs['scheme'])
            reaction.compile()
            changed = True

        if 'function' in kwargs:
            info = COPASI.CReactionInterface()
            info.init(reaction)
            info.setFunctionAndDoMapping(kwargs['function'])
            info.writeBackToReaction(reaction)
            changed = True

    if changed:
        model.forceCompile()


def remove_species(name, **kwargs):
    """Deletes the named species

    :param name: the name of a species in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    metab = model.getMetabolite(name)
    if metab is None:
        logging.warning('no such metabolite {0}'.format(name))
    key = metab.getKey()
    metab = None
    model.compileIfNecessary()
    model.removeMetabolite(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_parameter(name, **kwargs):
    """Deletes the named global parameter

    :param name: the name of a parameter in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    mv = model.getModelValue(name)
    if mv is None:
        logging.warning('no such global parameter {0}'.format(name))
    key = mv.getKey()
    mv = None
    model.compileIfNecessary()
    model.removeModelValue(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_compartment(name, **kwargs):
    """Deletes the named compartment (and everything included)

    :param name: the name of a compartment in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    comp = model.getCompartment(name)
    if comp is None:
        logging.warning('no such compartment {0}'.format(name))
    key = comp.getKey()
    comp = None
    model.compileIfNecessary()
    model.removeCompartment(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def remove_event(name, **kwargs):
    """Deletes the named event

    :param name: the name of an event in the model
    :type name: str
    :param kwargs: optional arguments

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    ev = model.getEvent(name)
    if ev is None:
        logging.warning('no such event {0}'.format(name))
    key = ev.getKey()
    ev = None
    model.compileIfNecessary()
    model.removeEvent(key)
    model.setCompileFlag(True)
    model.compileIfNecessary()


def set_species(name=None, **kwargs):
    """Sets properties of the named species

    :param name: the name of the species (or a substring of the name)
    :type name: str
    :param kwargs: optional arguments

        - | `new_name`: the new name for the species
        - | `initial_concentration`: to set the initial concentration for the species
        - | `initial_particle_number`: to set the initial particle number for the species
        - | `initial_expression`: the initial expression for the species
        - | `status` or `type`: the type of the species one of `fixed`, `assignment` or `ode`
        - | `expression`: the expression for the species (only valid when type is `ode` or `assignment`)
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: None
    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    metabs = model.getMetabolitesX()
    num_metabs = metabs.size()

    change_set = COPASI.ObjectStdVector()

    for i in range(num_metabs):
        metab = metabs.get(i)
        assert (isinstance(metab, COPASI.CMetab))

        current_name = metab.getObjectName()
        display_name = metab.getObjectDisplayName()

        if 'name' in kwargs and kwargs['name'] not in current_name and kwargs['name'] not in display_name:
            continue

        if name and type(name) is str and name not in current_name and name not in display_name:
            continue

        if name and isinstance(name, Iterable) and current_name not in name and display_name not in name:
            continue

        if 'new_name' in kwargs:
            metab.setObjectName(kwargs['new_name'])

        if 'unit' in kwargs:
            metab.setUnitExpression(kwargs['unit'])

        if 'initial_concentration' in kwargs:
            metab.setInitialConcentration(kwargs['initial_concentration'])
            change_set.append(metab.getInitialConcentrationReference())

        if 'initial_particle_number' in kwargs:
            metab.setInitialValue(kwargs['initial_particle_number']),
            change_set.append(metab.getInitialValueReference())

        if 'initial_expression' in kwargs:
            metab.setInitialExpression(_replace_names_with_cns(kwargs['initial_expression']))
            model.setCompileFlag(True)

        if 'status' in kwargs:
            metab.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            metab.setStatus(__status_to_int(kwargs['type']))

        if 'expression' in kwargs:
            metab.setExpression(_replace_names_with_cns(kwargs['expression']))
            model.setCompileFlag(True)

    model.updateInitialValues(change_set)
    model.compileIfNecessary()


def set_time_unit(unit, **kwargs):
    """Sets the time unit of the model.

    :param unit: the time unit expression
    :type unit: str
    :param kwargs: optional parameters

        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'unit' in kwargs:
        model.setTimeUnit(kwargs['unit'])


def set_model_unit(**kwargs):
    """Sets the model units.

    :param kwargs: optional parameters

        - | `time_unit`: time unit expression
        - | `substance_unit` or `quantity_unit`: substance unit expression
        - | `length_unit`: length unit expression
        - | `area_unit`: area unit expression
        - | `volume_unit`: volume unit expression
        - | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    """

    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'time_unit' in kwargs:
        model.setTimeUnit(kwargs['time_unit'])

    if 'substance_unit' in kwargs:
        model.setQuantityUnit(kwargs['substance_unit'])

    if 'quantity_unit' in kwargs:
        model.setQuantityUnit(kwargs['quantity_unit'])

    if 'length_unit' in kwargs:
        model.setLengthUnit(kwargs['length_unit'])

    if 'area_unit' in kwargs:
        model.setAreaUnit(kwargs['area_unit'])

    if 'volume_unit' in kwargs:
        model.setVolumeUnit(kwargs['volume_unit'])

    model.updateInitialValues(COPASI.CCore.Framework_Concentration)
