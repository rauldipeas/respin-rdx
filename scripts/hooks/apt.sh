#!/bin/bash
set -e
dpkg --add-architecture i386
cat <<EOF |tee /etc/apt/apt.conf.d/100keep-edited-files>/dev/null
Dpkg::Options {
   "--force-confdef";
   "--force-confold";
}
EOF
apt update