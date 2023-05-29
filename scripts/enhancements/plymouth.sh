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
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/kdeck.png
    convert -background none kdeck.png /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Kubuntu ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/kubuntu.svg
    convert -density 80 -background none kubuntu.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Neon ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/neon.svg
    convert -density 40 -background none neon.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UCL ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/ucl.svg
    convert -density 400 -background none ucl.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Xubuntu ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/xubuntu.svg
    convert -density 20 -background none xubuntu.png /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    else
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/ubuntu.png
    convert -density 20 -background none ubuntu.png /usr/share/plymouth/themes/vortex-ubuntu/logo.png
fi
update-initramfs -u -k all