#!/bin/bash
set -e

# Alpha 0.2
sudo nala install -y -t bookworm-backports\
    linux-headers-rt\
    linux-image-rt
sudo nala install -y\
    rtirq-init
am -i cryptomator

# 09/03/2025 | 19:38
am -r mission-center
am -i --icons mission-center
sed -i 's|Icon=mission-center|Icon=io.missioncenter.MissionCenter|' /usr/local/share/applications/mission-center-AM.desktop
cat <<EOF |tee -a /usr/local/share/applications/mission-center-AM.desktop
StartupWMClass=missioncenter
EOF