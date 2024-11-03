#!/bin/bash
set -e
apt autoremove --purge -y\
    "*apache*"\
    gnome-accessibility-themes\
    gnome-icon-theme\
    gnome-remote-desktop\
    "*im-config*"\
    libfishcamp1\
    libsbig4\
    network-manager-gnome\
    pipewire-pulse\
    rygel\
    wireplumber\
    "*yelp*"