#!/bin/bash
set -e

## OBS Studio
if  grep ii <(dpkg --list bat);then
    echo bat instalado!
    else
    sudo apt install -y	bat
fi