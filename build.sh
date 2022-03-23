#!/usr/bin/env bash

# play nice with other processes
MYPID=$$
renice -n 19 -p $MYPID
ionice -c 3 -p $MYPID

docker pull jlesage/baseimage-gui:alpine-3.12
# For testing local builds use the local label
docker build . -t ghcr.io/borgbase/vorta-docker:local




