#!/bin/bash
set -e
apt install -y -t bookworm-backports iriunwebcam
sed -i "s|Exec=|Exec=bash -c 'GTK2_RC_FILES=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc |'" /usr/share/applications/iriunwebcam.desktop