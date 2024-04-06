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
add-apt-repository -nyd jammy ppa:ubuntuhandbook1/gimp
add-apt-repository -nyd jammy ppa:kdenlive/kdenlive-stable
add-apt-repository -yd jammy ppa:obsproject/obs-studio
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
#add-apt-repository -yd jammy ppa:touchegg/stable
wget -cq --show-progress https://ppa.launchpadcontent.net/touchegg/stable/ubuntu/pool/main/t/touchegg/"$(wget -qO- https://ppa.launchpadcontent.net/touchegg/stable/ubuntu/pool/main/t/touchegg/|grep 22.04|grep amd64.deb|tail -n1|cut -d '"' -f8)" #tmp-fix
apt install -y touche ./touchegg*.deb
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