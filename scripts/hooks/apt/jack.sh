#!/usr/bin/bash
set -e
debconf-set-selections <<< 'jackd2 jackd/tweak_rt_limits string true'
cat <<EOF |tee /etc/apt/preferences.d/qjackctl.pref>/dev/null
Package: qjackctl
Pin: release a=*
Pin-Priority: -10
EOF
apt install -y jackd2
rm /etc/apt/preferences.d/qjackctl.pref