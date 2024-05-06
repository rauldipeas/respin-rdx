#!/bin/bash
set -e

## Audacity
if  grep ii <(dpkg --list audacity 2>/dev/null);then
    echo audacity instalado!
    else
    sudo apt install -y	audacity
fi