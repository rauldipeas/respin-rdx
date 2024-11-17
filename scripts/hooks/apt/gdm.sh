#!/bin/bash
set -e
apt install -y git imagemagick
git clone --depth=1 --single-branch https://github.com/realmazharhussain/gdm-tools
cd gdm-tools
echo y|./install.sh
mkdir -p /usr/share/backgrounds/gdm
convert /usr/share/backgrounds/unsplash/john-towner-JgOeRuGD_Y4-unsplash.jpg -blur 0x60 /usr/share/backgrounds/gdm/blurred_unsplash-gdm.jpg
set-gdm-theme set Orchis-Dark-Compact /usr/share/backgrounds/gdm/blurred_unsplash-gdm.jpg
echo y|./uninstall.sh --purge
cd ..
rm -rf gdm-tools
apt autoremove --purge -y git imagemagick
wget -qO /etc/gdm3/greeter.dconf-defaults https://github.com/rauldipeas/respin-rdx/raw/main/settings/dconf-greeter.ini