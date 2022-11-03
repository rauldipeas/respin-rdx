#!/bin/bash

# Live assets
mkdir -p respin-rdx/image/{casper,isolinux,install}
sudo cp  respin-rdx/$FLAVOUR-chroot/boot/vmlinuz-*-rdx  respin-rdx/image/casper/vmlinuz
sudo cp  respin-rdx/$FLAVOUR-chroot/boot/initrd.img-*-rdx  respin-rdx/image/casper/initrd
touch respin-rdx/image/respin-rdx
cp assets/live-grub.cfg respin-rdx/image/isolinux/grub.cfg
cp /mnt/casper/*minimal* respin-rdx/image/casper/
sudo chroot respin-rdx/$FLAVOUR-chroot dpkg-query -W --showformat='${Package} ${Version}\n'|tee respin-rdx/image/casper/filesystem.manifest>/dev/null
cp respin-rdx/image/casper/filesystem.manifest respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/casper/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/discover/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/laptop-detect/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/os-prober/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' respin-rdx/image/casper/filesystem.manifest-desktop
sudo mksquashfs respin-rdx/$FLAVOUR-chroot respin-rdx/image/casper/filesystem.squashfs -comp xz -quiet
printf $(sudo du -sx --block-size=1 respin-rdx/$FLAVOUR-chroot|cut -f1)|tee respin-rdx/image/casper/filesystem.size>/dev/null
cp assets/live-README.diskdefines respin-rdx/image/README.diskdefines