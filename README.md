# KaliDocker

A basic dockerfile for building the latest offical Kali docker image including common tools. The interactive shell is configured for oh-my-zsh.

## Setup

docker build -f Dockerfile -t kalirolling --no-cache .

## Execute

docker run -ti kalirolling
