#!/bin/bash
set -e

# GNOME lite Rolling
apt autoremove --purge -y\
    gedit*\
    gnome-startup-applications*\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core*\
    yaru*
sed -i 's/jammy/devel/g' /etc/apt/sources.list
dpkg --add-architecture i386
apt update
apt dist-upgrade -y
apt install -y\
    apturl\
    dmz-cursor-theme\
    file-roller\
    gir1.2-gmenu-3.0\
    gnome-backgrounds\
    gnome-calculator\
    gnome-control-center\
    gnome-characters\
    gnome-disk-utility\
    gnome-session\
    gnome-shell-extension-manager\
    gnome-system-monitor\
    gnome-text-editor\
    gthumb\
    nautilus\
    totem\
    wireplumber\
    xdg-user-dirs-gtk
wget -q --show-progress https://cdn.akamai.steamstatic.com/client/installer/steam.deb
apt install -y ./steam.deb
wget -q --show-progress https://github.com/tkashkin/Adwaita-for-Steam/archive/master.zip
mkdir -p /etc/skel/.local/share/Steam/skins
unzip master.zip -d /etc/skel/.local/share/Steam/skins/
apt autoremove --purge -y yelp*