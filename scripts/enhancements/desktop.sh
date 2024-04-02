#!/bin/bash
set -e

# Desktop
bash -x enhancements/desktop/ubuntu.sh
bash -x enhancements/desktop/kubuntu.sh
bash -x enhancements/desktop/xubuntu.sh
bash -x enhancements/desktop/ucl.sh
bash -x enhancements/desktop/ugl.sh
bash -x enhancements/desktop/kdeck.sh
bash -x enhancements/desktop/kavis.sh

# Ubiquity
find /usr/share/applications -name "*ubiquity*.desktop" -delete