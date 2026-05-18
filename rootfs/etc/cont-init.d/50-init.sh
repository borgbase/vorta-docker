#!/bin/sh
# Make sure mandatory directories exist.
mkdir -p /config/xdg/config/autostart
mkdir -p /config/xdg/cache 
mkdir -p /config/xdg/data
mkdir -p /config/.config/autostart

# Configure user home directory
sed -i -r s/app\:\:\([0-9]+\):\([0-9]+\)::[^:]+:\(.+\)/app\:\:\\1\:\\2\:\:\\/config\:\\3/ /etc/passwd

