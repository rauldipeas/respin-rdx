#!/bin/bash
set -e

if [ -f /usr/sbin/udev-rtirq ] && [ -f /usr/lib/udev/rules.d/99-udev-rtirq.rules ];then
    echo udev-rtirq instalado!
    else
    rm -rf udev-rtirq>/dev/null
    git clone -q https://github.com/jhernberg/udev-rtirq
    cd udev-rtirq
    sudo make install
    cd ..
    rm -rf udev-rtirq
fi