#!/usr/bin/env bash
# This script removes automation in case you'd like to recreate it manually.

function clean-repo {
  echo Cleaning repository...
  cd $(dirname $0)/.. || exit 1
  rm -rf \
    .circleci \
    scripts
  rm -f \
    .gitlab-ci.yml \
    [A-Z]*.gitlab-ci.yml \
    .travis.yml \
    Dockerfile \
    docker-* \
    nginx.default \
    Procfile \
    stackhawk* \
    start-server.sh
  echo Complete!
  exit 0
}

function cancel-clean {
  echo Canceling
  exit 0
}

echo ///// DANGER! /////
echo This script will DELETE most of the files in this project!
echo Run this if you would like to clear all automation from this project
echo so you can try rebuilding it yourself.
echo
echo ///// DANGER! /////
read -p "Do you want to DELETE automation from this project? [y/N]" yn
case $yn in
  [Yy]* ) clean-repo; break;;
  * ) cancel-clean;;
esac
