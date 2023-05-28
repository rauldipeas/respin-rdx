#!/bin/bash
set -e

# Vortex Plymouth
git clone -q https://github.com/emanuele-scarsella/vortex-ubuntu-plymouth-theme
cd vortex-ubuntu-plymouth-theme
chmod +x install
./install
cd ..
rm -rf vortex-ubuntu-plymouth-theme
if [ -f /KDeck ];then
    rsvg-convert -w 376 -h 376 -o\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png\
    /usr/share/icons/Papirus/22x22/panel/steam_tray_mono.svg
    else
    wget -q --show-progress https://www.linuxadictos.com/en/wp-content/Uploads/ubuntu.svg
    rsvg-convert -o /usr/share/plymouth/themes/vortex-ubuntu/logo.png ubuntu.svg
fi