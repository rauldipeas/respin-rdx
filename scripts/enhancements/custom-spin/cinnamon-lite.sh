#!/bin/bash
set -e

# Cinnamon lite
apt autoremove --purge -y\
    gdm*\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core*\
    yaru*
LC_ALL=C.UTF-8 add-apt-repository -y ppa:daniruiz/flat-remix
apt install --no-install-recommends -y cinnamon-core w3m
apt install -y\
    apturl\
    cinnamon-l10n\
    dmz-cursor-theme\
    flat-remix-gtk\
    gnome-calculator\
    gnome-characters\
    gnome-disk-utility\
    gnome-system-monitor\
    gthumb\
    lightdm\
    lightdm-gtk-greeter\
    mplayer\
    nemo-fileroller\
    python3-polib\
    smplayer\
    xdg-user-dirs-gtk
apt autoremove --purge -y\
    gnome-startup-applications*\
    mpv*\
    yelp*