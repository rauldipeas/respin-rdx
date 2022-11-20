#!/bin/bash
set -e
cd respin-rdx/image

# EFI
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

# Legacy
grub-mkstandalone\
   --format=i386-pc\
   --output=isolinux/core.img\
   --install-modules='linux16 linux normal iso9660 biosdisk memdisk search tar ls'\
   --modules='linux16 linux normal iso9660 biosdisk search'\
   --locales=''\
   --fonts=''\
   'boot/grub/grub.cfg=isolinux/grub.cfg'
cat /usr/lib/grub/i386-pc/cdboot.img isolinux/core.img>isolinux/bios.img

# md5sum
sudo bash -c "(find . -type f -print0|xargs -0 md5sum|grep -v -e 'md5sum.txt' -e 'bios.img' -e 'efiboot.img'|tee md5sum.txt>/dev/null)"

# xorriso
sudo xorriso\
   -append_partition 2 0xef isolinux/efiboot.img\
   -as mkisofs\
   -boot-load-size 4\
   -boot-info-table\
   -e EFI/efiboot.img\
   -eltorito-alt-boot\
   -eltorito-boot boot/grub/bios.img\
   --eltorito-catalog boot/grub/boot.cat\
   -full-iso9660-filenames\
   -graft-points\
      '/EFI/efiboot.img=isolinux/efiboot.img'\
      '/boot/grub/bios.img=isolinux/bios.img'\
   --grub2-boot-info\
   --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img\
   -iso-level 3\
   -m 'isolinux/efiboot.img'\
   -m 'isolinux/bios.img'\
   -no-emul-boot\
   -output "/home/runner/work/respin-rdx/$ISO_NAME-respin-rdx.iso"\
   -volid "$FLAVOUR_NAME Respin RDX"\
   '.'