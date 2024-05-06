#!/bin/bash
set -e

## nohang
if  grep ii <(dpkg --list nohang 2>/dev/null);then
    echo nohang instalado!
    else
    sudo apt install -y nohang
fi