#!/bin/bash
set -e
wget -q --show-progress https://repo.protonvpn.com/debian/dists/stable/main/binary-all/"$(wget -qO- https://repo.protonvpn.com/debian/dists/stable/main/binary-all/|grep protonvpn-stable|tail -n1|cut -d'"' -f2)"
apt install -y ./protonvpn*.deb
apt update
apt install -y protonvpn-gui
rm protonvpn*.deb