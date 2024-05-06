#!/bin/bash
set -e

## OBS Studio
if  grep ii <(dpkg --list micro 2>/dev/null);then
    echo micro instalado!
    else
    sudo apt install -y	micro
fi