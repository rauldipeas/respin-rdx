#!/bin/bash
set -e

## PCSX2
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME/Applications/PCSX2.AppImage" ] && [ -f "$HOME"/.local/share/applications/pcsx2.desktop ];then
    echo pcsx2 instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/PCSX2.AppImage "$(wget -qO- https://api.github.com/repos/PCSX2/pcsx2/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/PCSX2.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/pcsx2.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/PCSX2.AppImage
Icon=pcsx2
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=PCSX2
Keywords=emulator;emulation;
EOF
    mkdir -p "$HOME"/ES-DE/custom_systems/
    cat <<EOF |tee "$HOME"/ES-DE/custom_systems/es_systems.xml>/dev/null
<?xml version="1.0"?>
<systemList>
    <system>
        <name>ps2</name>
        <fullname>Sony PlayStation 2</fullname>
        <path>%ROMPATH%/ps2</path>
        <extension>.arcadef .bin .BIN .chd .CHD .ciso .CISO .cso .CSO .dump .DUMP .elf .ELF .gz .GZ .m3u .M3U .mdf .MDF .img .IMG .iso .ISO .isz .ISZ .ngt .NGR .zso .ZSO</extension>
        <command>$HOME/Applications/PCSX2.AppImage "%ROM%"</command>
        <platform>ps2</platform>
        <theme>ps2</theme>
    </system>
    <system>
        <name>ps3</name>
        <fullname>Sony PlayStation 3</fullname>
        <path>%ROMPATH%/ps3</path>
        <extension>.desktop .ps3 .PS3 .ps3dir .PS3DIR</extension>
        <command>$HOME/Applications/rpcs3.AppImage --no-gui "%ROM%"</command>
        <platform>ps3</platform>
        <theme>ps3</theme>
    </system>
</systemList>
EOF
fi