#!/bin/bash
set -e

## Flycast
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/Applications/flycast-x86_64.AppImage ] && [ -f "$HOME"/.local/share/applications/flycast.desktop ];then
    echo flycast instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/flycast-x86_64.AppImage "$(wget -qO- https://api.github.com/repos/flyinghead/flycast/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/flycast-x86_64.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/flycast.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/flycast-x86_64.AppImage
Icon=flycast
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=Flycast
Keywords=emulator;emulation;
EOF
fi