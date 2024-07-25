#!/bin/bash
set -e

## Dropbear
if  grep ii <(dpkg --list dropbear 2>/dev/null);then
    echo dropbear instalado!
    else
    sudo apt install -y dropbear
fi