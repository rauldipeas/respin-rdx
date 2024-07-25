#!/bin/bash
set -e

## Speedtest
if  grep ii <(dpkg --list speedtest-cli 2>/dev/null);then
    echo speedtest-cli instalado!
    else
    sudo apt install -y speedtest-cli
fi