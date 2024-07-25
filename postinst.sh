#!/bin/bash
set -e

# postinst (media-center)
## Atualização do sistema
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/system-update.sh)
## Topgrade
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/topgrade.sh)
## Papirus
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/papirus-icon-theme.sh)
## Warp
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/warp-terminal.sh)
## RustDesk
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rustdesk.sh)
## Stremio
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/stremio.sh)
## VLC
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/vlc.sh)
## Retrogaming
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/retrogaming.sh) #link-folders
## Steam
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/steam.sh)
## Heroic
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/heroic.sh)
## Minigalaxy
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/minigalaxy.sh)
## MangoHUD
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/mangohud.sh)
## Superpaper
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/superpaper.sh) #link-folders
## GNOME tweaks
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/gnome-tweaks.sh)
## Dropbear
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/dropbear.sh)
## NVTop
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/nvtop.sh)
## OpenSSH SFTP server
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/openssh-sftp-server.sh)
## Speedtest
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/speedtest.sh)
## XScreenSaver
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/xscreensaver.sh)
## Ora
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/ora.sh)
## Debian cleanup
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/debian-cleanup.sh)