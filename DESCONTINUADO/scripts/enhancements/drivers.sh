#!/bin/bash
set -e

# MESA
#add-apt-repository ppa:kisak/kisak-mesa
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xeb8b81e14da65431d7504ea8f63f0f2b90935439'|gpg --dearmor -o /etc/apt/trusted.gpg.d/kisak-kisak-mesa.gpg
echo 'deb https://ppa.launchpadcontent.net/kisak/kisak-mesa/ubuntu jammy main'|tee /etc/apt/sources.list.d/kisak-kisak-mesa.list
apt update -qq
apt autoremove --purge -y libgl1-amber-dri #tmp-fix
apt dist-upgrade -y --allow-downgrades

# ALSA firmware
wget -q --show-progress http://ppa.launchpad.net/kxstudio-debian/libs/ubuntu/pool/main/a/alsa-firmware/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/libs/ubuntu/pool/main/a/alsa-firmware/|grep amd64.deb|cut -d '"' -f8)"
apt install -y ./alsa-firmware*.deb

# JACK
#add-apt-repository ppa:ubuntustudio-ppa/backports
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x1220a5ecba1fe99f04cbf741f596cf7036bbaa6d'|gpg --dearmor -o /etc/apt/trusted.gpg.d/ubuntustudio-ppa-backports.gpg
echo 'deb https://ppa.launchpadcontent.net/ubuntustudio-ppa/backports/ubuntu jammy main'|tee /etc/apt/sources.list.d/ubuntustudio-ppa-backports.list
apt update -qq
echo 'jackd2 jackd/tweak_rt_limits string true'|debconf-set-selections>/dev/null
apt install --no-install-recommends -y jackd2

# udev-rtirq
git clone -q https://github.com/jhernberg/udev-rtirq
cd udev-rtirq
make install
cd ..