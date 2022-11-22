#!/bin/bash
set -e

# Cinnamon lite
apt autoremove --purge -y\
    gedit\
    gnome-startup-applications\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core\
    yaru*\
    yelp*
apt install --no-install-recommends -y cinnamon-desktop-environment
apt install -y\
    apturl\
    cinnamon-l10n\
    dmz-cursor-theme\
    gnome-disk-utility\
    gnome-mpv\
    materia-gtk-theme
#apt autoremove --purge -y yelp*