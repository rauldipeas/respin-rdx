#!/bin/bash
set -e
pkcon install binutils debootstrap xorriso mtools
#binutils binutils-common binutils-x86-64-linux-gnu debootstrap libbinutils libburn4 libctf-nobfd0 libctf0 libisoburn1 libisofs6 libjte2 mtools xorriso
sudo rm -frv respin-rdx*
mkdir respin-rdx
# Debootstrap
sudo debootstrap\
   --arch=amd64\
   --variant=minbase\
   jammy\
   respin-rdx/$FLAVOUR-chroot\
   http://br.archive.ubuntu.com/ubuntu/
# ISO chroot
wget -q https://cdimage.ubuntu.com/kubuntu/releases/jammy/release/$FLAVOUR-22.04.1-desktop-amd64.iso
sudo mount -o loop $FLAVOUR-*-desktop-amd64.iso /mnt
sudo unsquashfs -d $FLAVOUR /mnt/casper/filesystem.squashfs
sudo mount --bind /dev respin-rdx/$FLAVOUR-chroot/dev
sudo mount --bind /run respin-rdx/$FLAVOUR-chroot/run
sudo chroot respin-rdx/$FLAVOUR-chroot mount none -t proc /proc
sudo chroot respin-rdx/$FLAVOUR-chroot mount none -t sysfs /sys
sudo chroot respin-rdx/$FLAVOUR-chroot mount none -t devpts /dev/pts
echo respin-rdx|sudo tee respin-rdx/$FLAVOUR-chroot/etc/hostname>/dev/null
cat <<EOF |sudo tee respin-rdx/$FLAVOUR-chroot/etc/apt/sources.list>/dev/null
deb http://us.archive.ubuntu.com/ubuntu/ jammy main restricted universe multiverse
deb http://us.archive.ubuntu.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://us.archive.ubuntu.com/ubuntu/ jammy-updates main restricted universe multiverse
EOF
sudo chroot respin-rdx/$FLAVOUR-chroot apt update
#sudo chroot respin-rdx/$FLAVOUR-chroot apt install -y libterm-readline-gnu-perl systemd-sysv
sudo chroot respin-rdx/$FLAVOUR-chroot sh -c 'dbus-uuidgen|tee /etc/machine-id>/dev/null'
sudo ln -fs respin-rdx/$FLAVOUR-chroot/etc/machine-id respin-rdx/$FLAVOUR-chroot/var/lib/dbus/machine-id
sudo chroot respin-rdx/$FLAVOUR-chroot sh -c 'dpkg-divert --local --rename --add /sbin/initctl'
sudo ln -s respin-rdx/$FLAVOUR-chroot/bin/true respin-rdx/$FLAVOUR-chroot/sbin/initctl
sudo chroot respin-rdx/$FLAVOUR-chroot apt dist-upgrade -y
sudo chroot respin-rdx/$FLAVOUR-chroot apt install -y bash-completion casper sudo
sudo chroot respin-rdx/$FLAVOUR-chroot apt install -y $FLAVOUR-desktop
cat scripts/enhancements.sh|xargs sudo chroot respin-rdx/$FLAVOUR-chroot bash
sudo chroot respin-rdx/$FLAVOUR-chroot dpkg-reconfigure resolvconf
cat <<EOF |sudo tee respin-rdx/$FLAVOUR-chroot/etc/NetworkManager/NetworkManager.conf>/dev/null
[main]
rc-manager=resolvconf
plugins=ifupdown,keyfile
dns=dnsmasq

