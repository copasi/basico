"""Module containing a callbacks that retrieve information, or allow to cancel interruptions


"""

import COPASI
import numpy as np

try:
    from tqdm import auto as tqmd_lib
    _TQDM_AVAILABLE = True
except ImportError:
    _TQDM_AVAILABLE = False


class TqmdCallback(COPASI.CProcessReport):
    """Utility class that uses tqdm progress information

    """
    def __init__(self, max_time=0, **tqdm_args):
        """ Creates a new TqmdCallback instance

        :param max_time: maximum time to run the tasks (defaults to 0 = no limit)
        :param tqdm_args: arguments to be passed on to tqdm
        """
        super(TqmdCallback, self).__init__(max_time)
        self.shouldProceed = True
        self.count = 0
        self.handlers = {}
        self.ptrs = {}
        self.args = tqdm_args

        if not _TQDM_AVAILABLE:
            raise ImportError("Optional dependency 'tqdm' required to use this callback.")

    def progressItem(self, handle):
        try:
            update = self.handlers.get(handle, None)
            if update is None:
                return self.proceed()

            assert (isinstance(update, tqmd_lib.tqdm))

            value = self.ptrs.get(handle, None)
            total = self._get_end_value(value)
            current = self._get_current_value(value)
            if total != update.total:
                update.total = total
            update.update(current - update.n)
        except KeyboardInterrupt:
            return False
        return self.proceed()

    def resetItem(self, handle):
        update = self.handlers.get(handle, None)
        if update is None:
            return self.proceed()

        assert (isinstance(update, tqmd_lib.tqdm))
        update.reset()
        return self.proceed()

    def reset(self):
        for k in self.handlers.keys():
            self.resetItem(k)
        return self.proceed()

    def proceed(self):
        return self.shouldProceed and super(TqmdCallback, self).proceed()

    def askToStop(self):
        self.shouldProceed = False

    @staticmethod
    def _get_current_value(ptr_dict, default_value=0):
        return TqmdCallback._get_value_from_ptr(ptr_dict['type'], ptr_dict['value'], default_value=default_value)

    @staticmethod
    def _get_end_value(ptr_dict, default_value=0):
        return TqmdCallback._get_value_from_ptr(ptr_dict['type'], ptr_dict['end'], default_value=default_value)

    @staticmethod
    def _get_value_from_ptr(type, ptr, default_value=0):
        if type == COPASI.CCopasiParameter.Type_DOUBLE:
            if ptr is None:
                return default_value
            return COPASI.CProcessReport.getDoubleValue(ptr)
        if type == COPASI.CCopasiParameter.Type_INT:
            if ptr is None:
                return default_value
            return COPASI.CProcessReport.getIntValue(ptr)
        if type == COPASI.CCopasiParameter.Type_UINT:
            if ptr is None:
                return default_value
            return COPASI.CProcessReport.getUIntValue(ptr)
        if type == COPASI.CCopasiParameter.Type_STRING:
            return COPASI.CProcessReport.getStringValue(ptr)
        return default_value

    @staticmethod
    def is_available():
        return _TQDM_AVAILABLE

    def addItem(self, *args, **kwargs):
        self.count += 1
        self.ptrs[self.count] = {'type': args[1], 'value': args[2], 'end': args[3]}
        initial = self._get_current_value(self.ptrs[self.count])
        if np.isinf(initial):
            initial = 0
        total = self._get_end_value(self.ptrs[self.count])
        self.handlers[self.count] = tqmd_lib.tqdm(desc=args[0], total=total, initial=initial, **self.args)
        return self.count

    def finishItem(self, handle):
        update = self.handlers.get(handle, None)
        if not update:
            return self.proceed()

        assert (isinstance(update, tqmd_lib.tqdm))
        update.update(update.total)
        update.close()
        del self.handlers[handle]
        self.ptrs[handle] = None
        del self.ptrs[handle]
        return self.proceed()

    def finish(self):
        for k in self.handlers.keys():
            self.finishItem(k)
        self.handlers.clear()
        return self.proceed()

    def setName(self, name):
        return self.proceed()


_DEFAULT_HANDLER = COPASI.CProcessReport()

def create_default_handler(delay=1, leave=False, unit='', **kwargs):
    """ Sets the default process report handler

    :param delay: delay before process report will be displayed (defaults to 1)
    :type delay: float or int
    :param leave: if true, the process statements will remain after they have completed, otherwise they'll be removed
                  (defaults to False)
    :type leave: bool
    :param unit: the unit to display for each iteration (defaults to '')
    :type unit: str

    :param kwargs: optional arguments to be passed along to tqmd

    :return: None
    """
    handler = TqmdCallback(delay=delay, unit=unit, leave=leave, **kwargs)
    set_default_handler(handler)

def set_default_handler(handler):
    """ Sets the default process report handler, that will be used by each task

    :param handler: the handler (or None, to reset it)
    :return: None
    """
    global _DEFAULT_HANDLER
    _DEFAULT_HANDLER = handler
    if handler is None:
        reset_default_handler()

def get_default_handler():
    """Returns the default handler this will be used for all taks executions

    :return: the default progress handler to use (or none)
    :rtype: COPASI.CProcessReport
    """
    return _DEFAULT_HANDLER

def reset_default_handler():
    """Convenience function to reset the handler back to the default

    :return: None
    """
    global _DEFAULT_HANDLER
    _DEFAULT_HANDLER = COPASI.CProcessReport()
