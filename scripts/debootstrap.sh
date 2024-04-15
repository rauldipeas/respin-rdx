#!/bin/bash
set -e

# debootstrap
mkdir respin-rdx
sudo debootstrap\
   --arch=amd64\
   --variant=minbase\
   "$CODENAME"\
   "$CHROOT"\
   http://us.archive.ubuntu.com/ubuntu/