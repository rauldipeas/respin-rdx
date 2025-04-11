#!/bin/bash
set -e

# Alpha 0.2
sudo nala install -y -t bookworm-backports\
    linux-headers-rt-amd64\
    linux-image-rt-amd64 #;sudo nala autoremove --purge linux*generic*
sudo nala install -y\
    rtirq-init
am -i cryptomator #;sudo nala autoremove --purge veracrypt

# 09/03/2025 | 19:38
am icons mission-center
sudo sed -i 's|Icon=mission-center|Icon=io.missioncenter.MissionCenter|' /usr/local/share/applications/mission-center-AM.desktop
cat <<EOF |sudo tee -a /usr/local/share/applications/mission-center-AM.desktop
StartupWMClass=missioncenter
EOF

# 10/04/2024 | 23:36
sudo apt install -y -t bookworm-backports nala
sudo nala install -y -t bookworm-backports\
    libgl1-mesa-dri \
    libglx-mesa0 \
    mesa-vulkan-drivers \
    mesa-va-drivers \
    mesa-utils \
    libegl-mesa0 \
    libgbm1 \
    libglapi-mesa