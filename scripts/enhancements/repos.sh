#!/bin/bash
set -e

# Ubuntu extra repo
add-apt-repository -ny multiverse
add-apt-repository -ny universe

# Raul Dipeas apt repository
bash -x <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)

# deb-get
apt update
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/wimpysworld/deb-get/releases|grep browser_download_url|grep download|grep .deb|head -n1|cut -d '"' -f4)"
sudo apt install -y ./deb-get*.deb
rm deb-get*.deb

# Pacstall
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/pacstall/pacstall/releases|grep browser_download_url|grep download|grep .deb|head -n1|cut -d '"' -f4)"
sudo apt install -y ./pacstall*.deb
rm pacstall*.deb