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
apt install --no-install-recommends -y cinnamon-core w3m
apt install -y\
    apturl\
    cinnamon-l10n\
    dmz-cursor-theme\
    gedit\
    gnome-calculator\
    gnome-characters\
    gnome-disk-utility\
    gnome-system-monitor\
    gnome-mpv\
    gthumb\
    materia-gtk-theme\
    nemo-fileroller
apt autoremove --purge -y mpv* yelp*