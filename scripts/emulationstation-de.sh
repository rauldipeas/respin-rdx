#!/bin/bash
set -e

### EmulationStation DE
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/.EmulationStation/EmulationStation-DE-x64.AppImage ] && [ -f "$HOME"/.local/share/applications/emulationstation-de.desktop ];then
    echo emulationstation instalado!
    else
    mkdir -p "$HOME"/.EmulationStation "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/.EmulationStation/EmulationStation-DE-x64.AppImage https://gitlab.com/es-de/emulationstation-de/-/package_files/127490092/download
    chmod +x "$HOME"/.EmulationStation/EmulationStation-DE-x64.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/emulationstation-de.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/.EmulationStation/EmulationStation-DE-x64.AppImage
Icon=emulationstation
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=EmulationStation Desktop Edition
GenericName=Emulator Frontend
Keywords=emulator;emulation;front-end;frontend;
StartupWMClass=es-de
EOF
fi