#!/bin/bash
set -e
echo 'deb http://ppa.launchpad.net/xubuntu-dev/extras/ubuntu jammy main'|tee /etc/apt/sources.list.d/xubuntu-dev-extras.list
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x53337a2d3790f409a00fe5bc4ed101bbe463faab'|gpg --dearmor -o /etc/apt/trusted.gpg.d/xubuntu-dev-extras.gpg
apt update
apt install -y --no-install-recommends \
    mugshot \
    network-manager-gnome \
    pavucontrol \
    volumeicon-alsa \
    xfce4-docklike-plugin \
    xfce4-panel \
    xfce4-power-manager \
    xfce4-session \
    xfce4-settings \
    xfce4-whiskermenu-plugin \
    xfdesktop4 \
    xfwm4
wget -qO- "$(wget -qO- https://api.github.com/repos/leukipp/cortile/releases/latest|jq -r '.assets[] | select(.name | contains ("linux_amd64.tar.gz")) | .browser_download_url')"|tar -xz
rm LICENSE README.md
mv cortile /usr/local/bin
cat <<EOF |tee /etc/xdg/autostart/cortile.desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=cortile
Name=Cortile
Exec=cortile
OnlyShowIn=XFCE;
EOF
cat <<EOF |tee /etc/xdg/autostart/volumeicon.desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=volumeicon
Name=Volume icon (ALSA)
Exec=volumeicon
OnlyShowIn=XFCE;
EOF