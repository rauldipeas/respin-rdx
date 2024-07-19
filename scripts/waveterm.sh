#!/bin/bash
set -e

## Wave
if  grep ii <(dpkg --list waveterm 2>/dev/null);then
    echo waveterm instalado!
    else
    rm -f Wave*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/wavetermdev/waveterm/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./Wave*.deb
    rm Wave*.deb
    if [[ "$XDG_CURRENT_DESKTOP" =~ ^(ubuntu:GNOME|GNOME)$ ]];then
        echo Você está executando o GNOME...
        gsettings set org.gnome.desktop.default-applications.terminal exec waveterm
        else
        echo Você não está executando o GNOME.
    fi
fi