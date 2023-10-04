#!/bin/bash
set -e

# MESA
add-apt-repository -y ppa:kisak/kisak-mesa
apt autoremove --purge -y libgl1-amber-dri #tmp-fix
apt dist-upgrade -y --allow-downgrades

# ALSA firmware
wget -q --show-progress http://ppa.launchpad.net/kxstudio-debian/libs/ubuntu/pool/main/a/alsa-firmware/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/libs/ubuntu/pool/main/a/alsa-firmware/|grep amd64.deb|cut -d '"' -f8)"
apt install -y ./alsa-firmware*.deb

# JACK
add-apt-repository -y ppa:ubuntustudio-ppa/backports
echo 'jackd2 jackd/tweak_rt_limits string true'|debconf-set-selections>/dev/null
apt install --no-install-recommends -y jackd2

# udev-rtirq
git clone -q https://github.com/jhernberg/udev-rtirq
cd udev-rtirq
make install
cd ..