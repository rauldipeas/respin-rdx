#!/bin/bash
set -e

## Synaptic
if  grep ii <(dpkg --list synaptic);then
    echo synaptic instalado!
    else
    sudo apt install -y synaptic
fi