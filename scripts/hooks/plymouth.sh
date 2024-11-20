#!/bin/bash
set -e
wget -q --show-progress https://github.com/rauldipeas/respin-rdx/raw/main/assets/compressed/debian-mac-style.zip
unzip debian-mac-style.zip
rm debian-mac-style.zip
cp -R debian-mac-style /usr/share/plymouth/themes/
rm -r debian-mac-style
plymouth-set-default-theme -R debian-mac-style
#wget -q --show-progress https://github.com/rauldipeas/respin-rdx/raw/main/assets/compressed/rings_2.tar.gz
#tar -xf rings_2.tar.gz
#rm rings_2.tar.gz
#cp -R rings_2 /usr/share/plymouth/themes/
#rm -r rings_2
#plymouth-set-default-theme -R rings_2
update-initramfs -u
mkdir -p /etc/systemd/system/display-manager.service.d
cat <<EOF |tee /etc/systemd/system/display-manager.service.d/plymouth.conf>/dev/null
[Unit]
Conflicts=plymouth-quit.service
After=plymouth-quit.service rc-local.service plymouth-start.service systemd-user-sessions.service
OnFailure=plymouth-quit.service

[Service]
ExecStartPost=-/usr/bin/sleep 30
ExecStartPost=-/usr/bin/plymouth quit --retain-splash
EOF
rm -r /usr/share/desktop-base/debian-logos
ln -sf /dev/null /usr/share/desktop-base/debian-logos