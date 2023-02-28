#!/bin/bash
set -e

# Linux Generic
apt autoremove --purge -y linux*generic*

# Linux RDX
#apt install -y linux-rdx
#update-initramfs -u -k "$(find /boot/|grep vmlinuz|grep -v old|tail -n1|sed 's@/boot/vmlinuz-@@g')"

# CFS Zen tweaks
apt install -y cfs-zen-tweaks
systemctl enable set-cfs-tweaks.service

# Mainline
add-apt-repository -y ppa:cappelikan/ppa
apt install -y amd64-microcode intel-microcode mainline thermald
sed -i 's/Icon=mainline/Icon=mintsources-ppa/g' /usr/share/applications/mainline.desktop

# Latest kernel
#KERNEL_VER="v6.1.4/"
#KERNEL_VER="$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/|grep folder|grep -v "\-rc"|tail -n2|head -n1|cut -d '"' -f8)"
KERNEL_VER="$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/|grep folder|grep -v "\-rc"|tail -n1|cut -d '"' -f8)"
KERNEL_HEADERS_COMMON_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep headers|grep all.deb|cut -d '"' -f2)
KERNEL_HEADERS_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep headers|grep amd64.deb|cut -d '"' -f2)
KERNEL_IMAGE_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep image|grep amd64.deb|cut -d '"' -f2)
KERNEL_MODULES_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep modules|grep amd64.deb|cut -d '"' -f2)
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_HEADERS_COMMON_FILE"
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_HEADERS_FILE"
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_IMAGE_FILE"
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_MODULES_FILE"
apt install ./linux-headers*.deb ./linux-image*.deb ./linux-modules*.deb

# ZSwap
echo lz4|tee -a /etc/initramfs-tools/modules>/dev/null
echo lz4_compress|tee -a /etc/initramfs-tools/modules>/dev/null
update-initramfs -u -k all