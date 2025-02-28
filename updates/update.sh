#!/bin/bash
set -e
# Alpha 0.2
sudo nala install -y -t bookworm-backports\
    linux-headers-rt\
    linux-image-rt
sudo nala install -y\
    rtirq-init
am -i cryptomator