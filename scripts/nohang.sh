#!/bin/bash
set -e

## nohang
if  grep ii <(dpkg --list nohang);then
    echo nohang instalado!
    else
    sudo apt install -y nohang
fi