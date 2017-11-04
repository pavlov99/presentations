from django.conf.urls import include, url
from django.contrib import admin

# Include json-rpc API object. It auto-generates url map for Django
from .api import api as jsonrpc

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url('^api/v1/jsonrpc', include(jsonrpc.urls)),
]
