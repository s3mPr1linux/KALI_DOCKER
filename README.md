# KaliDocker
While GUI has it's place, this image is CLI based.

There are two Dockerfile's to choose from. The first is a basic Kali docker image without the tools such as metasploit. The second, Dockerfile.msf is the full fledge Kali with all of the standard tools. Both can be customized to meet whatever the needs are.

A quick note, both are setup with the interactive shell as "oh-my-zsh". 

## Setup
First, grab this repo.

    > git clone https://github.com/sealmindset/KaliDocker.git
    > cd KaliDocker
    > docker build -f Dockerfile -t kalirolling --no-cache .

### Test
If no errors arises from the build, create a container to test if its operational, i.e., doesn't fail to start and oh-my-zsh prompt is waiting for you.

    > docker run -ti --rm kalirolling

NOTE: The --rm switch makes Docker delete the container once you exit the shell to avoid wasting storage space with a bunch of stopped containers.

# Persistent
To get access the files created by the various tools and have a backend database for use for tools such as metasploit, having something that

## Postgresql
This will be separate image from kali image, so there is little need for customization

    > docker pull postgres

### Postgres Volume
Create a volumes folder

    > mkdir -p <local host path>/postgres

#### Start the Postgres container
    > docker run --name pg-docker -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v <local host path>/postgres:/var/lib/postgresql/data postgres

## Volumes

    > mkdir -p <local host path>/kali-data
    > docker run -it --name kali -v <local host path>/kali-data:<path on container> kalirolling
    
NOTE: The default path is /root

# GNU General Public License
Except as otherwise specified:

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.

