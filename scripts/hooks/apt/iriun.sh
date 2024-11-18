#!/bin/bash
set -e
apt install -y -t bookworm-backports iriunwebcam
sed -i 's|Exec=|Exec=GTK2_RC_FILE=/usr/share/themes/Orchid-Dark-Compact/gtk-2.0/gtkrc|' /usr/share/applications/iriunwebcam.desktop