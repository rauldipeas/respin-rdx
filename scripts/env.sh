#!/bin/bash
set -e
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2023.3+deb12u1_all.deb
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/l/live-build/live-build_20230502_all.deb
sudo apt update
sudo apt install -y ./debian-archive-keyring*.deb ./live-build*.deb
mkdir -p /tmp/respin-rdx