#!/bin/bash
set -e

## Yabause
if  grep ii <(dpkg --list yabause 2>/dev/null);then
    echo yabause instalado!
    else
    sudo apt install -y yabause
    #mkdir -p "$HOME"/.local/share/icons
    #wget -q --show-progress -O "$HOME"/.local/share/icons/yabause.png https://dashboard.snapcraft.io/site_media/appmedia/2023/03/yabause_icon.png
fi