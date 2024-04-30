#!/bin/bash
set -e

## WinFF
if  grep ii <(dpkg --list winff);then
    echo winff instalado!
    else
    sudo apt install -y winff
fi