#!/bin/bash
set -e

## Hydra
if  grep ii <(dpkg --list hydra 2>/dev/null);then
    echo hydra instalado!
    else
    rm -f hydra_*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/hydralauncher/hydra/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)"
    cat <<EOF |sudo tee /etc/apt/preferences.d/hydra.pref>/dev/null
Package: hydra
Pin: release a=*
Pin-Priority: -10
EOF
    sudo apt install -y ./hydra_*.deb
    rm hydra_*.deb
fi