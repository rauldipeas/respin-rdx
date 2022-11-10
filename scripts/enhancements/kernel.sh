#!/bin/bash
set -e

# Linux Generic
apt autoremove --purge -y linux*generic*

# Linux RDX
#apt install -y linux-rdx
#update-initramfs -u -k "$(find /boot/|grep vmlinuz|grep -v old|tail -n1|sed 's@/boot/vmlinuz-@@g')"

# CFS Zen tweaks
apt install -y cfs-zen-tweaks
systemctl enable set-cfs-tweaks.service

# Mainline
add-apt-repository -y ppa:cappelikan/ppa
apt install -y amd64-microcode intel-microcode mainline
sed -i 's/Icon=mainline/Icon=mintsources-ppa/g' /usr/share/applications/mainline.desktop
mainline --install-latest