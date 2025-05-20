#!/bin/bash
set -e
# extrepo
sed -i 's|# -|-|' /etc/extrepo/config.yaml
# KXStudio
wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
apt install ./kxstudio-repos*.deb
rm ./kxstudio-repos*.deb
# MPR
#wget -qO- https://proget.makedeb.org/debian-feeds/makedeb.pub|gpg --dearmor -o /etc/apt/trusted.gpg.d/makedeb-archive-keyring.gpg>/dev/null
#echo 'deb [arch=all] https://proget.makedeb.org/ makedeb main'|tee /etc/apt/sources.list.d/makedeb.list>/dev/null
# MEGA
wget -qO- https://mega.nz/keys/MEGA_signing.key|gpg --dearmor -o /etc/apt/trusted.gpg.d/megasync.gpg>/dev/null
echo 'deb https://mega.nz/linux/repo/Debian_12/ ./'|tee /etc/apt/sources.list.d/megasync.list>/dev/null
# Raul Dipeas
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)