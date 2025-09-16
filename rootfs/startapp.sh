#!/bin/sh

export HOME=/config


while true
do
    touch /config/xdg/state/Vorta/log/vorta.log && tail -f /config/xdg/state/Vorta/log/vorta.log &
    # Start Vorta
    vorta 
done