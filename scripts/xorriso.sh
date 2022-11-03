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
   -as mkisofs\
   -iso-level 3\
   -full-iso9660-filenames\
   -volid "$FLAVOUR_NAME Respin RDX"\
   -output "/home/runner/work/respin-rdx/$FLAVOUR-respin-rdx.iso"\
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