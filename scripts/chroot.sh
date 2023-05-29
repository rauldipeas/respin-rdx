#!/bin/bash
set -e

# chroot
## Montagem da ISO e descompactação do sistema de arquivos compactado
if [ "$FLAVOUR" = neon ]; then
    sudo mount -o loop neon-user-current.iso /mnt
    else
    sudo mount -o loop "$FLAVOUR"-*-desktop-amd64.iso /mnt
fi
mkdir respin-rdx
sudo unsquashfs -q -d "$CHROOT" /mnt/casper/filesystem.squashfs
## Montagem do enjaulamento
sudo mount -o bind /dev "$CHROOT"/dev
sudo mount -o bind /dev/pts "$CHROOT"/dev/pts
sudo mount -o bind /proc "$CHROOT"/proc
sudo mount -o bind /run "$CHROOT"/run
sudo mount -o bind /sys "$CHROOT"/sys
sudo touch "$CHROOT"/"$FLAVOUR_ID"
## Execução dos scripts de personalização
sudo cp -r scripts/enhancements* "$CHROOT"/
sudo chroot "$CHROOT" bash -x enhancements.sh
sudo rm -rf "$CHROOT"/{Adwaita-for-Steam*,betterbird*,cinnamon-transparent-panels*,enhancements*,firefox*,materia-kde*,MangoHud*,Telegram*,udev-rtirq*,*.deb,*.png,*.svg,*.tar.gz,*.tar.xz,*.zip}
## Desmontagem do enjaulamento
sudo rm "$CHROOT"/"$FLAVOUR_ID"
sudo rm -rf "$CHROOT"/tmp/*
sudo umount "$CHROOT"/dev/pts
sudo umount "$CHROOT"/dev
sudo umount "$CHROOT"/proc
sudo umount "$CHROOT"/run
sudo umount "$CHROOT"/sys