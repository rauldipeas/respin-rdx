#!/bin/bash
set -e
apt install -y imagemagick
mkdir -p /usr/share/backgrounds/gdm
convert /usr/share/backgrounds/unsplash/john-towner-JgOeRuGD_Y4-unsplash.jpg -blur 0x60 /usr/share/backgrounds/gdm/blurred_unsplash-gdm.jpg
apt autoremove --purge -y imagemagick
wget -qO /etc/gdm3/greeter.dconf-defaults https://github.com/rauldipeas/respin-rdx/raw/main/settings/dconf-greeter.ini