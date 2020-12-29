![Build Status](https://github.com/sgerlach/vuln_django_play/workflows/Tests/badge.svg)
=====
Vulnerable Polls
=====

Polls is a simple Django app to conduct Web-based polls. For each
question, visitors can choose between a fixed number of answers.

Based on the Django Polls tutorial, contains a few XSS/SQLi issues and
turns off the built in protections to prevent that.


# Now with more Docker!
## And even more compose!
This project now has PostgreSQL support and as such, has docker-compose pieces.

### To run this project in local development mode with postgresql
first, start the postgredb
```bash
docker-compose up -d db
```
Change the db hostname in settings.py to point to localhost and you should be good to go. You can then run the migrations and local admin creation as well as seed the database by running the following commands from a local shell
```bash
# only needed on first start of DB
python vuln_django/manage.py migrate
export DJANGO_SUPERUSER_USERNAME=admin
export DJANGO_SUPERUSER_PASSWORD=adminpassword
export DJANGO_SUPERUSER_EMAIL=admin@example.com
python vuln_django/manage.py createsuperuser --no-input
python vuln_django/manage.py seed polls --number=5
```

### To run this project by building JUST the vuln_django Container
first, start the postgredb
```bash
docker-compose up -d db
```
Then you can build and run just the django container (defined in Dockerfile)
```bash
docker build -t vuln_django .
docker run -it --network vuln_django_play_default --name vuln-django -p 8020:8020 vuln_django:latest "/opt/app/start-server.sh"
# only needed for first start of DB
docker exec -it vuln-django /bin/bash -c "python vuln_django/manage.py migrate"
docker exec -it vuln-django /bin/bash -c "python /opt/app/vuln_django/manage.py createsuperuser --no-input"
docker exec -it vuln-django /bin/bash -c "python vuln_django/manage.py seed polls --number=5"
 ```

### To run this project in docker-compose mode only (The Easy Way(TM))
There is a migration script in the docker-compose file that will try to run migrations AND create superuser AND seed database. It will do this on every up and so you can comment out the commands that do that in the docker-compose for subsequent rebuilds of the django app
```bash
docker-compose up
```
## Use the App

### Now browse to the polls with http://localhost:8020/polls/

### Administrator user http://localhost:8020/admin/
- admin:adminpassword

# Never Name Your Docker Container with an underscore because it will make you hate yourself
NO!
```
docker run -it -p 8020:8020 --name vuln_django --rm --network scan_net vuln_django:latest
```

YES!
```
docker run -it -p 8020:8020 --name vuln-django --rm --network scan_net vuln_django:latest
```
