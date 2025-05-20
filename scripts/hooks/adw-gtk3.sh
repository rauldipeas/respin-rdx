#!/bin/bash
set -e
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/lassekongo83/adw-gtk3/releases|grep browser_download_url|grep .tar.xz|head -n1|cut -d '"' -f4)"
mkdir -p /usr/local/share/themes
tar -xf adw-gtk3*.tar.xz -C /usr/local/share/themes/
rm adw-gtk3*.tar.xz