#!/bin/bash
set -e
wget -q --show-progress https://github.com/rauldipeas/respin-rdx/raw/main/assets/compressed/Bibata.tar.xz
tar -xf Bibata.tar.xz
mv Bibata-* /usr/share/icons/
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Bibata-Modern-Ice/cursor.theme 100
update-alternatives --set x-cursor-theme /usr/share/icons/Bibata-Modern-Ice/cursor.theme