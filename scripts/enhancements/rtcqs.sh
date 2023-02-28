#!/bin/bash
set -e

# rtcqs
apt install -y python3-pip python3-tk
pip install -q rtcqs
wget -q --show-progress -O /usr/share/applications/rtcqs.desktop https://github.com/autostatic/rtcqs/raw/main/rtcqs.desktop
wget -q --show-progress -O /usr/share/icons/rtcqs.svg https://github.com/autostatic/rtcqs/raw/main/rtcqs_logo.svg

# CPU DMA latency
wget -q --show-progress -O /etc/udev/rules.d/99-cpu-dma-latency.rules https://raw.githubusercontent.com/Ardour/ardour/master/tools/udev/99-cpu-dma-latency.rules

# Extra groups
sed -i 's/#ADD_EXTRA_GROUPS=1/ADD_EXTRA_GROUPS=1/g' /etc/adduser.conf
sed -i 's/#EXTRA_GROUPS=/EXTRA_GROUPS=/g' /etc/adduser.conf

# GRUB
echo 'GRUB_CMDLINE_LINUX_DEFAULT="cpufreq.default_governor=performance logo.nologo loglevel=0 mitigations=off preempt=full quiet splash threadirqs vt.global_cursor_default=0 zswap.enabled=1 zswap.compressor=lz4"'|tee /etc/default/grub.d/cmdline-linux-default.cfg>/dev/null

# GVFS
sudo apt autoremove --purge -y gvfs-fuse

# Swappiness
echo 'vm.swappiness = 10'|tee /etc/sysctl.d/swappiness.conf>/dev/null

# XDG portal
mkdir -p /etc/skel/.config/systemd/user
ln -sf /dev/null /etc/skel/.config/systemd/user/xdg-desktop-portal.service