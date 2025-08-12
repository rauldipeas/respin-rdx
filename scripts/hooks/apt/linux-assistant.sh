#!/bin/bash
set -e
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/Jean28518/linux-assistant/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
apt install -y ./linux-assistant*.deb
rm linux-assistant*.deb