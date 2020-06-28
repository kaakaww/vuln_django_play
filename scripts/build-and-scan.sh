#!/usr/bin/env bash
set -ex

# Build any docker images, in particular the app container
docker-compose -f docker-micro-pg.yml build

# Launch the app container with Postgres backend and Nginx frontend
docker-compose -f docker-micro-pg.yml up --detach

# Run data migrations, create admin account, and seed data.
./scripts/migrations.sh

# Run HawkScan against the app
docker-compose -f docker-micro-pg.yml -f docker-hawkscan.yml up --abort-on-container-exit

# Tear down all containers
docker-compose -f docker-micro-pg.yml -f docker-hawkscan.yml down
