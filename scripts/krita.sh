#!/bin/bash
set -e

## Krita
if  grep ii <(dpkg --list krita 2>/dev/null) && grep ii <(dpkg --list krita-l10n 2>/dev/null);then
    echo krita instalado!
    else
    sudo apt install -y	krita krita-l10n
fi