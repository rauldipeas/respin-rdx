#!/bin/bash
set -e

### RPCS3
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME/.local/share/applications/rpcs3.AppImage" ] && [ -f "$HOME"/.local/share/applications/rpcs3.desktop ];then
    echo rpcs3 instalado!
    else
    mkdir -p "$HOME"/.local/share/applications
    #wget -cq --show-progress http://dus01.ps3.update.playstation.net/update/ps3/image/us/2024_0227_3694eb3fb8d9915c112e6ab41a60c69f/PS3UPDAT.PUP
    wget -cq --show-progress -O "$HOME"/.local/share/applications/rpcs3.AppImage --content-disposition https://rpcs3.net/latest-appimage
    chmod +x "$HOME"/.local/share/applications/rpcs3.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/rpcs3.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/.local/share/applications/rpcs3.AppImage
Icon=rpcs3
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=RPCS3
Keywords=emulator;emulation;
EOF
    mkdir -p "$HOME"/ES-DE/custom_systems/
    cat <<EOF |tee "$HOME"/ES-DE/custom_systems/es_systems.xml
<?xml version="1.0"?>
<systemList>
    <system>
        <name>ps3</name>
        <fullname>PlayStation 3</fullname>
        <path>/media/rauldipeas/Dados/Retrogaming/roms/ps3</path>
        <extension>.ps3</extension>
        <command>$HOME/.local/share/applications/rpcs3.AppImage --no-gui "%ROM%"</command>
        <platform>ps3</platform>
        <theme>ps3</theme>
    </system>
</systemList>
EOF
fi