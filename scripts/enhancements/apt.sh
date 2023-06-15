#!/bin/bash
set -e
# apt
cat <<EOF |tee /etc/apt/apt.conf.d/force-confold
Dpkg::Options {
   "--force-confdef";
   "--force-confold";
}
EOF