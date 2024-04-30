#!/bin/bash
set -e

## ZSwap
if [ -f /etc/default/grub.d/zswap.cfg ] || [ -f /etc/default/grub.d/rtcqs.cfg ];then
    echo zswap configurado!
    else
    SWAPFILE="$(ls /swap*)"
    RAM="$(grep MemTotal /proc/meminfo|cut -d ' ' -f9)"
    sudo swapoff "$SWAPFILE"
    sudo fallocate -l "$RAM" "$SWAPFILE"
    sudo dd if=/dev/zero of="$SWAPFILE" bs=1024 count="$RAM" status=progress
    sudo chmod 600 "$SWAPFILE"
    sudo mkswap "$SWAPFILE"
    sudo swapon "$SWAPFILE"
    cat <<EOF |sudo tee /etc/default/grub.d/zswap.cfg>/dev/null
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 zswap.compressor=lz4"
EOF
    sudo update-grub
    echo lz4|sudo tee -a /etc/initramfs-tools/modules>/dev/null
    echo lz4_compress|sudo tee -a /etc/initramfs-tools/modules>/dev/null
    sudo update-initramfs -u -k all
fi