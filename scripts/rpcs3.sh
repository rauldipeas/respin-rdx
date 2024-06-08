#!/bin/bash
set -e

### RPCS3
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
if [ -f "$HOME"/Applications/rpcs3.AppImage ] && [ -f "$HOME"/.local/share/applications/rpcs3.desktop ];then
    echo rpcs3 instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    #wget -cq --show-progress http://dus01.ps3.update.playstation.net/update/ps3/image/us/2024_0227_3694eb3fb8d9915c112e6ab41a60c69f/PS3UPDAT.PUP
    wget -cq --show-progress -O "$HOME"/Applications/rpcs3.AppImage --content-disposition https://rpcs3.net/latest-appimage
    chmod +x "$HOME"/Applications/rpcs3.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/rpcs3.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/rpcs3.AppImage
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
    cat <<EOF |tee "$HOME"/ES-DE/custom_systems/es_systems.xml>/dev/null
<?xml version="1.0"?>
<systemList>
    <system>
        <name>psx</name>
        <fullname>Sony PlayStation</fullname>
        <path>%ROMPATH%/psx</path>
        <extension>.bin .BIN .cbn .CBN .ccd .CCD .chd .CHD .cue .CUE .ecm .ECM .exe .EXE .img .IMG .iso .ISO .m3u .M3U .mdf .MDF .mds .MDS .minipsf .MINIPSF .pbp .PBP .psexr .PSEXE .psf .PSF .toc .TOC .z .Z .znx .ZNX .7z .7Z .zip .ZIP</extension>
        <command>$HOME/Applications/duckstation.AppImage -batch %ROM%</command>
        <platform>psx</platform>
        <theme>psx</theme>
    </system>
    <system>
        <name>psp</name>
        <fullname>Sony PlayStation Portable</fullname>
        <path>%ROMPATH%/psp</path>
        <extension>.chd .CHD .cso .CSO .elf .ELF .iso .ISO .pbp .PBP .prx .PRX .7z .7Z .zip .ZIP</extension>
        <command>$HOME/Applications/PPSSPP.AppImage %ROM%</command>
        <platform>psp</platform>
        <theme>psp</theme>
    </system>
    <system>
        <name>ps2</name>
        <fullname>Sony PlayStation 2</fullname>
        <path>%ROMPATH%/ps2</path>
        <extension>.arcadef .bin .BIN .chd .CHD .ciso .CISO .cso .CSO .dump .DUMP .elf .ELF .gz .GZ .img .IMG .iso .ISO .isz .ISZ .m3u .M3U .mdf .MDF .ngt .NGR .zso .ZSO</extension>
        <command>$HOME/Applications/PCSX2.AppImage %ROM%</command>
        <platform>ps2</platform>
        <theme>ps2</theme>
    </system>
    <system>
        <name>ps3</name>
        <fullname>Sony PlayStation 3</fullname>
        <path>%ROMPATH%/ps3</path>
        <extension>.desktop .ps3 .PS3 .ps3dir .PS3DIR</extension>
        <command>$HOME/Applications/rpcs3.AppImage --no-gui %ROM%</command>
        <platform>ps3</platform>
        <theme>ps3</theme>
    </system>
</systemList>
EOF
fi