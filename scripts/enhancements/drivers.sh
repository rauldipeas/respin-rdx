#!/bin/bash
set -e

# MESA
add-apt-repository -y ppa:kisak/kisak-mesa
apt dist-upgrade -y

# JACK
add-apt-repository -y ppa:ubuntustudio-ppa/backports
echo 'jackd2 jackd/tweak_rt_limits string true'|debconf-set-selections>/dev/null
apt install --no-install-recommends -y jackd2

# udev-rtirq
git clone -q https://github.com/jhernberg/udev-rtirq
cd udev-rtirq
make install
cd ..
rm -r udev-rtirq
