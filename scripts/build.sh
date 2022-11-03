#!/bin/bash
set -e

# Build
bash -x setup-host.sh
bash -x iso-download.sh
bash -x chroot.sh
bash -x live-assets.sh
bash -x xorriso.sh