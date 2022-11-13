#!/bin/bash

# Live assets
## Criação das pastas na imagem de instalação
mkdir -p respin-rdx/image/{casper,isolinux,install}
## Cópia do núcleo do sistema para a imagem de instalação
find $CHROOT/boot -name "initrd.img-*" -exec sudo cp -v {} respin-rdx/image/casper/initrd \;
find $CHROOT/boot -name "vmlinuz-*" -exec sudo cp -v {} respin-rdx/image/casper/vmlinuz \;
## Criação dos arquivos de identificação do gerenciador de inicialização (GRUB)
touch respin-rdx/image/respin-rdx
sed -i "s/PLACEHOLDER/$FLAVOUR_NAME/g" assets/live/*
cp assets/live/grub.cfg respin-rdx/image/isolinux/grub.cfg
cp assets/live/README.diskdefines respin-rdx/image/README.diskdefines
## Criação dos arquivos de manifesto da imagem de instalação
cp /mnt/casper/*remove* respin-rdx/image/casper/
sudo chroot $CHROOT dpkg-query -W --showformat='${Package} ${Version}\n'|tee respin-rdx/image/casper/filesystem.manifest>/dev/null
cp respin-rdx/image/casper/filesystem.manifest respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/casper/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/discover/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/laptop-detect/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/os-prober/d' respin-rdx/image/casper/filesystem.manifest-desktop
sed -i '/ubiquity/d' respin-rdx/image/casper/filesystem.manifest-desktop
## Compactação do sistema de arquivos
sudo mksquashfs $CHROOT respin-rdx/image/casper/filesystem.squashfs -comp xz -quiet
printf $(sudo du -sx --block-size=1 $CHROOT|cut -f1)|tee respin-rdx/image/casper/filesystem.size>/dev/null