#!/bin/bash
set -e

# chroot
## Montagem da ISO e descompactação do sistema de arquivos compactado
#sudo mount -o loop *-desktop-amd64.iso /mnt
#mkdir respin-rdx
#sudo unsquashfs -q -d "$CHROOT" /mnt/casper/filesystem.squashfs
## Montagem do enjaulamento
sudo mount -o bind /dev "$CHROOT"/dev
sudo mount -o bind /dev/pts "$CHROOT"/dev/pts
sudo mount -o bind /proc "$CHROOT"/proc
sudo mount -o bind /run "$CHROOT"/run
sudo mount -o bind /sys "$CHROOT"/sys
sudo touch "$CHROOT"/"$FLAVOUR_ID"
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
cat <<EOF |tee /etc/apt/preferences.d/nosnap.pref
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
sudo chroot "$CHROOT" apt update
if [ -f /Kubuntu ]; then
    echo 'Kubuntu'
    sudo chroot "$CHROOT" apt install -y kubuntu-desktop
    elif [ -f /KAVIS ]; then
    echo 'Kubuntu Audio Video Image Studio'
    sudo chroot "$CHROOT" apt install -y kubuntu-desktop
    elif [ -f /KDeck ]; then
    echo 'Kubuntu Deck'
    sudo chroot "$CHROOT" apt install -y kubuntu-desktop
    elif [ -f /Xubuntu ]; then
    echo 'Xubuntu'
    sudo chroot "$CHROOT" apt install -y xubuntu-desktop
    else
    echo 'Ubuntu'
    sudo chroot "$CHROOT" apt install -y ubuntu-desktop
fi
## Execução dos scripts de personalização
sudo cp -r scripts/enhancements* "$CHROOT"/
sudo chroot "$CHROOT" bash -x enhancements.sh
sudo rm -rf "$CHROOT"/{Adwaita-for-Steam*,cinnamon-transparent-panels*,enhancements*,firefox*,materia-kde*,MangoHud*,smooth-reaper-theme,Telegram*,thunderbird*,udev-rtirq*,*.deb,*.png,*.svg,*.tar.gz,*.tar.xz,*.zip}
## Desmontagem do enjaulamento
sudo rm "$CHROOT"/"$FLAVOUR_ID"
sudo rm -rf "$CHROOT"/tmp/*
sudo umount "$CHROOT"/dev/pts
sudo umount "$CHROOT"/dev
sudo umount "$CHROOT"/proc
sudo umount "$CHROOT"/run
sudo umount "$CHROOT"/sys