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
    convert -density 500 -background none\
    /usr/share/icons/Papirus/22x22/panel/steam_tray_mono.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Kubuntu ];then
    convert -density 500 -background none\
    /usr/share/icons/Papirus/48x48/apps/distributor-logo-kubuntu.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Xubuntu ];then
    convert -density 500 -background none\
    /usr/share/icons/Papirus/48x48/apps/distributor-logo-xubuntu.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Neon ];then
    convert -density 500 -background none\
    /usr/share/icons/Papirus/48x48/apps/distributor-logo-neon.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UCL ];then
    convert -density 500 -background none\
    /usr/share/icons/Papirus/48x48/apps/ubuntu-tweak.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UGL ];then
    convert -density 500 -background none\
    /usr/share/icons/Papirus/48x48/apps/desktop-environment-gnome.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UGLR ];then
    convert -density 500 -background none\
    /usr/share/icons/Papirus/48x48/apps/desktop-environment-gnome.svg\
    /usr/share/plymouth/themes/vortex-ubuntu/logo.png
fi