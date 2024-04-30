#!/bin/bash
set -e

## BZip2 (vbox-extras)
if  grep ii <(dpkg --list bzip2);then
    echo bzip2 instalado!
    else
    sudo apt install -y bzip2
fi