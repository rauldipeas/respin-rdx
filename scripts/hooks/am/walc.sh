#!/bin/bash
set -e
am -i walc
cat <<EOF |tee -a /usr/local/share/applications/walc-AM.desktop
StartupWMClass=walc
EOF