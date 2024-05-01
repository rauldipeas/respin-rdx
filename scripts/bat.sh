#!/bin/bash
set -e

## OBS Studio
if  grep ii <(dpkg --list batcat);then
    echo batcat instalado!
    else
    sudo apt install -y	batcat
fi