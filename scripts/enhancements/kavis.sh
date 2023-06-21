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
apt install -y ./kxstudio-repos*.deb
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
    kwin-bismuth\
    libgegl-0.4-0\
    libmypaint-1.5-1\
    mediainfo\
    mediainfo-gui\
    mini-video-me\
    mplayer\
    mystiq\
    neurontube\
    obs-studio\
    plasma-hud\
    q4wine\
    shotwell\
    sfizz\
    simplescreenrecorder\
    smplayer\
    spotube\
    tonelib*\
    tuxguitar\
    yabridge\
    wine-tkg\
    winetricks\
    zenity
#add-apt-repository -y ppa:touchegg/stable
wget -cq --show-progress https://ppa.launchpadcontent.net/touchegg/stable/ubuntu/pool/main/t/touchegg/"$(wget -qO- https://ppa.launchpadcontent.net/touchegg/stable/ubuntu/pool/main/t/touchegg/|grep 22.04|grep amd64.deb|tail -n1|cut -d '"' -f8)" #tmp-fix
apt install -y touche ./touchegg*.deb
wget -q --show-progress http://mirrors.kernel.org/ubuntu/pool/universe/p/plasma-welcome/"$(wget -qO- http://mirrors.kernel.org/ubuntu/pool/universe/p/plasma-welcome|grep amd64.deb|tail -n1|cut -d '"' -f2)"
apt install -y ./plasma-welcome*.deb
mkdir -p /etc/skel/.audacity-data/Theme
wget -q --show-progress -O /etc/skel/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
cat <<EOF |tee /etc/skel/.audacity-data/audacity.cfg
[GUI]
Theme=custom
EOF
mkdir -p /etc/skel/.config/REAPER/{LangPack,UserPlugins}
wget -q --show-progress -O /etc/skel/.config/REAPER/LangPack/pt-BR.ReaperLangPack https://stash.reaper.fm"$(wget -qO- https://stash.reaper.fm/tag/Language-Packs|grep pt-BR|head -n1|cut -d '"' -f2|sed 's/\/v//g')"
wget -q --show-progress https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
tar fx sws-*-Linux-x86_64-*.tar.xz -C /etc/skel/.config/REAPER
wget -q --show-progress -O /etc/skel/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"
cat <<EOF |tee /etc/apt/apt.conf.d/100iriunwebcam-icon>/dev/null
DPkg::Post-Invoke {"sed -i 's/Icon=iriunwebcam/Icon=webcamoid/g' /usr/share/applications/iriunwebcam.desktop";};
EOF
apt autoremove --purge -y meterbridge