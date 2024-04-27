#!/bin/bash
set -e

# ISO download
set -e
if [ "$VERSION" = daily ]; then
   if [ "$FLAVOUR" = ubuntu ]; then
      wget -q https://cdimage.ubuntu.com/daily-live/current/"$CODENAME"-desktop-amd64.iso
      else
      wget -q https://cdimage.ubuntu.com/"$FLAVOUR"/daily-live/current/"$CODENAME"-desktop-amd64.iso
   fi
   else
   if [ "$FLAVOUR" = ubuntu ]; then
      wget -q https://releases.ubuntu.com/"$VERSION"/ubuntu-"$VERSION"-desktop-amd64.iso
      else
      wget -q https://cdimage.ubuntu.com/"$FLAVOUR"/releases/"$CODENAME"/release/"$FLAVOUR"-"$VERSION"-desktop-amd64.iso
   fi
fi