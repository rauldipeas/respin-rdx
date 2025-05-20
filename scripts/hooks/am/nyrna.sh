#!/bin/bash
set -e
am -i nyrna
cat <<EOF |tee -a /usr/local/share/applications/nyrna-AM.desktop
StartupWMClass=codes.merritt.Nyrna
EOF