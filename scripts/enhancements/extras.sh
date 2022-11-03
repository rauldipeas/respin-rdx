#!/bin/bash
set -e

# App Grid
wget -q http://ppa.launchpad.net/appgrid/stable/ubuntu/pool/main/a/appgrid/appgrid_0.310_all.deb
apt install -y ./appgrid*.deb
rm appgrid*.deb

# APT rollback
apt install -y apt-rollback

# Synaptic
apt install -y synaptic

# Timeshift
apt install -y timeshift

# UnRAR
apt install -y unrar