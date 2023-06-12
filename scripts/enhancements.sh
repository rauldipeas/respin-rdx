#!/bin/bash
set -e

# Enhancements
bash -x enhancements/repos.sh
bash -x enhancements/kernel.sh
bash -x enhancements/drivers.sh
bash -x enhancements/rtcqs.sh
bash -x enhancements/firefox.sh
bash -x enhancements/thunderbird.sh
bash -x enhancements/extras.sh
bash -x enhancements/desktop.sh
bash -x enhancements/plymouth.sh