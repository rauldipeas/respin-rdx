#!/bin/bash
set -e

## Mupen64Plus
if  grep ii <(dpkg --list mupen64plus-qt 2>/dev/null);then
    echo mupen64plus-qt instalado!
    else
    sudo apt install -y mupen64plus-qt
fi