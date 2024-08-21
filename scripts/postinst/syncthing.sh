#!/bin/bash
set -e

## Syncthing
if  grep ii <(dpkg --list syncthing 2>/dev/null)&&grep ii <(dpkg --list syncthingtray 2>/dev/null);then
    echo syncthing instalado!
    else
    sudo apt install -y syncthing syncthingtray
fi