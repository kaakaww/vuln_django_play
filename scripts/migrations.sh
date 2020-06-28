#!/usr/bin/env bash
#
# migrations.sh
# Run database migrations and other setup tasks for the vuln_django "micro" Docker build

EXEC_CMD='docker-compose --file docker-micro-pg.yml exec vuln-django'

echo Waiting for database to become available...
while ! ${EXEC_CMD} bash -c 'nc -z "${SQL_HOST}" "${SQL_PORT}"'; do
  sleep 0.5
done
echo Database ready!

# Echo my commands back from here
set -ex

# Run database migrations to build tables
${EXEC_CMD} python manage.py migrate

# Create Django admin user
${EXEC_CMD} python manage.py createsuperuser --no-input

# Seed database with test data
${EXEC_CMD} python manage.py seed polls --number=5

# Run unit tests
${EXEC_CMD} python manage.py test
