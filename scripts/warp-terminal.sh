#!/bin/bash
set -e

## Warp
if  grep ii <(dpkg --list warp-terminal 2>/dev/null);then
    echo warp-terminal instalado!
    else
    rm -f warp-terminal*.deb>/dev/null
    wget -q --show-progress https://releases.warp.dev/stable/v0.2024.06.25.08.02.stable_01/warp-terminal_0.2024.06.25.08.02.stable.01_amd64.deb
    sudo apt install -y ./warp-terminal*.deb
    rm warp-terminal*.deb
    if [[ "$XDG_CURRENT_DESKTOP" =~ ^(ubuntu:GNOME|GNOME)$ ]];then
        echo Você está executando o GNOME...
        gsettings set org.gnome.desktop.default-applications.terminal exec warp-terminal
        else
        echo Você não está executando o GNOME.
    fi
fi