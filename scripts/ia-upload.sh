#!/bin/bash
set -e

# Internet Archive upload
wget -q --show-progress https://archive.org/download/ia-pex/ia
chmod +x ./ia
cat assets/internetarchive/ia.ini|tee ./ia.ini
./ia -c ./ia.ini upload "$ISO_NAME"-respin-rdx /home/runner/work/respin-rdx/"$ISO_NAME"-respin-rdx.iso