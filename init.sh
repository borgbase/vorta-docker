#!/usr/bin/with-contenv sh
# Make sure mandatory directories exist.
mkdir -p /config/xdg/config/autostart
mkdir -p /config/xdg/cache 
mkdir -p /config/xdg/data
mkdir -p /config/.config/autostart

# Configure user home directory
usermod -d /config app

