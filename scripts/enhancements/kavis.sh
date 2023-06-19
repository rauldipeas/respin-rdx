#!/bin/bash
set -e

# Kubuntu Audio Video Image Studio
apt autoremove --purge -y\
    elisa*\
    kmahjongg*\
    kmines*\
    konversation*\
    kpat*\
    krdc*\
    ksudoku*\
    libreoffice-math*\
    muon*\
    partitionmanager*\
    pavucontrol*\
    skanlite*\
    usb-creator*\
    vlc*\
    xterm*
dpkg --add-architecture i386
wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
apt install ./kxstudio-repos*.deb
add-apt-repository -ny ppa:ubuntuhandbook1/gimp
add-apt-repository -ny ppa:kdenlive/kdenlive-stable
add-apt-repository -y ppa:obsproject/obs-studio
echo 'jackd2 jackd/tweak_rt_limits string true'|sudo debconf-set-selections
apt install -y\
    4kvideodownloader\
    audacity\
    cadence\
    cockos-reaper\
    gimp\
    glaxnimate\
    inkscape\
    iriunwebcam\
    kcolorchooser\
    kdenlive\
    krename\
    mediainfo\
    mediainfo-gui\
    mplayer\
    neurontube\
    obs-studio\
    q4wine\
    shotwell\
    smplayer\
    spotube\
    tonelib*\
    tuxguitar\
    yabridge\
    wine-tkg\
    winetricks
mkdir -p /etc/skel/.audacity-data/Theme
wget -q --show-progress -O /etc/skel/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
mkdir -p /etc/skel/.config/REAPER/{LangPack,UserPlugins}
wget -q --show-progress -O /etc/skel/.config/REAPER/LangPack/pt-BR.ReaperLangPack https://stash.reaper.fm"$(wget -qO- https://stash.reaper.fm/tag/Language-Packs|grep pt-BR|head -n1|cut -d '"' -f2|sed 's/\/v//g')"
wget -q --show-progress https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
tar fx sws-*-Linux-x86_64-*.tar.xz -C /etc/skel/.config/REAPER
wget -q --show-progress -O /etc/skel/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"
cat <<EOF |tee /etc/apt/apt.conf.d/100iriunwebcam-icon>/dev/null
DPkg::Post-Invoke {"sed -i 's/Icon=iriunwebcam/Icon=webcamoid/g' /usr/share/applications/iriunwebcam.desktop";};
EOF
apt autoremove --purge -y meterbridge