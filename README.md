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
mkdir -p $HOME/docker/volumes/postgres

# Start the Postgres container
docker run --rm --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data postgres

## Volumes
To avoid having to start from scratch when the container is deleted.

/root — home dir for root (downloads, notes, source code etc.)
/var/lib/postgresql— Postgres database files (used by Metasploit)

This is how you start a new Kali Linux container using the custom image created earlier and map the two locations to the Docker Volumes:

docker run -ti --rm --mount src=kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql/data kalirolling

Initially this will create two volumes named kali-root and kali-postgres, then maps to these Docker Volumes on subsequent runs.

