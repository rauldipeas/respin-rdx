#!/usr/bin/bash
set -e
apt install -o Dpkg::Options::="--force-confold" --no-install-recommends -y calamares calamares-settings-debian
sed -i 's|pkexec|GTK2_RC_FILES=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc sudo -E|' /usr/bin/install-debian
sed -i 's|calamares-settings-debian|calamares|' /etc/calamares/modules/packages.conf
sed -i "s|  - sources-final|  - sources-final\n  - shellprocess|" /etc/calamares/settings.conf 
sed -i "s|        - root|        - root\n        - internet|" /etc/calamares/settings.conf 
sed -i 's|1|2|' /etc/calamares/modules/welcome.conf
sed -i 's|true|false|' /etc/calamares/modules/welcome.conf
sed -i 's|main non-free-firmware|contrib main non-free non-free-firmware|' /usr/sbin/sources-final
sed -i 's|deb-src|#deb-src|' /usr/sbin/sources-final
sed -i 's|welcomeStyleCalamares: true|welcomeStyleCalamares: false|' /etc/calamares/branding/debian/branding.desc
sed -i 's|windowExpanding: normal|windowExpanding: noexpand|' /etc/calamares/branding/debian/branding.desc
sed -i 's|windowSize: 800px,520px|windowSize: 800px,750px|' /etc/calamares/branding/debian/branding.desc
sed -i 's|#292F34|#FFFFFF|' /etc/calamares/branding/debian/branding.desc
cp /usr/share/icons/Papirus/64x64/apps/org.linux_hardware.hw-probe.svg /etc/skel/.face
wget -qO /etc/calamares/branding/debian/welcome.png https://github.com/rauldipeas/respin-rdx/raw/main/assets/calamares-welcome.png
wget -qO /etc/calamares/modules/locale.conf https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/apt/calamares.d/locale.conf
wget -qO /etc/calamares/modules/partition.conf https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/apt/calamares.d/partition.conf
wget -qO /etc/calamares/modules/shellprocess.conf https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/apt/calamares.d/shellprocess.conf
wget -qO /etc/live/config.conf.d/respin-rdx.conf https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/apt/calamares.d/live.conf
wget -qO /usr/sbin/gpu-driver https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/apt/calamares.d/gpu-driver.bash
chmod +x /usr/sbin/gpu-driver
wget -qO /usr/sbin/power-manager https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/apt/calamares.d/power-manager.bash
chmod +x /usr/sbin/power-manager