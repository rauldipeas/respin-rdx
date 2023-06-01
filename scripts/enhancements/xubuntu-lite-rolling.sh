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
    transmission*\
    xfburn
sed -i 's/jammy/devel/g' /etc/apt/sources.list
dpkg --add-architecture i386
apt update
export DEBIAN_FRONTEND=noninteractive
cat <<EOF |tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
apt dist-upgrade -y -o Dpkg::Options::="--force-confold" --force-yes
rm /etc/apt/preferences.d/nosnap.pref
apt install -y\
    aspell-pt-br\
    gamemode\
    mplayer\
    redshift-gtk\
    smplayer\
    xfdashboard
add-apt-repository -y ppa:libredeb/lightpad
apt install -y com.github.libredeb.lightpad
wget -q --show-progress https://cdn.akamai.steamstatic.com/client/installer/steam.deb
apt install -y ./steam.deb
wget -q --show-progress "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/flightlessmango/MangoHud/releases|grep browser_download_url|grep tar.gz|head -n1|cut -d '"' -f4)"
tar fxz MangoHud*.tar.gz
cd MangoHud
./mangohud-setup.sh install
apt autoremove --purge -y yelp*