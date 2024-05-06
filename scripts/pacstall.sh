#!/bin/bash
set -e

## Pacstall
if  grep ii <(dpkg --list pacstall 2>/dev/null);then
    echo pacstall instalado!
    else
    rm -rf pacstall*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/pacstall/pacstall/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./pacstall*.deb
    rm pacstall*.deb
fi