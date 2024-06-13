#!/bin/bash
set -e

## Kega Fusion
if  grep ii <(dpkg --list kega-fusion 2>/dev/null);then
    echo kega-fusion instalado!
    else
    rm -f Kega-fusion*.deb>/dev/null
    wget -q --show-progress https://retrocdn.net/images/c/ca/Kega-fusion_3.63-2_i386.deb
    sudo apt install -y ./Kega-fusion*.deb
    rm Kega-fusion*.deb
    sudo sed -i 's/kega-fusion.png/kega-fusion/g' /usr/share/applications/kega-fusion.desktop
    echo 'StartupWMClass=Fusion'|sudo tee -a /usr/share/applications/kega-fusion.desktop>/dev/null
fi