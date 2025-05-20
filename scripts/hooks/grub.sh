#!/usr/bin/bash
set -e
wget -q --show-progress https://github.com/rauldipeas/respin-rdx/raw/main/assets/compressed/debian-1080p.zip
mkdir -p /usr/share/grub/themes
unzip debian-1080p.zip -d /usr/share/grub/themes
rm debian-1080p.zip /usr/share/grub/themes/darkmatter-theme.py
mkdir /etc/default/grub.d
cat <<EOF |tee /etc/default/grub.d/theme.cfg>/dev/null
GRUB_THEME="/usr/share/grub/themes/darkmatter/theme.txt"
GRUB_BACKGROUND=""
EOF