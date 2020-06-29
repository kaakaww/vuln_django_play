#!/usr/bin/env bash
# Build the vuln-django image "micro" stage, run it with Nginx and PostgreSQL, and scan it
set -ex

# Build vuln-django and run it with Nginx and PostgreSQL
$(dirname $0)/build-and-run.sh

# Run HawkScan against the app
docker-compose -f docker-micro.yml -f docker-micro-scan.yml up --abort-on-container-exit

# Tear down all containers
docker-compose -f docker-micro.yml -f docker-micro-scan.yml down
