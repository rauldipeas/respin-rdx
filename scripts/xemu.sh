#!/bin/bash
set -e

## XEmu
#if  grep ii <(dpkg --list xemu 2>/dev/null);then
#    echo xemu instalado!
#    else
#    rm -f xemu*.deb>/dev/null
#    wget -q --show-progress https://launchpad.net/~mborgerson/+archive/ubuntu/xemu/+files/xemu_0.7.122-0~202405211202~ubuntu22.04.1_amd64.deb
#    sudo apt install -y ./xemu*.deb
#    rm xemu*.deb
#fi
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/Applications/xemu.AppImage ] && [ -f "$HOME"/.local/share/applications/xemu.desktop ];then
    echo cemu instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/xemu.AppImage "$(wget -qO- https://api.github.com/repos/xemu-project/xemu/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/xemu.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/xemu.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/xemu.AppImage
Icon=xemu
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=Xemu
Keywords=emulator;emulation;
EOF
    rm -fr XEMU\ FILES.zip XEMU\ FILES>/dev/null
    wget -q --show-progress https://archive.org/download/xemustarter/XEMU%20FILES.zip
    unzip XEMU\ FILES.zip
    mkdir -p "$HOME"/.local/share/xemu
    mv XEMU\ FILES "$HOME"/.local/share/xemu/
    rm XEMU\ FILES.zip
fi
#sudo apt install git
#git clone -q https://github.com/rikyperdana/extract-xiso
#mv extract-xiso/extract-xiso "$HOME"/.local/share/xemu/XEMU\ FILES/
#rm -r extract-xiso