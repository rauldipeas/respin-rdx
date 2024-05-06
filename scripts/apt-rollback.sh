#!/bin/bash
set -e

## apt-rollback
if  grep ii <(dpkg --list apt-rollback 2>/dev/null);then
    echo apt-rollback instalado!
    else
    sudo apt install -y apt-rollback
fi