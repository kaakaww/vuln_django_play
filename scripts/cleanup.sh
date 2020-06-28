#!/usr/bin/env bash
set -ex

# Tear down all containers
docker-compose -f docker-micro-pg.yml -f docker-hawkscan.yml down --remove-orphans
