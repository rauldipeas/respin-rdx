#!/bin/bash
set -e

## VLC
if  grep ii <(dpkg --list vlc);then
    echo vlc instalado!
    else
    sudo apt install -y	vlc
fi