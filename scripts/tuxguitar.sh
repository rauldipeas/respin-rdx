#!/bin/bash
set -e

## TuxGuitar
if  grep ii <(dpkg --list tuxguitar);then
    echo tuxguitar instalado!
    else
    sudo apt install -y	tuxguitar
fi