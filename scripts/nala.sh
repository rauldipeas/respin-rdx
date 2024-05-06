#!/bin/bash
set -e

## nala
if  grep ii <(dpkg --list nala 2>/dev/null);then
    echo nala instalado!
    else
    sudo apt install -y nala
fi