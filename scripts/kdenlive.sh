#!/bin/bash
set -e

## KDEnLive
if  grep ii <(dpkg --list kdenlive 2>/dev/null);then
    echo kdenlive instalado!
    else
    sudo apt install -y	kdenlive
fi