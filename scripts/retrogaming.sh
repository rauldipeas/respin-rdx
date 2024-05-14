#!/bin/bash
set -e

## RetroArch
if  grep ii <(dpkg --list retroarch 2>/dev/null);then
    echo retroarch instalado!
    else
    sudo apt install -y retroarch
fi
## EmulationStation
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/.local/share/appimage/emulationstation.appimage ];then
    echo emulationstation instalado!
    else
    mkdir -p "$HOME"/.local/share/appimage
    wget -q --show-progress -O "$HOME"/.local/share/appimage/emulationstation.appimage https://gitlab.com/es-de/emulationstation-de/-/package_files/127490092/download
    chmod +x "$HOME"/.local/share/appimage/emulationstation.appimage
    gtk-launch "$HOME"/.local/share/appimage/emulationstation.appimage
fi