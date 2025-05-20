#!/usr/bin/bash
set -e
am -i squirrel-disk
cat <<EOF |tee -a /usr/local/share/applications/squirrel-disk-AM.desktop
StartupWMClass=squirrel-disk
EOF