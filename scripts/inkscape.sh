#!/bin/bash
set -e

## Inkscape
if  grep ii <(dpkg --list inkscape 2>/dev/null);then
    echo inkscape instalado!
    else
    cat <<EOF |sudo tee /etc/apt/preferences.d/imagemagick.pref>/dev/null
Package: imagemagick
Pin: release a=*
Pin-Priority: -10

Package: imagemagick:i386
Pin: release a=*
Pin-Priority: -10

Package: imagemagick-6.q16
Pin: release a=*
Pin-Priority: -10

Package: imagemagick-6.q16:i386
Pin: release a=*
Pin-Priority: -10
EOF
    sudo apt install -y	inkscape
    sudo rm /etc/apt/preferences.d/imagemagick.pref
fi