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
apt install --no-install-recommends -y ubuntudde-desktop
#apt install -y\
#apt autoremove --purge -y yelp*