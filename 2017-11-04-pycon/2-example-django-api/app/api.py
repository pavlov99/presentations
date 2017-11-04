import logging

# Include Django backend module from json-rpc and define custom exceptions.
from jsonrpc.backend.django import api
from jsonrpc.exceptions import JSONRPCDispatchException

logger = logging.getLogger(__name__)


class JSONRPCInternalException(JSONRPCDispatchException):
    def __init__(self, data=None):
        super(JSONRPCInternalException, self).__init__(
            code=-29000,
            message='Internal system exception',
            data=data,
        )


@api.dispatcher.add_method
def ping(request, s=None):
    """ Test integration.

    Returns
    -------
    str
        String 'pong'

    """
    return 'pong'


@api.dispatcher.add_method
def echo(request, s):
    """ Test integration.

    Parameters
    ----------
    s : str
        String to return

    Returns
    -------
    str
        Passed string

    """
    return s
