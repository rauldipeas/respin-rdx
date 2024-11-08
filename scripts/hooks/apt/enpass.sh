#!/bin/bash
set -e
wget -qO- https://apt.enpass.io/keys/enpass-linux.key|gpg --dearmor -o /etc/apt/trusted.gpg.d/enpass.gpg>/dev/null
echo 'deb https://apt.enpass.io/  stable main'|tee /etc/apt/sources.list.d/enpass.list>/dev/null
apt update
apt install -y enpass