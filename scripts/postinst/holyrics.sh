#!/bin/bash
set -e

# Holyrics
wget -q --show-progress https://www.holyrics.com.br/download/app/Holyrics-linux-setup-2.21.0.zip
unzip -q Holyrics-linux-setup*.zip
./Holyrics-linux-setup-"*".run
rm Holyrics-linux-setup*.zip Holyrics-linux-setup*.run