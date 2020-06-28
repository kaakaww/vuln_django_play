#!/usr/bin/env bash
set -ex

# Build any docker images, in particular the app container
docker-compose -f docker-micro-pg.yml build

# Launch the app container with Postgres backend and Nginx frontend
docker-compose -f docker-micro-pg.yml up --detach

# Run data migrations, create admin account, and seed data.
./scripts/migrations.sh
