#!/bin/bash
set -e
apt autoremove --purge -y\
    apache2-bin\
    gnome-accessibility-themes\
    gnome-icon-theme\
    gnome-remote-desktop\
    im-config\
    libfishcamp1\
    libsbig4\
    libyelp0\
    network-manager-gnome\
    "*nvidia*"\
    pipewire-pulse\
    raspi-firmware\
    rygel\
    wireplumber\
    yelp\
    yelp-xsl