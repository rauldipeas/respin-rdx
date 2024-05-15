#!/bin/bash
set -e

## PCSX2
#if  grep ii <(dpkg --list pcsx2 2>/dev/null);then
#    echo pcsx2 instalado!
#    else
#    sudo apt install -y pcsx2
#fi
## RetroArch
if  grep ii <(dpkg --list retroarch 2>/dev/null) && grep ii <(dpkg --list libaio1t64:amd64 2>/dev/null);then
    echo retroarch instalado!
    else
    sudo apt install -y libaio1t64 retroarch
    sudo ln -fs /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1
    rm -f RetroArch_cores.7z>/dev/null
    wget -q --show-progress https://buildbot.libretro.com/stable/1.17.0/linux/x86_64/RetroArch_cores.7z
    #wget -q --show-progress https://buildbot.libretro.com/nightly/linux/x86_64/RetroArch_cores.7z
    7z x RetroArch_cores.7z
    mkdir -p "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name fbneo_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name flycast_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name genesis_plus_gx_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name mame2003_plus_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name mame2010_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name mame_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name mupen64plus_next_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name opera_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name pcsx2_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name pcsx_rearmed_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name picodrive_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name ppsspp_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name snes9x_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name virtualjaguar_libretro.so) "$HOME"/.config/retroarch/cores/
    #cp $(find RetroArch-Linux-x86_64/ -name yabasanshiro_libretro.so) "$HOME"/.config/retroarch/cores/
    cp $(find RetroArch-Linux-x86_64/ -name *_libretro.so) "$HOME"/.config/retroarch/cores/
    rm -r RetroArch_cores.7z RetroArch-Linux-x86_64
## EmulationStation
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