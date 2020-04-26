=====
Vulnerable Polls
=====

Polls is a simple Django app to conduct Web-based polls. For each
question, visitors can choose between a fixed number of answers.

Based on the Django Polls tutorial, contains a few XSS/SQLi issues and
turns off the built in protections to prevent that.

Quick start - this section is old
-----------

1. Add "polls" to your INSTALLED_APPS setting like this::

    INSTALLED_APPS = [
        ...
        'polls',
    ]

2. Include the polls URLconf in your project urls.py like this::

    path('polls/', include('polls.urls')),

3. Run `python3 manage.py migrate` to create the polls models.

4. Start the development server `python3 manage.py runserver 8081` and visit http://127.0.0.1:8081/admin/
   to create a poll (you'll need the Admin app enabled).

5. Visit http://127.0.0.1:8081/polls/ to participate in the poll.


# Now with more Docker!
## Build the docker image
```docker build -t vuln_django .```

## Then run the docker container
```docker run -it -p 8020:8020 vuln_django:latest```

## Now browse to the polls with http://localhost:8020/polls/

## Administrator user http://localhost:8020/admin/
- admin:adminpassword

# Never Name Your Docker Container with an underscore because it will make you hate yourself
NO!
```docker run -it -p 8020:8020 --name vuln_django --rm --network scan_net vuln_django:latest```
YES!
```docker run -it -p 8020:8020 --name vuln-django --rm --network scan_net vuln_django:latest
