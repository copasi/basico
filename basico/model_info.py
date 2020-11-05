from . import model_io
import pandas
import COPASI

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
    return codes.get(status, COPASI.CModelEntity.Status_FIXED)


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
            'particle_number_rate': metab.getRate(),
            'rate': metab.getConcentrationRate(),
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

        if 'compartment' in kwargs and not kwargs['compartment'] in event_data['compartment']:
            continue

        if 'type' in kwargs and kwargs['type'] not in event_data['type']:
            continue

        data.append(event_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def _replace_names_with_cns(expression, **kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    resulting_expression = ''
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


def _replace_cns_with_names(expression, **kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))
    resulting_expression = ''
    words = expression.split()
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
        else: 
            cn = None

        if cn is not None: 
            obj = dm.getObject(COPASI.CCommonName(cn))
            if obj is not None:
                word = obj.getObjectDisplayName()
        resulting_expression += ' ' + word

    return resulting_expression.strip()


def add_compartment(name, initial_size=1.0, **kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    compartment = model.createCompartment(name, initial_size)

    return compartment


def add_species(name, compartment_name='', initial_concentration=1.0, **kwargs):
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

    return species


def add_event(name, trigger, assignments, **kwargs):
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
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reaction = model.createReaction(name)
    assert (isinstance(reaction, COPASI.CReaction))

    reaction.setReactionScheme(scheme)
    
    return reaction


def get_compartments(name=None, **kwargs):
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


def get_reaction_parameters(name=None, **kwargs):
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
                'reaction name': reaction.getObjectName(),
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

    return pandas.DataFrame(data=data).set_index('reaction name')


def get_reactions(name=None, **kwargs):
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
            'scheme': reaction.getReactionScheme(),
            'name': reaction.getObjectName(),
            'flux': reaction.getFlux(),
            'particle_flux': reaction.getParticleFlux(),
        }

        if 'name' in kwargs and kwargs['name'] not in reaction_data['name']:
            continue

        if name and name not in reaction_data['name']:
            continue

        if 'type' in kwargs and kwargs['type'] not in reaction_data['type']:
            continue

        data.append(reaction_data)

    if not data:
        return None

    return pandas.DataFrame(data=data).set_index('name')


def get_time_unit(**kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    time = model.getTimeUnit()

    return time


def set_parameters(name=None, **kwargs):
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

        if 'expression' in kwargs:
            param.setExpression(_replace_names_with_cns(kwargs['expression']))

        if 'status' in kwargs:
            param.setStatus(__status_to_int(kwargs['status']))

        if 'type' in kwargs:
            param.setStatus(__status_to_int(kwargs['type']))


def set_reaction_parameters(name=None, **kwargs):
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

            if 'new_name' in kwargs:
                param.setObjectName(kwargs['new_name'])
                changed = True

            if 'value' in kwargs:
                if mv and isinstance(mv, COPASI.CModelValue):
                    mv.setInitialValue(kwargs['value'])
                else:
                    param.setDblValue(kwargs['value'])
                changed = True

        if changed:
            reaction.compile()
            model.setCompileFlag(True)


def set_reaction(name=None, **kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    reactions = model.getReactions()
    num_reactions = reactions.size()

    for i in range(num_reactions):
        reaction = reactions.get(i)

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


def set_species(name=None, **kwargs):
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

        if 'expression' in kwargs:
            metab.setExpression(_replace_names_with_cns(kwargs['expression']))

    model.updateInitialValues(change_set)


def set_time_unit(**kwargs):
    dm = kwargs.get('model', model_io.get_current_model())
    assert (isinstance(dm, COPASI.CDataModel))

    model = dm.getModel()
    assert (isinstance(model, COPASI.CModel))

    if 'unit' in kwargs:
        model.setTimeUnit(kwargs['unit'])
