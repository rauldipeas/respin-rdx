#!/bin/bash
set -e

# debootstrap
mkdir respin-rdx
sudo debootstrap\
   --arch=amd64\
   --variant=minbase\
   jammy\
   "$CHROOT"\
   http://us.archive.ubuntu.com/ubuntu/