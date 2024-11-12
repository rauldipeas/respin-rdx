#!/bin/bash
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
wget -q --show-progress -O /etc/calamares/branding/debian/welcome.png https://github.com/rauldipeas/respin-rdx/raw/main/assets/calamares-welcome.png
cat <<EOF |tee /etc/calamares/modules/locale.conf>/dev/null
geoip:
    style:    "json"
    url:      "https://geoip.kde.org/v1/calamares"
    selector: ""  # leave blank for the default
EOF
cat <<EOF |tee /etc/calamares/modules/partition.conf>/dev/null
userSwapChoices:
    - none      # Create no swap, use no swap
    - file      # To swap file instead of partition
initialSwapChoice: file
availableFileSystemTypes:  ["xfs","ext4","f2fs"]
defaultFileSystemType: "xfs"
EOF
cat <<EOF |tee /usr/sbin/gpu-driver>/dev/null
#!/bin/bash
set -e
if [ "\$(cut -d' ' -f9 <(grep NVIDIA <(sudo lshw -C display)))" == NVIDIA ];then
    sudo apt install -y -t bookworm-backports firmware-misc-nonfree nvidia-driver
    echo 'NVIDIA'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep AMD <(sudo lshw -C display)))" == AMD ];then
    echo 'AMD'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep Intel <(sudo lshw -C display)))" == Intel ];then
    echo 'Intel'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
elif [ "\$(cut -d' ' -f9 <(grep VirtualBox <(sudo lshw -C display)))" == VirtualBox ];then
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ \$(lsb_release -cs)-fasttrack main contrib"|sudo tee /etc/apt/sources.list.d/fasttrack.list>/dev/null
    echo "deb http://fasttrack.debian.net/debian-fasttrack/ \$(lsb_release -cs)-backports-staging main contrib"|sudo tee -a /etc/apt/sources.list.d/fasttrack.list>/dev/null
    sudo apt install -y fasttrack-archive-keyring
    sudo apt update
    sudo apt install --no-install-recommends -y virtualbox-guest-x11
    echo 'VirtualBox'|sudo tee /home/"\$(ls /home)"/.gpu-driver>/dev/null
fi
EOF
cat <<EOF |tee /usr/sbin/power-manager>/dev/null
if find /sys/class/power_supply|grep BAT;then
	sudo apt install -y tlp
fi
EOF
chmod +x /usr/sbin/gpu-driver
cat <<EOF |tee /etc/calamares/modules/shellprocess.conf>/dev/null
dontChroot: false
script:
    - command: "/usr/sbin/gpu-driver"
      timeout: 180
    - command: "/usr/sbin/power-manager"
      timeout: 180
    - "rm -r /etc/calamares"
EOF
chmod +x /usr/sbin/power-manager
cat <<EOF |tee /etc/live/config.conf.d/respin-rdx.conf>/dev/null
LIVE_HOSTNAME=respin-rdx
LIVE_USERNAME=tux
LIVE_USER_FULLNAME="Tux"
#LIVE_LOCALES=pt_BR.UTF-8
#LIVE_KEYBOARD_LAYOUTS=br
EOF