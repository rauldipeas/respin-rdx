#!/bin/bash
set -e

# DDE lite
apt autoremove --purge -y\
    gdm*\
    gedit*\
    gnome-startup-applications*\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core*\
    yaru*\
    yelp*
sudo add-apt-repository -y ppa:ubuntudde-dev/stable
apt install -y\
    ubuntudde-dde
#apt autoremove --purge -y yelp*