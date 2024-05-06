#!/bin/bash
set -e

## UnRAR
if  grep ii <(dpkg --list unrar 2>/dev/null);then
    echo unrar instalado!
    else
    sudo apt install -y unrar
fi