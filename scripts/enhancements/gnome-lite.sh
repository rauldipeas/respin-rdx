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
    yaru*
apt install -y\
    apturl\
    dmz-cursor-theme\
    file-roller\
    gnome-backgrounds\
    gnome-calculator\
    gnome-characters\
    gnome-disk-utility\
    gnome-session\
    gnome-system-monitor\
    gnome-text-editor\
    gthumb\
    nautilus\
    totem