#!/usr/bin/env bash
# Build the vuln-django image "micro" stage and run it with Nginx and PostgreSQL
set -ex
EXEC_CMD='docker-compose --file docker-micro.yml exec vuln-django'

# Build any docker images, in particular the app container
docker-compose -f docker-micro.yml build

# Launch the app container with Postgres backend and Nginx frontend
docker-compose -f docker-micro.yml up --detach

# Run data migrations, create admin account, and seed data.
$(dirname $0)/migrations.sh

# Create Django admin user
${EXEC_CMD} python manage.py createsuperuser --no-input

# Seed database with test data
${EXEC_CMD} python manage.py seed polls --number=5

# Run unit tests
${EXEC_CMD} python manage.py test
