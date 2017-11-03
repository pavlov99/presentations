ENV=$(CURDIR)/.env

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: env
# target: env - Setup Python environment
env:
	[ -d $(ENV) ] || virtualenv --no-site-packages $(ENV)
	$(ENV)/bin/pip install -r requirements.txt

.PHONY: server
# target: server - Start example Werkzeug server
server: env
	$(ENV)/bin/python server.py

.PHONY: client
# target: client - Runs an example client with assert statements on response
client: env
	$(ENV)/bin/python client.py
