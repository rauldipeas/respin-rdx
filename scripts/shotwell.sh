#!/bin/bash
set -e

## Shotwell
if  grep ii <(dpkg --list shotwell);then
    echo shotwell instalado!
    else
    sudo apt install -y	shotwell
fi