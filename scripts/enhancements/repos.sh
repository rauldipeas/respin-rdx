#!/bin/bash
set -e

# Ubuntu extra repo
add-apt-repository -ny multiverse
add-apt-repository -ny universe

# Raul Dipeas apt repository
bash -x <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)

# deb-get
wget -qO- https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get|sudo -E bash -s install deb-get