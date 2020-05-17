D := docker
DC := docker-compose

build:
	cd ./airflow && ${D} build --rm --build-arg AIRFLOW_DEPS="datadog,dask" --build-arg PYTHON_DEPS="flask_oauthlib>=0.9" -t airflow-base:1.10.10 .

gen_env:
	cp -r ./env/elk_example/ ./env/elk_test/
	cp -r ./env/airflow_example/ ./env/airflow_test/

delete:
	${D} rmi airflow-base:1.0

up_airflow:
	${DC} up -d \
		airflow_redis \
		airflow_postgres \
		airflow_pgadmin \
		airflow_webserver \
		airflow_flower \
		airflow_scheduler \
		airflow_worker \
		airflow_jupyter

up_cicd:
	${DC} up -d \
		jenkins \
		sonarqube

up_elk:
	${DC} up -d \
		elasticsearch \
		logstash \
		kibana \
		grafana

up_nginx:
	${DC} up -d nginx

up:
	${DC} up -d

down:
	${DC} down -v
