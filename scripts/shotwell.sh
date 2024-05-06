#!/bin/bash
set -e

## Shotwell
if  grep ii <(dpkg --list shotwell 2>/dev/null);then
    echo shotwell instalado!
    else
    sudo apt install -y	shotwell
fi