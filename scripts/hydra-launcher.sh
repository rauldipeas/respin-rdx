#!/bin/bash
set -e

## Hydra Launcher
if  grep ii <(dpkg --list hydra-launcher 2>/dev/null);then
    echo hydra-launcher instalado!
    else
    rm -f hydra_*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/hydralauncher/hydra/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./hydra_*.deb
    rm hydra_*.deb
fi