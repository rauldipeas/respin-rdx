#!/bin/bash
set -e

## Vita3K
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/Applications/Vita3K.AppImage ] && [ -f "$HOME"/.local/share/applications/vita3k.desktop ];then
    echo vita3k instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/Vita3K.AppImage "$(wget -qO- https://api.github.com/repos/Vita3K/Vita3K/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/Vita3K.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/vita3k.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/Vita3K.AppImage
Icon=vita3k
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=Vita3K
Keywords=emulator;emulation;
EOF
fi