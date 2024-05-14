#!/bin/bash
set -e

## Heroic
if  grep ii <(dpkg --list heroic 2>/dev/null);then
    echo heroic instalado!
    else
    rm -rf heroic*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./heroic*.deb
    rm heroic*.deb
fi