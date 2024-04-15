#!/bin/bash
set -e

## Desktop base
echo "respin-rdx"|sudo tee "$CHROOT"/etc/hostname
cat <<EOF |sudo tee "$CHROOT"/etc/apt/sources.list
deb http://us.archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse

deb http://us.archive.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse

deb http://us.archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse
EOF
cat <<EOF |sudo tee "$CHROOT"/etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
sudo chroot "$CHROOT" apt update
sudo chroot "$CHROOT" apt install -y sudo
if [ -f "$CHROOT"/Kubuntu ]; then
    echo 'Kubuntu'
    sudo chroot "$CHROOT" apt install -y kubuntu-desktop
    elif [ -f "$CHROOT"/KAVIS ]; then
    echo 'Kubuntu Audio Video Image Studio'
    sudo chroot "$CHROOT" apt install -y kubuntu-desktop
    elif [ -f "$CHROOT"/KDeck ]; then
    echo 'Kubuntu Deck'
    sudo chroot "$CHROOT" apt install -y kubuntu-desktop
    elif [ -f "$CHROOT"/Xubuntu ]; then
    echo 'Xubuntu'
    sudo chroot "$CHROOT" apt install -y xubuntu-desktop xubuntu-live-settings
    else
    echo 'Ubuntu'
    sudo chroot "$CHROOT" apt install -y ubuntu-desktop
fi