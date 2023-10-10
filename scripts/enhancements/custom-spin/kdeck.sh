#!/bin/bash
set -e

# Kubuntu Deck
apt autoremove --purge -y\
    elisa*\
    kde-config-tablet*\
    kdeconnect*\
    kmahjongg*\
    kmines*\
    konversation*\
    kpat*\
    krdc*\
    ksudoku*\
    ktorrent*\
    libreoffice*\
    muon*\
    partitionmanager*\
    pavucontrol*\
    skanlite*\
    usb-creator*\
    vlc*
dpkg --add-architecture i386
#add-apt-repository -y ppa:libretro/stable
apt update
wget -q --show-progress https://cdn.akamai.steamstatic.com/client/installer/steam.deb
apt install -y\
    boilr\
    emulationstation-de\
    filelight\
    gamemode\
    libgl1-mesa-glx:i386\
    mplayer\
    smplayer\
    ./steam.deb\
    steamos-compositor-plus
#    retroarch\
apt update
apt install -y\
    steam-libs-amd64\
    steam-libs-i386:i386
flatpak install -y org.libretro.RetroArch
wget -q --show-progress "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/flightlessmango/MangoHud/releases|grep browser_download_url|grep tar.gz|head -n1|cut -d '"' -f4)"
tar fxz MangoHud*.tar.gz
cd MangoHud
./mangohud-setup.sh install

#io.github.philipk.boilr
#com.valvesoftware.Steam
#org.freedesktop.Platform.VulkanLayer.MangoHud