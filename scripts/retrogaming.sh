#!/bin/bash
set -e

## Retrogaming
### RetroArch
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/retroarch.sh)
### DuckStation
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/duckstation.sh)
### Cemu
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/cemu.sh)
### PCSX2
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/pcsx2.sh)
### RPCS3
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rpcs3.sh)
### Vita3K
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/vita3k.sh)
### XEmu
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/xemu.sh)
### EmulationStation DE
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/emulationstation-de.sh)