#!/bin/bash
set -e

## MangoHUD
if  grep ii <(dpkg --list mangohud 2>/dev/null);then
    echo mangohud instalado!
    else
    sudo apt install -y	mangohud
fi