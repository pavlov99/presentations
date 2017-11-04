ENV=$(CURDIR)/.env

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: clean
clean:
	@find . -name \*.py[co] -delete

.PHONY: env
# target: env - Setup Python environment
env:
	[ -d $(ENV) ] || virtualenv --no-site-packages $(ENV)
	$(ENV)/bin/pip install -r requirements-dev.txt

.PHONY: migrate
# target: migrate - Migrate the database
migrate: env
	$(ENV)/bin/python manage.py migrate --settings=app.settings.development

.PHONY: run
# target: run - Start Django server
run: env migrate
	$(ENV)/bin/python manage.py runserver --settings=app.settings.development

.PHONY: test
# target: test - run tests
test: env
	$(ENV)/bin/python manage.py test --settings=app.settings.test

example1:
	@echo "Test integration with 'ping' method"
	curl -X POST -H "Content-Type: application/json" \
	    --data '{"id": 0, "jsonrpc": "2.0", "method": "ping"}' \
	    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

example2:
	@echo "Echo method with parameters"
	curl -X POST -H "Content-Type: application/json" \
	    --data '{"id": 1, "jsonrpc": "2.0", "method": "echo", "params": {"s": "PyCon 2017"}}' \
	    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

example3:
	@echo "Example Parse Error"
	curl -X POST -H "Content-Type: application/json" \
	    --data '{' \
	    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

example4:
	@echo "Example Invalid Params"
	curl -X POST -H "Content-Type: application/json" \
	    --data '{"id": 3, "jsonrpc": "2.0", "method": "echo"}' \
	    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool

example5:
	@echo "Example: Method does not exist"
	curl -X POST -H "Content-Type: application/json" \
	    --data '{"id": 4, "jsonrpc": "2.0", "method": "fake"}' \
	    http://127.0.0.1:8000/api/v1/jsonrpc | python -mjson.tool
