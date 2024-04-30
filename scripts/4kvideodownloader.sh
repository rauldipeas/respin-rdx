#!/bin/bash
set -e

## 4kVideoDownloader
if  grep ii <(dpkg --list 4kvideodownloader);then
    echo 4kvideodownloader instalado!
    else
    rm -f 4kvideodownloader*.deb>/dev/null
    wget -qO- https://www.4kdownload.com/pt-br/downloads|grep amd64.deb|grep 4kvideodownloader|grep -v 4kvideodownloaderplus|cut -d '"' -f4|cut -d '?' -f1|xargs wget -q --show-progress
    sudo apt install -y ./4kvideodownloader*.deb
    rm 4kvideodownloader*.deb
fi