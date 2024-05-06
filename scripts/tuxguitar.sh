#!/bin/bash
set -e

## TuxGuitar
if  grep ii <(dpkg --list tuxguitar 2>/dev/null);then
    echo tuxguitar instalado!
    else
    sudo apt install -y	tuxguitar
fi