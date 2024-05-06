#!/bin/bash
set -e

## WinFF
if  grep ii <(dpkg --list winff 2>/dev/null);then
    echo winff instalado!
    else
    sudo apt install -y winff
fi