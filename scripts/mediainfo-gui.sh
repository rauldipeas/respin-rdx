#!/bin/bash
set -e

## MediaInfo GUI
if  grep ii <(dpkg --list mediainfo-gui);then
    echo mediainfo-gui instalado!
    else
    sudo apt install -y mediainfo-gui
fi