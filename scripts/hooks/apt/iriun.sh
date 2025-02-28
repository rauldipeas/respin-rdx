#!/bin/bash
set -e
apt install -y -t bookworm-backports iriunwebcam
apt autoremove --purge -y linux-headers-amd64 linux-image-amd64