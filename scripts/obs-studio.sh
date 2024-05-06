#!/bin/bash
set -e

## OBS Studio
if  grep ii <(dpkg --list obs-studio 2>/dev/null);then
    echo obs-studio instalado!
    else
    sudo apt install -y	obs-studio
fi