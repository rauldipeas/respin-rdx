#!/bin/bash
set -e

## pipx
if  grep ii <(dpkg --list pipx);then
    echo pipx instalado!
    else
    sudo apt install -y pipx
fi