#!/bin/bash
set -e
LATEST_LINUX_IMAGE="apt search linux-image|grep image|grep bpo-amd64|head -n1|cut -d'/' -f1"
LATEST_LINUX_HEADERS="apt search linux-headers|grep headers|grep bpo-amd64|head -n1|cut -d'/' -f1"
cd /tmp/respin-rdx
lb config\
    --apt-source-archives false\
    --architectures amd64\
    --archive-areas "main contrib non-free non-free-firmware"\
    --backports true\
    --bootappend-live "boot=live components cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs vt.global_cursor_default=0 zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=z3fold"\
    --checksums md5\
    --chroot-squashfs-compression-type xz\
    --compression xz\
    --debconf-frontend noninteractive\
    --debian-installer none\
    --distribution bookworm\
    --image-name "respin-rdx"\
    --iso-application "Respin RDX"\
    --iso-publisher "Respin RDX; https://respin-rdx.sourceforge.io; respin-rdx.rauldipeas@lock.email"\
    --iso-volume "Respin RDX"\
    --linux-packages "$LATEST_LINUX_IMAGE $LATEST_LINUX_HEADERS"\
    --mirror-bootstrap "https://deb.debian.org/debian/"\
    --mirror-binary "https://deb.debian.org/debian/"\
    --mirror-chroot "https://deb.debian.org/debian/"\
    --quiet\
    --system live\
    --utc-time true\