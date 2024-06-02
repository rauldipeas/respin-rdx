#!/bin/bash
set -e

## Cemu
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME/.CEMU/CEMU.AppImage" ] && [ -f "$HOME"/.local/share/applications/cemu.desktop ];then
    echo cemu instalado!
    else
    mkdir -p "$HOME"/.CEMU "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/.CEMU/CEMU.AppImage "$(wget -qO- https://api.github.com/repos/cemu-project/Cemu/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/.CEMU/CEMU.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/cemu.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/.CEMU/CEMU.AppImage
Icon=cemu
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=Cemu
Keywords=emulator;emulation;
EOF
    mkdir -p "$HOME"/ES-DE/custom_systems/
    cat <<EOF |tee "$HOME"/ES-DE/custom_systems/es_systems.xml
<?xml version="1.0"?>
<systemList>
    <system>
        <name>ps3</name>
        <fullname>Wii U</fullname>
        <path>/media/rauldipeas/Dados/Retrogaming/roms/wiiu</path>
        <extension>.wua</extension>
        <command>$HOME/.CEMU/CEMU.AppImage "%ROM%"</command>
        <platform>wiiu</platform>
        <theme>wiiu</theme>
    </system>
</systemList>
EOF
fi