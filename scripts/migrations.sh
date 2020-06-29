#!/usr/bin/env bash
# Run database migrations and other setup tasks for the vuln_django "micro" Docker build
set -ex

EXEC_CMD='docker-compose --file docker-micro-pg.yml exec vuln-django'

echo Waiting for database to become available...
while ! ${EXEC_CMD} bash -c 'nc -z "${SQL_HOST}" "${SQL_PORT}"'; do
  sleep 0.5
done
echo Database ready!

# Run database migrations to build tables
${EXEC_CMD} python manage.py migrate
