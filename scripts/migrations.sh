#!/usr/bin/env bash
docker-compose --file docker-compose.yml --file docker-compose/postgres.yml exec vuln-django python manage.py migrate
docker-compose --file docker-compose.yml --file docker-compose/postgres.yml exec vuln-django python manage.py test
docker-compose --file docker-compose.yml --file docker-compose/postgres.yml exec vuln-django python manage.py createsuperuser --no-input
docker-compose --file docker-compose.yml --file docker-compose/postgres.yml exec vuln-django python manage.py seed polls --number=5
