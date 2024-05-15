#!/bin/bash
set -e

## Topgrade
if [ -f /usr/bin/topgrade ];then
    echo topgrade instalado!
    else
    rm -f topgrade*.tar.gz>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/topgrade-rs/topgrade/releases|grep browser_download_url|grep linux-gnu.tar.gz|head -n1|cut -d '"' -f4)"
    sudo tar -xf topgrade*.tar.gz -C /usr/bin/
    rm topgrade*.tar.gz
fi