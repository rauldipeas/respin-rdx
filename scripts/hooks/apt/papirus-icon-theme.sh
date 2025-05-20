#!/bin/bash
set -e
echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main'|tee /etc/apt/sources.list.d/papirus-ppa.list
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'|gpg --dearmor -o /etc/apt/trusted.gpg.d/papirus-ppa.gpg
apt update
apt install -y papirus-icon-theme