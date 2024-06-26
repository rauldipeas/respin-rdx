#!/bin/bash
set -e

# Linux Generic
apt autoremove --purge -y linux*generic*

# Linux RDX
#apt install -y linux-rdx
#update-initramfs -u -k "$(find /boot/|grep vmlinuz|grep -v old|tail -n1|sed 's@/boot/vmlinuz-@@g')"

# XanMod
#wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/xanmod/archive.key|gpg --dearmor -o /etc/apt/trusted.gpg.d/xanmod-archive-keyring.gpg
#echo 'deb http://deb.xanmod.org releases main'|tee /etc/apt/sources.list.d/xanmod-release.list>/dev/null
#apt update
#apt install -y linux-xanmod-x64v3

# CFS Zen tweaks
apt install -y cfs-zen-tweaks
systemctl enable set-cfs-tweaks.service

# Mainline
#add-apt-repository ppa:cappelikan/ppa
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3ae27527713d2479dcaffd58a89d7c1b2f76304d'|gpg --dearmor -o /etc/apt/trusted.gpg.d/cappelikan-ppa.gpg
echo 'deb https://ppa.launchpadcontent.net/cappelikan/ppa/ubuntu jammy main'|tee /etc/apt/sources.list.d/cappelikan-ppa.list
apt update -qq
cat <<EOF |tee /etc/apt/apt.conf.d/100mainline-icon
DPkg::Post-Invoke {"sed -i 's/Icon=mainline/Icon=mintsources-ppa/g' /usr/share/applications/mainline.desktop";};
EOF
apt install -y amd64-microcode intel-microcode mainline thermald

# Latest kernel
KERNEL_VER="v6.1.69/"
#KERNEL_VER="$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/|grep folder|grep -v "\-rc"|tail -n1|cut -d '"' -f8)"
#KERNEL_VER="$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/|grep folder|grep -v "\-rc"|tail -n2|head -n1|cut -d '"' -f8)"
KERNEL_HEADERS_COMMON_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep headers|grep all.deb|cut -d '"' -f2)
KERNEL_HEADERS_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep headers|grep amd64.deb|cut -d '"' -f2)
KERNEL_IMAGE_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep image|grep amd64.deb|cut -d '"' -f2)
KERNEL_MODULES_FILE=$(wget -qO- https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER"|grep modules|grep amd64.deb|cut -d '"' -f2)
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_HEADERS_COMMON_FILE"
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_HEADERS_FILE"
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_IMAGE_FILE"
wget -q --show-progress https://kernel.ubuntu.com/~kernel-ppa/mainline/"$KERNEL_VER""$KERNEL_MODULES_FILE"
apt install -y ./linux-headers*.deb ./linux-image*.deb ./linux-modules*.deb

# ZSwap
echo lz4|tee -a /etc/initramfs-tools/modules>/dev/null
echo lz4_compress|tee -a /etc/initramfs-tools/modules>/dev/null
update-initramfs -u -k all
#update-initramfs -u -k "$(find /boot/|grep vmlinuz|grep -v old|tail -n1|sed 's@/boot/vmlinuz-@@g')"