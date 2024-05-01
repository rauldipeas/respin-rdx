#!/bin/bash
set -e

## OBS Studio
if  grep ii <(dpkg --list micro);then
    echo micro instalado!
    else
    sudo apt install -y	micro
fi