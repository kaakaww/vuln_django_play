#!/usr/bin/env bash
# Build the vuln-django image "micro" stage, run it with Nginx and PostgreSQL, and scan it
set -ex
source $(dirname $0)/common.sh

# Build vuln-django and run it with Nginx and PostgreSQL
$(dirname $0)/build-and-prep.sh

# Run HawkScan against the app
docker-compose -f docker-micro-pg.yml -f docker-hawkscan.yml up --abort-on-container-exit

# Tear down all containers
docker-compose -f docker-micro-pg.yml -f docker-hawkscan.yml down
