#!/bin/bash
set -e
am -i --icons rclone rclone-browser
sed -i "s|Exec=rclone-browser|Exec=bash -c 'GTK2_RC_FILES=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc rclone-browser'|" /usr/local/share/applications/rclone-browser-AM.desktop
cat <<EOF |tee -a /usr/local/share/applications/rclone-browser-AM.desktop
StartupWMClass=rclone-browser
EOF