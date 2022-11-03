#!/bin/bash
set -e

# chroot
sudo mount -o loop $FLAVOUR-*-desktop-amd64.iso /mnt
mkdir respin-rdx
sudo unsquashfs -q -d respin-rdx/$FLAVOUR-chroot /mnt/casper/filesystem.squashfs
sudo mount --bind /dev respin-rdx/$FLAVOUR-chroot/dev
sudo mount --bind /run respin-rdx/$FLAVOUR-chroot/run
sudo chroot respin-rdx/$FLAVOUR-chroot mount none -t proc /proc
sudo chroot respin-rdx/$FLAVOUR-chroot mount none -t sysfs /sys
sudo chroot respin-rdx/$FLAVOUR-chroot mount none -t devpts /dev/pts
sudo cp scripts/enhancements* respin-rdx/$FLAVOUR-chroot/
sudo chroot respin-rdx/$FLAVOUR-chroot bash -x enhancements.sh
sudo rm -r respin-rdx/$FLAVOUR-chroot/enhancements*
sudo chroot respin-rdx/$FLAVOUR-chroot sh -c 'rm -rf /tmp/* /root/.bash_history'
sudo chroot respin-rdx/$FLAVOUR-chroot umount /proc
sudo chroot respin-rdx/$FLAVOUR-chroot umount /sys
sudo chroot respin-rdx/$FLAVOUR-chroot umount /dev/pts
sudo umount respin-rdx/$FLAVOUR-chroot/dev
sudo umount respin-rdx/$FLAVOUR-chroot/run