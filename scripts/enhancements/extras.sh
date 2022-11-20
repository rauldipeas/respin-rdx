#!/bin/bash
set -e

# APT rollback
apt install -y apt-rollback

# CPU-X
apt install -y cpu-x

# Discovery/Muon
apt autoremove --purge -y muon plasma-discover-common

# KDE custom-apturl
if [ -f /usr/share/xsessions/plasma.desktop ]; then
apt install -y --no-install-recommends libnotify-bin qapt-deb-installer
mkdir -p /usr/local/{bin,share/applications}
    cat <<EOF |tee /usr/local/bin/qapt-apturl-installer.sh
#!/bin/bash
set -e
cd /tmp
rm -f "$(find /tmp -name $(echo $@*|sed 's/apt://g'|grep -v .deb))"
notify-send -a "Instalação de programas" -i kget "Baixando o pacote, aguarde alguns instantes..."&
apt download "\$(echo \$@|sed 's/apt://g')"
qapt-deb-installer "\$(find /tmp -name \$(echo \$@*|sed 's/apt://g'))"
EOF
chmod +x /usr/local/bin/qapt-apturl-installer.sh
    cat <<EOF |tee /usr/local/share/applications/qapt-apturl-installer.desktop
[Desktop Entry]
Name=AptURL
Exec=qapt-apturl-installer.sh %u
Type=Application
NoDisplay=true
Categories=System;
MimeType=x-scheme-handler/apt;
EOF
fi

# Synaptic
apt install -y synaptic

# Timeshift
apt install -y timeshift

# UnRAR
apt install -y unrar

# Xubuntu extras
if [ -f /usr/share/xsessions/xubuntu.desktop ]; then
    add-apt-repository -y ppa:xubuntu-dev/extras
    apt install -y volumeicon-alsa xfce4-appmenu-plugin xfce4-docklike-plugin
fi

# Update all packages
apt update
apt dist-upgrade -y