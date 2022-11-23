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
sudo add-apt-repository -y ppa:daniruiz/flat-remix
apt install --no-install-recommends -y cinnamon-core w3m
apt install -y\
    apturl\
    cinnamon-l10n\
    dmz-cursor-theme\
    flat-remix-gtk\
    gedit\
    gnome-calculator\
    gnome-characters\
    gnome-disk-utility\
    gnome-system-monitor\
    gnome-mpv\
    gthumb\
    nemo-fileroller\
    python3-polib\
    xdg-user-dirs-gtk
apt autoremove --purge -y mpv* yelp*