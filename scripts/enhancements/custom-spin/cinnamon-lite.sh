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
#add-apt-repository ppa:daniruiz/flat-remix
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xba309d7c0cbe9a2df584ac50a074f0583066c9c9'|gpg --dearmor -o /etc/apt/trusted.gpg.d/daniruiz-flat-remix.gpg
echo 'deb https://ppa.launchpadcontent.net/daniruiz/flat-remix/ubuntu jammy main'|tee /etc/apt/sources.list.d/daniruiz-flat-remix.list
apt update -qq
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