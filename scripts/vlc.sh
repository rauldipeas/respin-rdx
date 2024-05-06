#!/bin/bash
set -e

## VLC
if  grep ii <(dpkg --list vlc 2>/dev/null);then
    echo vlc instalado!
    else
    sudo apt install -y	vlc
fi