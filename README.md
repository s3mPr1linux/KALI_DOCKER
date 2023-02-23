# KaliDocker

A basic Dockerfile to build a Kali docker image. The interactive shell is configured for oh-my-zsh.

## Setup

docker build -f Dockerfile -t kalirolling --no-cache .

## Execute

docker run -ti --rm kalirolling

The --rm switch makes Docker delete the container once you exit the shell to avoid wasting storage space with a bunch of stopped containers.

# Persistent

## Prereq

Postgresql

### Postgresql Setup

docker pull postgres

Create a volumes folder

mkdir -p <local host path>/postgres

## Start the Postgres container
docker run --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v <local host path>/postgres:/var/lib/postgresql/data postgres

### Volumes

mkdir -p <local host path>/kali-data

docker run -it --name kali -v <local host path>/kali-data:/root kalirolling

