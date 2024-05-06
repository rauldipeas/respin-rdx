#!/bin/bash
set -e

## Mini-video-me
if  grep ii <(dpkg --list mini-video-me 2>/dev/null);then
    echo mini-video-me instalado!
    else
    rm -f mini-video-me*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/maykbrito/mini-video-me/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./mini-video-me*.deb
    rm mini-video-me*.deb
fi