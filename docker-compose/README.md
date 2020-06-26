# Docker Compose Override Files

The files in this directory are intended to override the base configuration found in `docker-compose.yml` at the root of this project. For example, to build and run the `dev` stage image listening on port 8020, run:

```shell script
docker-compose --file docker-compose.yml --file docker-compose/dev.yml up --build
```
