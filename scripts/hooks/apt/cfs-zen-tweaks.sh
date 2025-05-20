#!/usr/bin/bash
set -e
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/igo95862/cfs-zen-tweaks/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
apt install -y ./cfs-zen-tweaks*.deb
rm cfs-zen-tweaks*.deb
systemctl enable set-cfs-tweaks.service