#!/bin/bash
set -e
pipx install gnome-extensions-cli --system-site-packages
#arcmenu
"$HOME"/.local/bin/gext install arcmenu@arcmenu.com
#blur my shell
"$HOME"/.local/bin/gext install blur-my-shell@aunetx
#debian-updates-indicator
"$HOME"/.local/bin/gext install debian-updates-indicator@glerro.pm.me
#emoji copy
"$HOME"/.local/bin/gext install emoji-copy@felipeftn
#extensions-sync
"$HOME"/.local/bin/gext install extensions-sync@elhan.io
#forge
"$HOME"/.local/bin/gext install forge@jmmaranan.com
#notification banner reloaded
"$HOME"/.local/bin/gext install notification-banner-reloaded@marcinjakubowski.github.com
#pano
"$HOME"/.local/bin/gext install pano@elhan.io
#status area horizontal spacing
"$HOME"/.local/bin/gext install status-area-horizontal-spacing@mathematical.coffee.gmail.com
#tray-icons-reloaded
"$HOME"/.local/bin/gext install trayIconsReloaded@selfmade.pl
#user themes
"$HOME"/.local/bin/gext install user-theme@gnome-shell-extensions.gcampax.github.com
#x11 gestures
#"$HOME"/.local/bin/gext install x11gestures@joseexposito.github.io
mkdir -p /opt/rdx-user-settings/gnome-shell
mv /root/.local/share/gnome-shell/extensions /opt/rdx-user-settings/gnome-shell/