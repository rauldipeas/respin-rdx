#!/bin/bash
set -e

# Vortex Plymouth
git clone -q https://github.com/emanuele-scarsella/vortex-ubuntu-plymouth-theme
cd vortex-ubuntu-plymouth-theme
chmod +x install
./install
cd ..
rm -rf vortex-ubuntu-plymouth-theme