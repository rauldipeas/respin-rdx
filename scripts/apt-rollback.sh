#!/bin/bash
set -e

## apt-rollback
if  grep ii <(dpkg --list apt-rollback);then
    echo apt-rollback instalado!
    else
    sudo apt install -y apt-rollback
fi