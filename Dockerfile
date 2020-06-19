# Dockerfile

# FROM directive instructing base image to build on
FROM python:3.7-buster

ARG SERVER_PORT=8020

ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=adminpassword
ENV DJANGO_SUPERUSER_EMAIL=admin@example.com
ENV SERVER_PORT=${SERVER_PORT}

EXPOSE ${SERVER_PORT}:${SERVER_PORT}

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		nginx \
		vim \
		less

RUN mkdir -p /opt/app \
	&& mkdir -p /opt/app/pip_cache \
	&& mkdir -p /opt/app/vuln_django \
	&& mkdir -p /app/.profile.d

COPY requirements.txt start-server.sh /opt/app/

COPY vuln_django/ /opt/app/vuln_django/vuln_django

COPY static/ /opt/app/vuln_django/static

COPY templates/ /opt/app/vuln_django/templates

COPY polls/ /opt/app/vuln_django/polls

COPY manage.py /opt/app/vuln_django/

COPY ./nginx.default /etc/nginx/sites-available/default

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /opt/app

RUN pip install -r requirements.txt \
	&& chown -R www-data:www-data /opt/app \
	&& python vuln_django/manage.py migrate

RUN python vuln_django/manage.py createsuperuser --no-input \
	&& chown -R www-data:www-data /opt/app \
	&& python vuln_django/manage.py seed polls --number=5

STOPSIGNAL SIGTERM

CMD ["/opt/app/start-server.sh"]
