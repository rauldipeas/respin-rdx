#!/bin/bash
set -e

## RustDesk
if  grep ii <(dpkg --list rustdesk 2>/dev/null);then
    echo rustdesk instalado!
    else
    rm -f rustdesk*.deb>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/rustdesk/rustdesk/releases|grep browser_download_url|grep deb|grep -v aarch64|grep -v armv7|grep -v armhf|head -n1|cut -d '"' -f4)"
    sudo apt install -y ./rustdesk*.deb
    rm rustdesk*.deb
fi