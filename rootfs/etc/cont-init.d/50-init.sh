#!/bin/sh
# Make sure mandatory directories exist.
mkdir -p /config/xdg/config/autostart
mkdir -p /config/xdg/cache 
mkdir -p /config/xdg/data
mkdir -p /config/.config/autostart

# Configure user home directory
usermod -d /config app

#ls -al /etc/
#ls -al /etc/cont-init.d/
#ls -al /etc/services.d/
