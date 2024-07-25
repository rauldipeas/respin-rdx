#!/bin/bash
set -e

## Ora
if  grep ii <(dpkg --list snapd 2>/dev/null);then
    echo snapd instalado!
    if grep ora <(snap list);then
        echo ora instalado!
        else
        sudo snap install ora
    fi
    else
    sudo apt install -y snapd
    sudo snap install ora
fi