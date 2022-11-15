#!/bin/bash
set -e

# Build
bash -x scripts/setup-host.sh
bash -x scripts/iso-download.sh
bash -x scripts/chroot.sh
bash -x scripts/live-assets.sh
bash -x scripts/xorriso.sh
bash -x scripts/ia-upload.sh