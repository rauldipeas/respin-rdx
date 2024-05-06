#!/bin/bash
set -e

## Synaptic
if  grep ii <(dpkg --list synaptic 2>/dev/null);then
    echo synaptic instalado!
    else
    sudo apt install -y synaptic
fi