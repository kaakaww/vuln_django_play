#!/usr/bin/env bash
set -ex

# Tear down all containers
docker-compose -f docker-micro.yml -f docker-micro-scan.yml down --remove-orphans
