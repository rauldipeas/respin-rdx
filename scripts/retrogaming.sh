#!/bin/bash
set -e

## Retrogaming
### RetroArch
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/retroarch.sh)
### RPCS3
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rpcs3.sh)
### XEmu
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/xemu.sh)
### EmulationStation DE
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/emulationstation-de.sh)