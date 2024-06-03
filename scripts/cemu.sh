#!/bin/bash
set -e

## Cemu
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME/Applications/Cemu.AppImage" ] && [ -f "$HOME"/.local/share/applications/cemu.desktop ];then
    echo cemu instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/Cemu.AppImage "$(wget -qO- https://api.github.com/repos/cemu-project/Cemu/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/Cemu.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/cemu.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/Cemu.AppImage
Icon=cemu
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=Cemu
Keywords=emulator;emulation;
EOF
fi