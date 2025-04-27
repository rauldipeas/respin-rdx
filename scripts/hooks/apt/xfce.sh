#!/bin/bash
set -e
echo 'deb http://ppa.launchpad.net/xubuntu-dev/extras/ubuntu jammy main'|tee /etc/apt/sources.list.d/xubuntu-dev-extras.list
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x53337a2d3790f409a00fe5bc4ed101bbe463faab'|gpg --dearmor -o /etc/apt/trusted.gpg.d/xubuntu-dev-extras.gpg
apt update
apt install -y --no-install-recommends xfce4
apt install -y \
    mugshot \
    network-manager-gnome \
    pavucontrol \
    volumeicon-alsa \
    xfce4-docklike-plugin \
    xfce4-power-manager \
    xfce4-whiskermenu-plugin
wget -qO- "$(wget -qO- https://api.github.com/repos/leukipp/cortile/releases/latest|jq -r '.assets[] | select(.name | contains ("linux_amd64.tar.gz")) | .browser_download_url')"|tar -xz
rm LICENSE README.md
mv cortile /usr/local/bin