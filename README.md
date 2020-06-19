=====
Vulnerable Polls
=====

Polls is a simple Django app to conduct Web-based polls. For each
question, visitors can choose between a fixed number of answers.

Based on the Django Polls tutorial, contains a few XSS/SQLi issues and
turns off the built in protections to prevent that.

# Build and run

## Using docker-compose

Build and run in foreground:
`docker-compose up --build`

Run as a daemon:
`docker-compose up -d`

Build:
`docker-compose build`

## Using Dockerfile

### Build the docker image
```docker build -t vuln_django .```

### Run the docker container
```docker run -it -p 8020:8020 vuln_django:latest```

# Usage

- Browse to the polls with http://localhost:8020/polls/
- Administrator login http://localhost:8020/admin/
    * admin:adminpassword
