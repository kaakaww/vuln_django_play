#!/usr/bin/env bash
# Prepare this repository for the Travis CI tutorial.

function clean-repo {
  echo Cleaning repository...
  cd $(dirname $0) || exit 1
  rm -rf \
    .circleci \
    scripts
  rm \
    .gitlab-ci.yml \
    .[A-Z]gitlab-ci.yml \
    Dockerfile \
    docker-micro* \
    nginx* \
    Procfile \
    stackhawk*
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
echo so you can follow along with the Travis CI tutorial.
echo
read -p "Do you wish to DELETE automation from this project? [y/N]" yn
case $yn in
  [Yy]* ) clean-repo; break;;
  * ) cancel-clean;;
esac
