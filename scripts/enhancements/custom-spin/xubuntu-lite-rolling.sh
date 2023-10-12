#!/bin/bash
set -e

# Xubuntu Lite Rolling
apt remove --purge -y\
    gimp\
    hexchat*\
    gnome-mines\
    gnome-sudoku\
    libreoffice*\
    parole\
    rhythmbox*\
    sgt-launcher\
    simple-scan\
    transmission*\
    xfburn\
    xfce4-dict
sed -i 's/jammy/devel/g' /etc/apt/sources.list
apt update
export DEBIAN_FRONTEND=noninteractive
cat <<EOF |tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
apt dist-upgrade -y -o Dpkg::Options::="--force-confold" --allow
rm /etc/apt/preferences.d/nosnap.pref
apt install -y\
    mplayer\
    redshift-gtk\
    smplayer
apt autoremove --purge -y yelp*