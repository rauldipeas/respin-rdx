#!/bin/bash
set -e
apt install -y git imagemagick
git clone --depth=1 --single-branch https://github.com/realmazharhussain/gdm-tools
cd gdm-tools
echo y|./install.sh
sed -i 's|IconTheme=Adwaita|Papirus-Dark|' /usr/share/themes/Adwaita/index.theme
sed -i 's|IconTheme=Adwaita|Papirus-Dark|' /usr/share/themes/Adwaita-dark/index.theme
convert /usr/share/backgrounds/unsplash/unsplash-gnome.jpg -blur 0x80 /usr/share/backgrounds/unsplash/blured_unsplash-gnome.jpg
set-gdm-theme set default /usr/share/backgrounds/unsplash/blured_unsplash-gnome.jpg
echo y|./uninstall.sh --purge
cd ..
rm -rf gdm-tools
apt autoremove --purge -y git imagemagick