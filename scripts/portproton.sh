#!/bin/bash
set -e

## CFS Zen tweaks
if  grep ii <(dpkg --list portproton 2>/dev/null);then
    echo portproton instalado!
    else
    rm -f portproton*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/Castro-Fidel/PortProton_dpkg/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
    sudo dpkg --add-architecture i386
    sudo apt update
    sudo apt install -y ./portproton*.deb
    rm portproton*.deb
fi