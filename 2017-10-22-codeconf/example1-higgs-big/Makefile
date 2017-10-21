ENV=$(CURDIR)/.env
DB_URL="postgresql://postgres:postgres@127.0.0.1:5432/postgres" 

.PHONY: help
# target: help - Display callable targets
help:
	@egrep "^# target:" [Mm]akefile

.PHONY: env
# target: env - Setup Python environment
env:
	[ -d $(ENV) ] || virtualenv --no-site-packages $(ENV)
	$(ENV)/bin/pip install pandas==0.20.3

python:
	$(ENV)/bin/python 1-example-python-pandas.py

startdb:
	docker run -p 5432:5432 postgres:9.6

# Need to have postgresql-client:
# sudo apt-get install postgresql-client
create_table:
	psql $(DB_URL) -f 2-1-postgres-create-table.sql

psql:
	psql $(DB_URL)

prune_table:
	psql $(DB_URL) -c 'DELETE FROM higgs'

upload_data:
	cat HIGGS.csv | psql $(DB_URL) -c 'COPY higgs (signal,lepton_pT,lepton_eta,lepton_phi,missing_energy_magnitude,missing_energy_phi,jet_1_pt,jet_1_eta,jet_1_phi,jet_1_b_tag,jet_2_pt,jet_2_eta,jet_2_phi,jet_2_b_tag,jet_3_pt,jet_3_eta,jet_3_phi,jet_3_b_tag,jet_4_pt,jet_4_eta,jet_4_phi,jet_4_b_tag,m_jj,m_jjj,m_lv,m_jlv,m_bb,m_wbb,m_wwbb) FROM STDIN csv'

postgres_benchmark:
	psql $(DB_URL) -f 2-example-postgres.sql

postgres_output:
	psql $(DB_URL) -c 'COPY (SELECT signal, m_jj, m_wbb FROM higgs WHERE m_jj > 0.75 ORDER BY m_wbb) TO STDOUT csv HEADER' > 2-postgres.csv

awk:
	bash 3-awk.sh

tabtools:
	bash 4-tabtools.sh
