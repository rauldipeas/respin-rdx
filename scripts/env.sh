#!/bin/bash
set -e
export DEBIAN_FRONTEND='noninteractive'
echo 'deb http://archive.debian.org/debian bookworm main'|sudo tee /etc/apt/sources.list.d/bookworm.list
sudo apt update -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true -o APT::Get::AllowUnauthenticated=true
sudo apt install -y --no-install-recommends -o APT::Get::AllowUnauthenticated=true debian-archive-keyring
sudo rm /etc/apt/sources.list.d/bookworm.list
sudo apt update
wget -q --show-progress http://ftp.us.debian.org/debian/pool/main/l/live-build/live-build_20230502_all.deb
sudo apt install -y ./live-build*.deb
mkdir -p /tmp/respin-rdx