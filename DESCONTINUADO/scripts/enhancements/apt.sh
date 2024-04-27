#!/bin/bash
set -e
# apt
cat <<EOF |tee /etc/apt/apt.conf.d/100force-confold>/dev/null
Dpkg::Options {
   "--force-confdef";
   "--force-confold";
}
EOF