#!/bin/bash
set -e
#wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2023.3+deb12u2_all.deb
export DEBIAN_FRONTEND='noninteractive'
echo 'deb http://archive.debian.org/debian/ bookworm main'|tee /etc/apt/sources.list.d/bookworm.list
apt update -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true -o APT::Get::AllowUnauthenticated=true
apt install -y --no-install-recommends -o APT::Get::AllowUnauthenticated=true debian-archive-keyring
rm /etc/apt/sources.list.d/bookworm.list
apt update
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/l/live-build/live-build_20230502_all.deb
apt install -y ./live-build*.deb
mkdir -p /tmp/respin-rdx