#!/bin/bash
set -e

## GIMP
if  grep ii <(dpkg --list gimp);then
    echo gimp instalado!
    else
    sudo apt install -y	gimp
fi