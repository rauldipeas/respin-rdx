#!/bin/bash
set -e

# Desktop
bash -x enhancements/desktop/*.sh

# Ubiquity
find /usr/share/applications -name "*ubiquity*.desktop" -delete