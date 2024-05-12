#!/bin/bash
set -e

## EmuDeck
if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
    echo libfuse2t64 instalado!
    else
    sudo apt install -y	libfuse2t64
fi
mkdir -p "$HOME"/Applications
wget -q --show-progress -O "$HOME"/Applications/EmuDeck.AppImage "$(wget -qO- https://api.github.com/repos/EmuDeck/emudeck-electron/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
chmod +x "$HOME"/Applications/EmuDeck.AppImage
"$HOME"/Applications/EmuDeck.AppImage --no-sandbox
#bash <(wget -qO- --show-progress https://www.emudeck.com/EmuDeck.sh)