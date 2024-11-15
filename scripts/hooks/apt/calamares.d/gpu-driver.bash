#!/bin/bash
set -e
if [ "\$(cut -d' ' -f9 <(grep NVIDIA <(sudo lshw -C display)))" == NVIDIA ];then
    sudo apt install -y -t bookworm-backports firmware-misc-nonfree nvidia-driver
    echo 'NVIDIA'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep AMD <(sudo lshw -C display)))" == AMD ];then
    echo 'AMD'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep Intel <(sudo lshw -C display)))" == Intel ];then
    echo 'Intel'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep VirtualBox <(sudo lshw -C display)))" == VirtualBox ];then
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ \$(lsb_release -cs)-fasttrack main contrib"|sudo tee /etc/apt/sources.list.d/fasttrack.list>/dev/null
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ \$(lsb_release -cs)-backports-staging main contrib"|sudo tee -a /etc/apt/sources.list.d/fasttrack.list>/dev/null
    sudo apt install -y fasttrack-archive-keyring
    sudo apt update
    sudo apt install --no-install-recommends -y virtualbox-guest-x11
    echo 'VirtualBox'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
fi