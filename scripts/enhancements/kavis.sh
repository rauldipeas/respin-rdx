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
    muon*\
    partitionmanager*\
    pavucontrol*\
    skanlite*\
    usb-creator*\
    vlc*
dpkg --add-architecture i386
wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
apt install ./kxstudio-repos*.deb
add-apt-repository -ny multiverse
add-apt-repository -ny universe
add-apt-repository -ny ppa:ubuntuhandbook1/gimp
add-apt-repository -ny ppa:kdenlive/kdenlive-stable
add-apt-repository -y ppa:obsproject/obs-studio
echo 'jackd2 jackd/tweak_rt_limits string true'|sudo debconf-set-selections
apt install -y\
    4kvideodownloader\
    cadence\
    cockos-reaper\
    gimp\
    inkscape\
    iriunwebcam\
    kcolorchooser\
    kdenlive\
    krename\
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
mkdir -p /etc/skel/.config/REAPER/{LangPack,UserPlugins}
wget -q --show-progress -O /etc/skel/.config/REAPER/LangPack/pt-BR.ReaperLangPack https://stash.reaper.fm"$(wget -qO- https://stash.reaper.fm/tag/Language-Packs|grep pt-BR|head -n1|cut -d '"' -f2|sed 's/\/v//g')"
wget -q --show-progress https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
tar fx sws-*-Linux-x86_64-*.tar.xz -C /etc/skel/.config/REAPER
wget -q --show-progress -O /etc/skel/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"
cat <<EOF |tee /etc/apt/apt.conf.d/100iriunwebcam-icon>/dev/null
DPkg::Post-Invoke {"sed -i 's/Icon=iriunwebcam/Icon=webcamoid/g' /usr/share/applications/iriunwebcam.desktop";};
EOF

#if [ -f /usr/bin/mainline ]; then
#    apt install gcc-12
#    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12
#    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11
#    wget -qc --show-progress http://mirrors.kernel.org/ubuntu/pool/universe/v/v4l2loopback/$(wget -qO- http://mirrors.kernel.org/ubuntu/pool/universe/v/v4l2loopback/|grep v4l2loopback-dkms|grep .deb|tail -n4|head -n1|cut -d '"' -f2)
#    apt install ./v4l2loopback-dkms*.deb
#fi