#!/bin/bash
set -e

# Atualização do sistema
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/system-update.sh)

# Desempenho
## CFS Zen tweaks
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/cfs-zen-tweaks.sh)
## ZSwap
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/zswap.sh)
## nohang
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/nohang.sh)

# Instaladores de programas
## apt-rollback
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/apt-rollback.sh)
## nala
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/nala.sh)
## Pacstall
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/pacstall.sh)
## pipx
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/pipx.sh)
## Synaptic
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/synaptic.sh)

# Drivers
## JACK
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/jack.sh)
## udev-rtirq
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/udev-rtirq.sh)

# rtcqs
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rtcqs.sh)

# Miscelânea
## Papirus
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/papirus-icon-theme.sh)
## UnRAR
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/unrar.sh)
## BZip2 (vbox-extras)
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/bzip2.sh)

# Multimídia
## 4kVideoDownloader
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/4kvideodownloader.sh)
## Audacity
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/audacity.sh)
## Cadence
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/cadence.sh)
## GIMP
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/gimp.sh)
## Glaxnimate (snap)
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/glaxnimate.sh)
## Inkscape
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/inkscape.sh)
## KDEnLive
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/kdenlive.sh)
## Krita
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/krita.sh)
## MediaInfo GUI
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/mediainfo-gui.sh)
## Mini-video-me
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/mini-video-me.sh)
## OBS Studio
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/obs-studio.sh)
## REAPER
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/reaper.sh)
## RustDesk
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rustdesk.sh)
## Shotwell
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/shotwell.sh)
## Stremio
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/stremio.sh)
## TuxGuitar
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/tuxguitar.sh)
## VLC
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/vlc.sh)
## WINE TkG
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/wine-tkg.sh)
## WinFF
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/winff.sh)
## yabridge
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/yabridge.sh)