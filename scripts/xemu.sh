#!/bin/bash
set -e

## XEmu
if  grep ii <(dpkg --list xemu 2>/dev/null);then
    echo xemu instalado!
    else
    rm -f xemu*.deb>/dev/null
    wget -q --show-progress https://launchpad.net/~mborgerson/+archive/ubuntu/xemu/+files/xemu_0.7.122-0~202405211202~ubuntu22.04.1_amd64.deb
    sudo apt install -y ./xemu*.deb
    rm xemu*.deb
fi

rm -fr XEMU\ FILES.zip XEMU\ FILES>/dev/null
wget -q --show-progress https://archive.org/download/xemustarter/XEMU%20FILES.zip
unzip XEMU\ FILES.zip
mkdir -p "$HOME"/.local/share/xemu
mv XEMU\ FILES "$HOME"/.local/share/xemu/
rm XEMU\ FILES.zip

#sudo apt install git
#git clone -q https://github.com/rikyperdana/extract-xiso
#mv extract-xiso/extract-xiso "$HOME"/.local/share/xemu/XEMU\ FILES/
#rm -r extract-xiso