#!/bin/bash
set -e

## Hydra Launcher
if  grep ii <(dpkg --list hydra-launcher 2>/dev/null);then
    echo hydra-launcher instalado!
    else
    rm -f hydra-launcher*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/hydralauncher/hydra/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./hydra-launcher*.deb
    rm hydra-launcher*.deb
fi
#wget -q --show-progress https://github.com/hydralauncher/hydra/releases/download/v1.1.0/hydra-launcher_1.1.0_amd64.deb