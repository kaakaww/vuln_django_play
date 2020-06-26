# Create the "base" stage
FROM python:3.7-buster as base

COPY requirements.txt start-server.sh /opt/app/
COPY vuln_django/ /opt/app/vuln_django/vuln_django
COPY static/ /opt/app/vuln_django/static
COPY templates/ /opt/app/vuln_django/templates
COPY polls/ /opt/app/vuln_django/polls
COPY manage.py /opt/app/vuln_django/
COPY scripts /opt/app/vuln_django/scripts

RUN pip install -r /opt/app/requirements.txt


# Create a "postgres" stage to run as a gunicorn container
#  - Requires a PostgreSQL DB named "postgres"
#  - Requires migrations to run after startup (see docker-compose/postgres.yml)
FROM base as postgres
ARG SERVER_PORT=8010
ENV SERVER_PORT=${SERVER_PORT}
ENV DJANGO_SETTINGS_MODULE=vuln_django.settings_postgres
EXPOSE ${SERVER_PORT}:${SERVER_PORT}
WORKDIR /opt/app/vuln_django
CMD exec gunicorn vuln_django.wsgi --bind 0.0.0.0:${SERVER_PORT} --workers 3


# Create a "dev" stage as the default final build target for legacy integrations.
#  - Includes sqlite and nginx
#  - Runs data migrations and seeds poll data
FROM base as dev

ARG SERVER_PORT=8020
ARG DJANGO_SUPERUSER_USERNAME=admin
ARG DJANGO_SUPERUSER_PASSWORD=adminpassword
ARG DJANGO_SUPERUSER_EMAIL=admin@example.com

ENV SERVER_PORT=${SERVER_PORT}
ENV DJANGO_SUPERUSER_USERNAME=${DJANGO_SUPERUSER_USERNAME}
ENV DJANGO_SUPERUSER_PASSWORD=${DJANGO_SUPERUSER_PASSWORD}
ENV DJANGO_SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL}

EXPOSE ${SERVER_PORT}:${SERVER_PORT}
WORKDIR /opt/app

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		nginx \
		vim \
		less

COPY ./nginx.default /etc/nginx/sites-available/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log
RUN chown -R www-data:www-data /opt/app \
	&& python vuln_django/manage.py migrate
RUN python vuln_django/manage.py createsuperuser --no-input \
	&& chown -R www-data:www-data /opt/app \
	&& python vuln_django/manage.py seed polls --number=5

STOPSIGNAL SIGINT
CMD ["/opt/app/start-server.sh"]
