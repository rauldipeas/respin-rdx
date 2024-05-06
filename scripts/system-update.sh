#!/bin/bash
set -e

# Atualização do sistema
if ls /usr/bin/dpkg;then
    if  grep ii <(dpkg --list apt 2>/dev/null);then
        sudo apt update 2>/dev/null
        sudo apt upgrade -y
        else
        echo 'Sua distribuição não é compatível com esse script.'
    fi
fi