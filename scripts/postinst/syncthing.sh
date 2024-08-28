#!/bin/bash
set -e

## Syncthing
if  grep ii <(dpkg --list syncthing 2>/dev/null)&&grep ii <(dpkg --list syncthingtray 2>/dev/null);then
    echo syncthing instalado!
    else
    wget -qO- https://syncthing.net/release-key.gpg|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/syncthing-archive-keyring.gpg>/dev/null
    echo 'deb https://apt.syncthing.net/ syncthing stable'|sudo tee /etc/apt/sources.list.d/syncthing.list>/dev/null
    sudo apt update
    sudo apt install -y syncthing syncthingtray
fi