#!/usr/bin/env bash
# start-server.sh

# to support heroku
if [[ ! -z "${PORT}" ]]; then
  cat /etc/nginx/sites-available/default | sed "s/8020/${PORT}/g" > nginx.tmp
  mv nginx.tmp /etc/nginx/sites-available/default
  env
  whoami
  rm -f /bin/sh
  ln -s /bin/bash /bin/sh
fi

mkdir -p /opt/app/tmp

(cd /opt/app/vuln_django; gunicorn vuln_django.wsgi --worker-tmp-dir /opt/app/tmp  --user $(whoami) --bind 0.0.0.0:8010 --workers 3) &
nginx -g "daemon off;"
