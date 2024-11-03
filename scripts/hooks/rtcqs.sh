#!/bin/bash
set -e
# swappiness
cat <<EOF |tee -a /etc/sysctl.d/swappiness.conf>/dev/null
vm.swappiness = 10
EOF
# zswap
cat <<EOF |tee /etc/default/grub.d/rtcqs.cfg>/dev/null
GRUB_CMDLINE_LINUX_DEFAULT="cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs vt.global_cursor_default=0 zswap.enabled=1 zswap.compressor=lz4 zswap.max_pool_percent=20 zswap.zpool=z3fold"
EOF
cat <<EOF |tee -a /etc/initramfs-tools/modules>/dev/null
lz4
lz4_compress
z3fold 
EOF
update-initramfs -u -k all
# cpu-dma-latency
wget -qO- https://github.com/Ardour/ardour/raw/master/tools/udev/99-cpu-dma-latency.rules|tee /etc/udev/rules.d/99-cpu-dma-latency.rules>/dev/null