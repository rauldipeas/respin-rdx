#!/bin/bash
set -e

## Minigalaxy
if  grep ii <(dpkg --list minigalaxy 2>/dev/null);then
    echo minigalaxy instalado!
    else
    sudo apt install -y	minigalaxy
fi