[ifupdown]
managed=false
EOF
sudo chroot respin-rdx/$FLAVOUR-chroot dpkg-reconfigure network-manager
sudo chroot respin-rdx/$FLAVOUR-chroot sh -c 'truncate -s 0 /etc/machine-id'
sudo chroot respin-rdx/$FLAVOUR-chroot sh -c 'dpkg-divert --rename --remove /sbin/initctl'
sudo chroot respin-rdx/$FLAVOUR-chroot apt clean
sudo chroot respin-rdx/$FLAVOUR-chroot sh -c 'rm -rf /tmp/* ~/.bash_history'
sudo chroot respin-rdx/$FLAVOUR-chroot umount /proc
sudo chroot respin-rdx/$FLAVOUR-chroot umount /sys
sudo chroot respin-rdx/$FLAVOUR-chroot umount /dev/pts
sudo umount respin-rdx/$FLAVOUR-chroot/dev
sudo umount respin-rdx/$FLAVOUR-chroot/run
mkdir -p respin-rdx/image/{casper,isolinux,install}
sudo cp  respin-rdx/$FLAVOUR-chroot/boot/vmlinuz-*-rdx  respin-rdx/image/casper/vmlinuz
sudo cp  respin-rdx/$FLAVOUR-chroot/boot/initrd.img-*-rdx  respin-rdx/image/casper/initrd
touch respin-rdx/image/respin-rdx
cat <<EOF |tee respin-rdx/image/isolinux/grub.cfg>/dev/null
search --set=root --file /respin-rdx
insmod all_video
set default="0"
set timeout=10
menuentry "$FLAVOUR_NAME Respin RDX" {
   linux /casper/vmlinuz boot=casper ---
   initrd /casper/initrd
}
EOF
sudo chroot respin-rdx/$FLAVOUR-chroot dpkg-query -W --showformat='${Package} ${Version}\n'|tee respin-rdx/image/casper/filesystem.manifest>/dev/null
cp respin-rdx/image/casper/filesystem.manifest respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/casper/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/discover/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/laptop-detect/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/os-prober/d' respin-rdx/image/casper/filesystem.manifest-desktop
sudo mksquashfs respin-rdx/$FLAVOUR-chroot respin-rdx/image/casper/filesystem.squashfs -comp xz
printf $(sudo du -sx --block-size=1 respin-rdx/$FLAVOUR-chroot|cut -f1)|tee respin-rdx/image/casper/filesystem.size>/dev/null
cat <<EOF |tee respin-rdx/image/README.diskdefines>/dev/null
#define DISKNAME  $FLAVOUR_NAME Respin RDX
#define TYPE  binary
#define TYPEbinary  1
#define ARCH  amd64
#define ARCHamd64  1
#define DISKNUM  1
#define DISKNUM1  1
#define TOTALNUM  0
#define TOTALNUM0  1
EOF
cd respin-rdx/image
grub-mkstandalone\
   --format=x86_64-efi\
   --output=isolinux/bootx64.efi\
   --locales=''\
   --fonts=''\
   'boot/grub/grub.cfg=isolinux/grub.cfg'
(
   cd isolinux&&\
   dd if=/dev/zero of=efiboot.img bs=1M count=10&&\
   sudo mkfs.vfat efiboot.img&&\
   LC_CTYPE=C mmd -i efiboot.img efi efi/boot&&\
   LC_CTYPE=C mcopy -i efiboot.img ./bootx64.efi ::efi/boot/
)
grub-mkstandalone\
   --format=i386-pc\
   --output=isolinux/core.img\
   --install-modules='linux16 linux normal iso9660 biosdisk memdisk search tar ls'\
   --modules='linux16 linux normal iso9660 biosdisk search'\
   --locales=''\
   --fonts=''\
   'boot/grub/grub.cfg=isolinux/grub.cfg'
cat /usr/lib/grub/i386-pc/cdboot.img isolinux/core.img>isolinux/bios.img
sudo bash -c "(find . -type f -print0|xargs -0 md5sum|grep -v -e 'md5sum.txt' -e 'bios.img' -e 'efiboot.img'|tee md5sum.txt>/dev/null)"
sudo xorriso\
   -as mkisofs\
   -iso-level 3\
   -full-iso9660-filenames\
   -volid "$FLAVOUR_NAME Respin RDX"\
   -output "../../$FLAVOUR-respin-rdx.iso"\
   -eltorito-boot boot/grub/bios.img\
   -no-emul-boot\
   -boot-load-size 4\
   -boot-info-table\
   --eltorito-catalog boot/grub/boot.cat\
   --grub2-boot-info\
   --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img\
   -eltorito-alt-boot\
   -e EFI/efiboot.img\
   -no-emul-boot\
   -append_partition 2 0xef isolinux/efiboot.img\
   -m 'isolinux/efiboot.img'\
   -m 'isolinux/bios.img'\
   -graft-points\
      '/EFI/efiboot.img=isolinux/efiboot.img'\
      '/boot/grub/bios.img=isolinux/bios.img'\
      '.'