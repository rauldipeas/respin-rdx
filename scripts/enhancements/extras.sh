#!/bin/bash
set -e

# APT rollback
apt install -y apt-rollback

# Breeze GRUB
apt install -y grub-theme-breeze
echo 'GRUB_THEME="/usr/share/grub/themes/breeze/theme.txt"'|tee /etc/default/grub.d/theme.cfg>/dev/null

# CPU-X
apt install -y cpu-x

# Discovery/Muon
apt autoremove --purge -y muon plasma-discover-common

# gdebi
if [ -f /usr/share/xsessions/ubuntu.desktop ]; then
    apt install -y gdebi
fi

# KDE custom-apturl
if [ -f /usr/share/xsessions/plasma.desktop ]; then
    apt install -y --no-install-recommends libnotify-bin qapt-deb-installer
    mkdir -p /usr/local/{bin,share/applications}
    cat <<EOF |tee /usr/local/bin/qapt-apturl-installer.sh>/dev/null
#!/bin/bash
set -e
cd /tmp
rm -f "\$(find /tmp -name \$(echo \$@*|sed 's/apt://g'|grep -v .deb))"
notify-send -a "Instalação de programas" -i kget "Baixando o pacote, aguarde alguns instantes..."&
apt download "\$(echo \$@|sed 's/apt://g')"
qapt-deb-installer "\$(find /tmp -name \$(echo \$@*|sed 's/apt://g'))"
EOF
    chmod +x /usr/local/bin/qapt-apturl-installer.sh
    cat <<EOF |tee /usr/local/share/applications/qapt-apturl-installer.desktop>/dev/null
[Desktop Entry]
Name=AptURL
Exec=qapt-apturl-installer.sh %u
Type=Application
NoDisplay=true
Categories=System;
MimeType=x-scheme-handler/apt;
EOF
fi

# LibreOffice
if [ -f /Neon ]; then
    echo 'Neon'
    elif [ -f /KDeck ];then
    echo 'Kubuntu Deck'
    elif [ -f /UCL ];then
    echo 'Cinnamon Lite'
    elif [ -f /UGL ]; then
    echo 'GNOME Lite'
    elif [ -f /UGLR ];then
    echo 'GNOME Lite Rolling'
    else
    echo 'Flavours'
    add-apt-repository -y ppa:libreoffice/ppa
    apt dist-upgrade -y -o Dpkg::Options::="--force-confdef" --allow
fi

# nohang
apt install -y nohang

# pipx
rm -rf /opt/pipx/logs
find /opt/pipx -type d -exec chmod 777 {} \;
cat <<EOF |tee /etc/X11/Xsession.d/99pipx
export PIPX_HOME='/opt/pipx'
export PIPX_BIN_DIR='/opt/pipx/bin'
export PATH="\$PATH:/opt/pipx/bin"
EOF

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