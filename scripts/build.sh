#!/usr/bin/bash
set -e
bash scripts/env.sh
bash scripts/lb-config.sh
bash scripts/hooks.sh
bash scripts/packages.sh
bash scripts/wallpapers.sh
bash scripts/lb-build.sh
mv /tmp/respin-rdx/respin-rdx*.iso .