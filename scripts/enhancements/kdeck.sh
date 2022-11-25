#!/bin/bash
set -e

# Kubuntu Deck
apt autoremove --purge -y\
    elisa*\
    kdeconnect*\
    kmahjongg*\
    kmines*\
    konversation*\
    kpat*\
    krdc*\
    ksudoku*\
    ktorrent*\
    libreoffice*\
    partitionmanager*\
    skanlite*\
    usb-creator*
dpkg --add-architecture i386
sudo add-apt-repository -y ppa:libretro/stable
wget -q --show-progress -O emulationstation-de_x64.deb $(wget -qO- https://es-de.org|grep x64.deb|cut -d '"' -f8)
apt install -y\
    ./emulationstation-de_x64.deb\
    gamemode\
    heroic\
    libssl1.1\
    retroarch\
    steam-installer
wget -q "$(wget -qO- https://api.github.com/repos/flightlessmango/MangoHud/releases|grep browser_download_url|grep download/v|grep tar.gz|head -n1|cut -d '"' -f4)"
tar fxz MangoHud*.tar.gz
cd MangoHud
./mangohud-setup.sh install
deb-get install stremio
apt autoremove --purge -y mpv*