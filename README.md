# Vulnerable Polls

Polls is a simple Django app to conduct Web-based polls. For each
question, visitors can choose between a fixed number of answers.

Based on the [Django Polls tutorial](https://docs.djangoproject.com/en/3.0/intro/tutorial01/), contains a few XSS/SQLi issues and
turns off the built in protections to prevent that.

# Build and run

## Prerequisites

If you are building on a Mac, you will need to have MySQL and PostgreSQL installed to satisfy dependencies for the MySQL and Postgres client modules listed in `requirements.txt`.

```shell script
brew install postgresql
brew install mysql
```

## Using docker-compose

### All-in-One vuln_django

The default Docker Compose configuration builds an all-in-one container, including vuln_django, an Nginx front-end, and SQLite.

Build and run in foreground:
```shell script
docker-compose up --build
```

Run as a daemon:
```shell script
docker-compose up -d
```

Build:
```shell script
docker-compose build
```

### Microservice vuln_django
The `docker-micro-pg` Docker Compose configuration builds a microservice version of vuln_django, with separate containers running an Nginx front-end, and PostgreSQL database. 

Build, run, and run data migrations:
```shell script
docker-compose -f docker-micro-pg.yml build
docker-compose -f docker-micro-pg.yml up --detach
./scripts/migrations.sh
```

To bring the microservice stack up with migrations, a Django admin user, and seed data, run:
```shell script
./scripts/build-and-run.sh
```

To do that plus run HawkScan against it, run:
```shell script
./scripts/build-and-scan.sh
```

## Using Dockerfile

### Build the docker image
```docker build -t vuln_django .```

### Run the docker container
```docker run -it -p 8020:8020 vuln_django:latest```

# Usage

- Browse to the polls with http://localhost:8020/polls/
- Administrator login http://localhost:8020/admin/
    * admin:adminpassword
