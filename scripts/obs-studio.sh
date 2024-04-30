#!/bin/bash
set -e

## OBS Studio
if  grep ii <(dpkg --list obs-studio);then
    echo obs-studio instalado!
    else
    sudo apt install -y	obs-studio
fi