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
#add-apt-repository ppa:ubuntuhandbook1/gimp
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xa0062203196ca4482ddb859e4c1cbe14852541cb'|gpg --dearmor -o /etc/apt/trusted.gpg.d/ubuntuhandbook1-gimp.gpg
echo 'deb https://ppa.launchpadcontent.net/ubuntuhandbook1/gimp/ubuntu jammy main'|tee /etc/apt/sources.list.d/ubuntuhandbook1-gimp.list
#add-apt-repository ppa:kdenlive/kdenlive-stable
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xa59e5ebfccc61564d6d4365b2763b0ee7709fe97'|gpg --dearmor -o /etc/apt/trusted.gpg.d/kdenlive-kdenlive-stable.gpg
echo 'deb https://ppa.launchpadcontent.net/kdenlive/kdenlive-stable/ubuntu jammy main'|tee /etc/apt/sources.list.d/kdenlive-kdenlive-stable.list
#add-apt-repository ppa:obsproject/obs-studio
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xbc7345f522079769f5bbe987efc71127f425e228'|gpg --dearmor -o /etc/apt/trusted.gpg.d/obsproject-obs-studio.gpg
echo 'deb https://ppa.launchpadcontent.net/obsproject/obs-studio/ubuntu jammy main'|tee /etc/apt/sources.list.d/obsproject-obs-studio.list
apt update -qq
echo 'jackd2 jackd/tweak_rt_limits string true'|sudo debconf-set-selections
apt install -y\
    4kvideodownloader\
    audacity\
    cadence\
    cockos-reaper\
    filelight\
    gimp\
    glaxnimate\
    inkscape\
    iriunwebcam\
    kcolorchooser\
    kdenlive\
    krename\
    kubuntu-settings-desktop\
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
    rustdesk\
    shotwell\
    sfizz\
    simplescreenrecorder\
    smplayer\
    tonelib*\
    tuxguitar\
    yabridge\
    wine-tkg\
    winetricks\
    zenity
#wget -cq --show-progress https://ppa.launchpadcontent.net/touchegg/stable/ubuntu/pool/main/t/touchegg/"$(wget -qO- https://ppa.launchpadcontent.net/touchegg/stable/ubuntu/pool/main/t/touchegg/|grep 22.04|grep amd64.deb|tail -n1|cut -d '"' -f8)" #tmp-fix
#apt install -y touche ./touchegg*.deb
#add-apt-repository ppa:touchegg/stable
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x7ea12677d47b593ce22727d4c0fce32af6b96252'|gpg --dearmor -o /etc/apt/trusted.gpg.d/touchegg-stable.gpg
echo 'deb https://ppa.launchpadcontent.net/touchegg/stable/ubuntu jammy main'|tee /etc/apt/sources.list.d/touchegg-stable.list
apt update -qq
apt install -y touchegg
wget -q --show-progress http://mirrors.kernel.org/ubuntu/pool/universe/p/plasma-welcome/"$(wget -qO- http://mirrors.kernel.org/ubuntu/pool/universe/p/plasma-welcome|grep amd64.deb|tail -n1|cut -d '"' -f2)"
apt install -y ./plasma-welcome*.deb
mkdir -p /etc/skel/.audacity-data/Theme
wget -q --show-progress -O /etc/skel/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
cat <<EOF |tee /etc/apt/apt.conf.d/100iriunwebcam-icon>/dev/null
DPkg::Post-Invoke {"sed -i 's/Icon=iriunwebcam/Icon=webcamoid/g' /usr/share/applications/iriunwebcam.desktop";};
EOF
cat <<EOF |tee /etc/apt/apt.conf.d/100rustdesk-icon>/dev/null
DPkg::Post-Invoke {"sed -i 's@Icon=/usr/share/rustdesk/files/rustdesk.png@Icon=rustdesk@g' /usr/share/applications/rustdesk.desktop";};
EOF
cat <<EOF |tee /etc/skel/.audacity-data/audacity.cfg
[GUI]
Theme=custom
EOF
cat <<EOF |tee /etc/skel/.config/kdenliverc
[UiSettings]
ColorSchemePath=
EOF
mkdir -p /etc/skel/.config/REAPER/{ColorThemes,LangPack,Scripts/Cockos,UserPlugins} /opt/REAPER/fonts
cat <<EOF |tee /etc/skel/.config/REAPER/reaper.ini>/dev/null
[REAPER]
lastthemefn5="$HOME"/.config/REAPER/ColorThemes/Smooth_6_Dark.ReaperTheme
EOF
ln -s /opt/REAPER/fonts /usr/share/fonts/reaper-smooth-theme
wget -q --show-progress -O Smooth\ 6\ V2.1.zip 'https://www.dropbox.com/s/7eqaousbr0fnkfx/Smooth%206%20V2.1.zip?dl=1'
unzip Smooth\ 6\ V2.1.zip -d smooth-reaper-theme
mv smooth-reaper-theme/Smooth\ 6\ V2.1/1-Fonts/Mac /opt/REAPER/fonts
mv smooth-reaper-theme/Smooth\ 6\ V2.1/2-Theme\ Adjuster/Smooth_6_theme_adjuster.lua /etc/skel/.config/REAPER/Scripts/Cockos/
mv smooth-reaper-theme/Smooth\ 6\ V2.1/2-Theme\ Adjuster/Smooth_6_Dark_theme_adjuster.lua /etc/skel/.config/REAPER/Scripts/Cockos/
mv smooth-reaper-theme/Smooth\ 6\ V2.1/3-Theme/Smooth_6.ReaperThemeZip /etc/skel/.config/REAPER/ColorThemes/
cp smooth-reaper-theme/Smooth\ 6\ V2.1/3-Theme/Smooth_6_Dark.ReaperTheme /etc/skel/.config/REAPER/ColorThemes/
wget -q --show-progress -O /etc/skel/.config/REAPER/LangPack/pt-BR.ReaperLangPack https://stash.reaper.fm"$(wget -qO- https://stash.reaper.fm/tag/Language-Packs|grep '/pt-BR.ReaperLangPack'|tail -n1|cut -d '"' -f2|sed 's/\/v//g')"
wget -q --show-progress https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
tar fx sws-*-Linux-x86_64-*.tar.xz -C /etc/skel/.config/REAPER
wget -q --show-progress -O /etc/skel/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"
apt autoremove --purge -y meterbridge