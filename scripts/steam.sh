#!/bin/bash
set -e

## Steam
if  grep ii <(dpkg --list steam-launcher 2>/dev/null);then
    echo steam-launcher instalado!
    else
    rm -f steam_latest.deb>/dev/null
    wget -q --show-progress https://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    sudo apt install -y ./steam_latest.deb
    rm steam_latest.deb
fi