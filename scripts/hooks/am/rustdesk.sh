#!/bin/bash
set -e
am -i rustdesk
echo y|am icons rustdesk
cat <<EOF |tee -a /usr/local/share/applications/rustdesk-AM.desktop
StartupWMClass=rustdesk
EOF