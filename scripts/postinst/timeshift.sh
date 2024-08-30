#!/bin/bash
set -e

## Timeshift
if  grep ii <(dpkg --list timeshift 2>/dev/null);then
    echo timeshift instalado!
    else
    sudo apt install -y timeshift
fi