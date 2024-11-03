#!/bin/bash
set -e
cd /tmp/respin-rdx
lb config \
    --apt-source-archives false \
    --architectures amd64 \
    --archive-areas "main contrib non-free non-free-firmware" \
    --backports true \
    --bootappend-live "boot=live components cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs vt.global_cursor_default=0 zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=z3fold" \
    --chroot-squashfs-compression-type xz \
    --compression xz \
    --debconf-frontend noninteractive \
    --debian-installer none \
    --distribution bookworm \
    --image-name "respin-rdx" \
    --iso-application "Respin RDX" \
    --iso-publisher "Respin RDX; https://respin-rdx.sourceforge.io; respin-rdx.rauldipeas@lock.email" \
    --iso-volume "Respin RDX" \
    --mirror-bootstrap "https://deb.debian.org/debian/" \
    --mirror-binary "https://deb.debian.org/debian/" \
    --mirror-chroot "https://deb.debian.org/debian/" \
    --system live