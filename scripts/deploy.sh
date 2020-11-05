#!/bin/bash

heroku container:push web --app fathomless-mesa-55963

heroku container:release web --app fathomless-mesa-55963