#!/bin/bash

# ISO download
set -e
if [ $FLAVOUR = ubuntu ]; then
   wget -q https://releases.ubuntu.com/$VERSION/ubuntu-$VERSION-desktop-amd64.iso
   elif [ $FLAVOUR = neon ]; then
   wget -q https://files.kde.org/neon/images/user/current/neon-user-current.iso
   else
   wget -q https://cdimage.ubuntu.com/$FLAVOUR/releases/$CODENAME/release/$FLAVOUR-$VERSION-desktop-amd64.iso
fi