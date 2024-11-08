#!/bin/bash
set -e
cd scripts/hooks
find . -type f -maxdepth 1 -printf "%f\n" -exec cp {} /tmp/respin-rdx/config/hooks/normal/{}.hook.chroot \;
cd am
find . -type f -printf "%f\n" -exec cp {} /tmp/respin-rdx/config/hooks/normal/{}.hook.chroot \;
cd ../apt
find . -type f -printf "%f\n" -exec cp {} /tmp/respin-rdx/config/hooks/normal/{}.hook.chroot \;
mv /tmp/respin-rdx/config/hooks/normal/kernel.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/00-kernel.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/am.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/01-am.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/flathub.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/01-flathub.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/alsa-firmware.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/zz-alsa-firmware.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/apt.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/zz-apt.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/calamares.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/zz-calamares.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/clean-root.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/zz-clean-root.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/rdx-user-settings.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/zz-rdx-user-settings.sh.hook.chroot
mv /tmp/respin-rdx/config/hooks/normal/splash.sh.hook.chroot /tmp/respin-rdx/config/hooks/normal/splash.sh.hook.binary