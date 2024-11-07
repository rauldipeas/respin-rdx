#!/bin/bash
set -e
am -i --icons onlyoffice
sed -i 's|Icon=onlyoffice|Icon=asc-de|' /usr/local/share/applications/onlyoffice-AM.desktop
cat <<EOF |tee -a /usr/local/share/applications/onlyoffice-AM.desktop
StartupWMClass=DesktopEditors
EOF