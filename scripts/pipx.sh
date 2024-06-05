#!/bin/bash
set -e

## pipx
if  grep ii <(dpkg --list pipx 2>/dev/null);then
    echo pipx instalado!
    else
    sudo apt install -y pipx
    pipx ensurepath
    source "$HOME"/.bashrc
fi