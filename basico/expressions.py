""" Expression generator for frequently needed terms

    This module contains expression generators frequently needed
    while they certainly could be created by hand, they come up often
    enough, to generate them.

    So to create a parameter for the sum of squares of the rates in your
    model you'd use:

    >>> add_parameter_for('sum_squares', 'rates', 'sum_of_squares')

    Or for the minimal flux:

    >>> add_parameter_for('min_flux', 'fluxes', 'min')


    objects currently supported, are fluxes and concentrations. The
    operations are: 'min', 'max', 'sum', 'sum_of_squars' and 'sum_of_abs'

"""

import COPASI
from . import model_io

class OBJ:
    RATES_OF_CHANGE = 'rates'
    FLUXES = 'fluxes'
    CONCENTRATIONS = 'concentrations'

class OPP:
    MIN = 'min'
    MAX = 'max'
    SUM = 'sum'
    SUM_OF_SQUARES = 'sum_of_squares'
    SUM_OF_ABS = 'sum_of_abs'

def _get_objects(model, objects):
    """Returns a list of object reference cns chosen

    :param objects: one of the elements of the `OBJ` class.
    :param model: the model to get the references from
    :type model: COPASI.CDataModel

    """
    if type(objects) is list:
        return objects

    object_cns = []
    if objects == OBJ.FLUXES:
        m = model.getModel()
        assert (isinstance(m, COPASI.CModel))
        for r in m.getReactions():
            assert (isinstance(r, COPASI.CReaction))
            object_cns.append(r.getFluxReference().getCN())
        return object_cns

    if objects == OBJ.RATES_OF_CHANGE:
        m = model.getModel()
        assert (isinstance(m, COPASI.CModel))
        for obj in m.getMetabolites():
            assert (isinstance(obj, COPASI.CMetab))
            object_cns.append(obj.getConcentrationRateReference().getCN())
        return object_cns

    if objects == OBJ.CONCENTRATIONS:
        m = model.getModel()
        assert (isinstance(m, COPASI.CModel))
        for obj in m.getMetabolites():
            assert (isinstance(obj, COPASI.CMetab))
            object_cns.append(obj.getConcentrationReference().getCN())
        return object_cns

    return object_cns

def _nop(objects):
    return ''

def _min(objects):
    num = len(objects)
    if num == 0:
        return '0'
    if num == 1:
        return '<' + str(objects[0]) + '>'
    result = ''
    closing = 0
    for i in range(num - 1):
        result += 'min(<' + objects[i] + '>, '
        closing += 1
    result += '<' + objects[-1] + '>'
    for _ in range(closing):
        result += ')'
    return result

def _max(objects):
    num = len(objects)
    if num == 0:
        return '0'
    if num == 1:
        return '<' + str(objects[0]) + '>'
    result = ''
    closing = 0
    for i in range(num-1):
        result += 'max(<' + objects[i] + '>, '
        closing += 1
    result += '<' + objects[-1] + '>'
    for _ in range(closing):
        result += ')'
    return result

def _sum(objects):
    if not objects:
        return '0'
    return ' + '.join(['<'+str(o)+'>' for o in objects])

def _sum_of_squares(objects):
    if not objects:
        return '0'
    return ' + '.join(['<'+str(o)+'>^2' for o in objects])

def _sum_abs(objects):
    if not objects:
        return '0'
    return ' + '.join(['abs(<'+str(o)+'>)' for o in objects])

def _get_operator(operator):
    operations = {
        OPP.MAX: _max,
        OPP.MIN: _min,
        OPP.SUM_OF_ABS: _sum_abs,
        OPP.SUM: _sum,
        OPP.SUM_OF_SQUARES: _sum_of_squares
    }
    return operations.get(operator, _nop)

def _generate_expression(objects, operator, model):
    assert (isinstance(model, COPASI.CDataModel))
    object_references = _get_objects(model, objects)
    op = _get_operator(operator)
    return op(object_references)

def add_parameter_for(name, objects, operator, **kwargs):
    """ Creates a new global model parameter with the given name

    :param name: the name of the new parameter
    :param objects: the objects to choose: 'rates', 'fluxes', 'concentrations'
    :param operator: the operation for the expression: 'sum_of_squares'
    :param kwargs: optional parameters, recognized are:

        * | `model`: to specify the data model to be used (if not specified
          | the one from :func:`.get_current_model` will be taken)

    :return: the newly created parameter
    """
    model = model_io.get_model_from_dict_or_default(kwargs)
    m = model.getModel()
    assert (isinstance(m, COPASI.CModel))
    mv = m.createModelValue(name)
    if not mv:
        raise ValueError('A global parameter named ' + name + ' already exists')

    assert (isinstance(mv, COPASI.CModelValue))
    mv.setStatus(COPASI.CModelEntity.Status_ASSIGNMENT)
    mv.setExpression(_generate_expression(objects, operator, model))
    return mv
