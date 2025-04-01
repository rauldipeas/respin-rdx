#!/bin/bash
set -e

# Alpha 0.2
sudo nala install -y -t bookworm-backports\
    linux-headers-rt\
    linux-image-rt #;sudo nala autoremove --purge linux*generic*
sudo nala install -y\
    rtirq-init
am -i cryptomator #;sudo nala autoremove --purge veracrypt

# 09/03/2025 | 19:38
am icons mission-center
sudo sed -i 's|Icon=mission-center|Icon=io.missioncenter.MissionCenter|' /usr/local/share/applications/mission-center-AM.desktop
cat <<EOF |sudo tee -a /usr/local/share/applications/mission-center-AM.desktop
StartupWMClass=missioncenter
EOF