#!/bin/bash
set -e

# Setup host
sudo apt install -y debootstrap mtools squashfs-tools

# MEGA
wget -q --show-progress https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megacmd-xUbuntu_22.04_amd64.deb
sudo apt install ./megacmd*.deb