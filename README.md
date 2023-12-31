# KaliDocker
While GUI has it's place, this image is CLI based.

There are two Dockerfile's to choose from. The first is a basic Kali docker image without the tools such as metasploit. The second, Dockerfile.msf is the full fledge Kali with all of the standard tools. Both can be customized to meet whatever the needs are.

A quick note, both are setup with the interactive shell as "oh-my-zsh with the fino theme.

## Setup
First, grab this repo.

    > git clone https://github.com/sealmindset/KaliDocker.git
    > cd KaliDocker
    > docker build -f Dockerfile -t kalirolling --no-cache .

### Test
If no errors arises from the build, create a container to test if its operational, i.e., doesn't fail to start and oh-my-zsh prompt is waiting for you.

    > docker run -ti --rm kalirolling

NOTE: The --rm switch makes Docker delete the container once you exit the shell to avoid wasting storage space with a bunch of stopped containers.

# Persistent Storage
To access the files created by the various tools and have a backend database for use for tools such as metasploit. Most importantly, restoring after spinning the containers up and down.

## Postgresql
This will be separate image from kali image, so there is little need for customization.

REF: https://medium.com/@basit26374/how-to-run-postgresql-in-docker-container-with-volume-bound-c141f94e4c5a

    > docker pull postgres

### Postgres Volume
Create a volumes folder

    > mkdir -p <local host path>/postgres

#### Start the Postgres container
    > docker run --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v <local host path>/postgres:/var/lib/postgresql/data postgres

## Volumes

    > mkdir -p <local host path>/kali-data
    > docker run -it --name kali -v <local host path to>/kali-data:<path on container> kalirolling zsh
    
NOTE: The default path is based on whatever is set in the Dockerfile - WORKDIR /root

## Both
    > docker run -it --name kali -v <local host path to>/kali-data:/root -v <local host path to>/postgres:/var/lib/postgresql kalirolling zsh

# License
KaliDocker is currently under development by @sealmindset and it's released under the GPL 3 license.

