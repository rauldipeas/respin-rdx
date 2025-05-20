#!/usr/bin/bash
set -e
cat <<EOF |tee /etc/apt/preferences.d/iriun.pref>/dev/null
Package: linux-headers*+bpo-amd64
Pin: release a=*
Pin-Priority: -10

Package: linux-image*+bpo-amd64
Pin: release a=*
Pin-Priority: -10
EOF
apt install -y -t bookworm-backports iriunwebcam
rm /etc/apt/preferences.d/iriun.pref