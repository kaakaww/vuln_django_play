#!/usr/bin/env bash
# start-server.sh

(cd /opt/app/vuln_django; gunicorn vuln_django.wsgi  --user www-data --bind 0.0.0.0:8010 --workers 3) &
exec nginx -g "daemon off;"
