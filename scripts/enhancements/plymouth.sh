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
apt install -y imagemagick-6.q16
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
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/cinnamon.png
    convert -density 1200 -resize 128x128 -background none cinnamon.png /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UGL ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/gnome.svg
    convert -density 1200 -resize 128x128 -background none gnome.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /UGLR ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/custom.svg
    convert -density 1200 -resize 128x128 -background none custom.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /XLR ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/custom.svg
    convert -density 1200 -resize 128x128 -background none custom.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    elif [ -f /Xubuntu ];then
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/xubuntu.svg
    convert -density 1200 -resize 128x128 -background none xubuntu.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
    else
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/plymouth/ubuntu.svg
    convert -density 1200 -resize 128x128 -background none ubuntu.svg /usr/share/plymouth/themes/vortex-ubuntu/logo.png
fi
apt autoremove --purge -y imagemagick-6.q16
update-initramfs -u -k all