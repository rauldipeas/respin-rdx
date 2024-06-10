#!/bin/bash
set -e

## Yabause
if  grep ii <(dpkg --list yabause 2>/dev/null);then
    echo yabause instalado!
    else
    sudo apt install -y yabause
    mkdir -p "$HOME"/.local/share/icons
    wget -q --show-progress -O "$HOME"/.local/share/icons/yabause.png https://www.pngaaa.com/api-download/5749481
fi