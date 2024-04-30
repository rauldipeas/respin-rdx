#!/bin/bash
set -e

## Krita
if  grep ii <(dpkg --list krita) && grep ii <(dpkg --list krita-l10n);then
    echo krita instalado!
    else
    sudo apt install -y	krita krita-l10n
fi