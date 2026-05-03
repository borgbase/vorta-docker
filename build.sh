#!/usr/bin/env bash

# play nice with other processes
MYPID=$$
renice -n 19 -p $MYPID
ionice -c 3 -p $MYPID

docker pull jlesage/baseimage-gui:alpine-3.22-v4
# For testing local builds use the local label
# user --no-cache if you want to force a rebuild of all layers, otherwise it will use the cache for unchanged layers
DOCKER_BUILDKIT=1 docker build . -t nas:5000/vorta-docker:local
# docker image push nas:5000/vorta-docker:local
