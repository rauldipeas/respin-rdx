#!/bin/bash
set -e

## CFS Zen tweaks
if  grep ii <(dpkg --list cfs-zen-tweaks 2>/dev/null);then
    echo cfs-zen-tweaks instalado!
    else
    rm -f cfs-zen-tweaks*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/igo95862/cfs-zen-tweaks/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./cfs-zen-tweaks*.deb
    rm cfs-zen-tweaks*.deb
    sudo systemctl enable set-cfs-tweaks.service
    sudo systemctl start set-cfs-tweaks.service
fi