#!/bin/bash
set -e

## Dolphin Emulator
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/Applications/Dolphin_Emulator.AppImage ] && [ -f "$HOME"/.local/share/applications/dolphin-emu.desktop ];then
    echo cemu instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/Dolphin_Emulator.AppImage "$(wget -qO- https://api.github.com/repos/lucasmz1/Dolphin_emu_Appimage/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/Dolphin_Emulator.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/dolphin-emu.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/Dolphin_Emulator.AppImage
Icon=dolphin-emu
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=Dolphin Emulator
Keywords=emulator;emulation;
EOF
fi