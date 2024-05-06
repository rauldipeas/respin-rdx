#!/bin/bash
set -e

## GIMP
if  grep ii <(dpkg --list gimp 2>/dev/null);then
    echo gimp instalado!
    else
    sudo apt install -y	gimp
fi