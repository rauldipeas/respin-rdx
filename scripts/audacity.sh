#!/bin/bash
set -e

## Audacity
if  grep ii <(dpkg --list audacity);then
    echo audacity instalado!
    else
    sudo apt install -y	audacity
fi