#!/bin/bash
set -e

## nala
if  grep ii <(dpkg --list nala);then
    echo nala instalado!
    else
    sudo apt install -y nala
fi