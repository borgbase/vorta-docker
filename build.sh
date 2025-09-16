#!/usr/bin/env bash

# play nice with other processes
MYPID=$$
renice -n 19 -p $MYPID
ionice -c 3 -p $MYPID

docker pull jlesage/baseimage-gui:alpine-3.22-v4
# For testing local builds use the local label
DOCKER_BUILDKIT=1 docker build . -t nas:5000/vorta-docker:local
# docker image push storage:5000/vorta-docker:local
