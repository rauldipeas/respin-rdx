#!/bin/bash
set -e

# APT rollback
apt install -y apt-rollback

# Discovery
apt autoremove --purge -y plasma-discover-common

# Synaptic
apt install -y synaptic

# Timeshift
apt install -y timeshift

# UnRAR
apt install -y unrar

# Xubuntu extras
if [ -f /usr/share/xsessions/xubuntu.desktop ]; then
    add-apt-repository -y ppa:xubuntu-dev/extras
    apt install -y xfce4-appmenu-plugin xfce4-docklike-plugin
fi