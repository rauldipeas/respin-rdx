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
#add-apt-repository -yd jammy ppa:libretro/stable
apt update
#wget -q --show-progress https://cdn.akamai.steamstatic.com/client/installer/steam.deb
apt install -y\
    gamemode\
    steamos-compositor-plus
#    ./steam.deb\
#    boilr\
#    emulationstation-de\
#    filelight\
#    mplayer\
#    retroarch\
#    smplayer\
apt update
apt install -y\
    libgl1-mesa-glx:i386
    #steam-libs-amd64\
    #steam-libs-i386:i386
wget -q --show-progress "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/flightlessmango/MangoHud/releases|grep browser_download_url|grep tar.gz|head -n1|cut -d '"' -f4)"
tar fxz MangoHud*.tar.gz
cd MangoHud
./mangohud-setup.sh install
flatpak install --assumeyes --noninteractive\
    com.valvesoftware.Steam\
    info.smplayer.SMPlayer\
    io.github.philipk.boilr\
    org.kde.filelight
#    com.steamgriddb.steam-rom-manager\
#    org.libretro.RetroArch
#    org.freedesktop.Platform.VulkanLayer.MangoHud//23.08\