#!/bin/bash
set -e

# Vortex Plymouth
git clone -q https://github.com/emanuele-scarsella/vortex-ubuntu-plymouth-theme
cd vortex-ubuntu-plymouth-theme
chmod +x install
./install
cd ..
rm -rf vortex-ubuntu-plymouth-theme
sed -i 's/logo_image = logo_image.Scale (120 * s , 120 * s);/logo_image = logo_image.Scale (128 * s , 128 * s);/g' /usr/share/plymouth/themes/vortex-ubuntu/vortex-ubuntu.script
if [ -f /KDeck ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/kdeck.png
    convert -density 1200 -resize 128x128 -background none kdeck.png /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Kubuntu ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/kubuntu.svg
    convert -density 1200 -resize 128x128 -background none kubuntu.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Neon ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/neon.svg
    convert -density 1200 -resize 128x128 -background none neon.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UCL ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/ucl.svg
    convert -density 1200 -resize 128x128 -background none ucl.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Xubuntu ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/xubuntu.svg
    convert -density 1200 -resize 128x128 -background none xubuntu.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    else
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/ubuntu.svg
    convert -density 1200 -resize 128x128 -background none ubuntu.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
fi
update-initramfs -u -k all