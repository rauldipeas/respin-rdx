#!/bin/bash
set -e

# GNOME lite
apt autoremove --purge -y\
    gedit\
    gnome-startup-applications\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core\
    yaru*\
    yelp*
apt install -y\
    apturl\
    dmz-cursor-theme\
    file-roller\
    gir1.2-gmenu-3.0\
    gnome-backgrounds\
    gnome-calculator\
    gnome-characters\
    gnome-disk-utility\
    gnome-session\
    gnome-shell-extension-manager\
    gnome-system-monitor\
    gnome-text-editor\
    gthumb\
    nautilus\
    totem