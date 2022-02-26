#!/usr/bin/env bash

# play nice with other processes
MYPID=$$
renice -n 19 -p $MYPID
ionice -c 3 -p $MYPID

docker pull jlesage/baseimage-gui:alpine-3.12
docker build -t marklambert/vorta:latest -t marklambert/vorta:$(date -I) .

RESULT=$?
if [ $RESULT -eq 0 ]; then
  docker push marklambert/vorta:latest
  docker push marklambert/vorta:$(date -I)
else
  echo failed
fi




