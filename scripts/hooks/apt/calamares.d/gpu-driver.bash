#!/bin/bash
set -e
if [ "$(cut -d' ' -f9 <(grep NVIDIA <(lshw -C display)))" == NVIDIA ];then
    apt install -y nvidia-detect
    apt install -y -t bookworm-backports firmware-misc-nonfree "$(nvidia-detect|grep nvidia-|cut -d ' ' -f5)"
    echo 'options nvidia-drm modeset=1'|tee /etc/modprobe.d/nvidia-drm.conf>/dev/null
    update-initramfs -u -k all
    echo 'NVIDIA'|tee /home/"$(ls /home)"/.gpu-driver>/dev/null
    if [ "$(cut -d' ' -f9 <(grep Intel <(lshw -C display)))" == Intel ];then
        apt install -y -t bookworm-backports libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers mesa-va-drivers mesa-utils libegl-mesa0 libgbm1 libglapi-mesa
        cat <<EOF |tee /etc/X11/xorg.conf.d/20-intel.conf>/dev/null
Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
   Option      "TearFree"    "true"
EndSection
EOF
        echo 'Intel+NVIDIA'|tee /home/"$(ls /home)"/.gpu-driver>/dev/null
    fi
elif [ "$(cut -d' ' -f9 <(grep AMD <(lshw -C display)))" == AMD ];then
    apt install -y -t bookworm-backports libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers mesa-va-drivers mesa-utils libegl-mesa0 libgbm1 libglapi-mesa
    echo 'AMD'|tee /home/"$(ls /home)"/.gpu-driver>/dev/null
elif [ "$(cut -d' ' -f9 <(grep Radeon <(lshw -C display)))" == Radeon ];then
    apt install -y -t bookworm-backports libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers mesa-va-drivers mesa-utils libegl-mesa0 libgbm1 libglapi-mesa
    echo 'Radeon'|tee /home/"$(ls /home)"/.gpu-driver>/dev/null
elif [ "$(cut -d' ' -f9 <(grep Intel <(lshw -C display)))" == Intel ];then
    apt install -y -t bookworm-backports libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers mesa-va-drivers mesa-utils libegl-mesa0 libgbm1 libglapi-mesa
    cat <<EOF |tee /etc/X11/xorg.conf.d/20-intel.conf>/dev/null
Section "Device"
   Identifier  "Intel Graphics"
   Driver      "intel"
   Option      "TearFree"    "true"
EndSection
EOF
    echo 'Intel'|tee /home/"$(ls /home)"/.gpu-driver>/dev/null
elif [ "$(cut -d' ' -f9 <(grep VirtualBox <(lshw -C display)))" == VirtualBox ];then
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib"|tee /etc/apt/sources.list.d/fasttrack.list>/dev/null
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib"|tee -a /etc/apt/sources.list.d/fasttrack.list>/dev/null
    apt install -y fasttrack-archive-keyring
    apt update
    apt install --no-install-recommends -y virtualbox-guest-x11
    echo 'VirtualBox'|tee /home/"$(ls /home)"/.gpu-driver>/dev/null
fi