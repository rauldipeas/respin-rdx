#!/bin/bash
set -e
wget -qO- https://packagecloud.io/filips/FirefoxPWA/gpgkey|gpg --dearmor -o /etc/apt/trusted.gpg.d/firefoxpwa-keyring.gpg>/dev/null
echo 'deb https://packagecloud.io/filips/FirefoxPWA/any any main'|tee /etc/apt/sources.list.d/firefoxpwa.list>/dev/null
apt update
apt install -y --no-install-recommends firefoxpwa