#!/bin/bash
set -e

# FreeTube
if  grep ii <(dpkg --list freetube 2>/dev/null);then
    echo freetube instalado!
    else
    rm -f freetube*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/FreeTubeApp/FreeTube/releases|grep browser_download_url|grep amd64.deb|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./freetube*.deb
    rm freetube*.deb
fi