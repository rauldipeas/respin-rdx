#!/bin/bash
set -e

# AppGrid
wget -q --show-progress "$(wget -qO- https://www.appgrid.org|grep deb|cut -d "'" -f4)"
mkdir -p /etc/init
apt install -y ./appgrid*.deb

# APT rollback
apt install -y apt-rollback

# Breeze GRUB
apt install -y grub-theme-breeze
echo 'GRUB_THEME="/usr/share/grub/themes/breeze/theme.txt"'|tee /etc/default/grub.d/theme.cfg>/dev/null

# CPU-X
apt install -y cpu-x

# DeltaChat
apt install -y deltachat-desktop

# Discovery/Muon
#apt autoremove --purge -y muon plasma-discover-common

# gdebi
#if [ -f /usr/share/xsessions/ubuntu.desktop ]; then
#    apt install -y gdebi
#fi

# GNOME software
if [ -f /Neon ]; then
    echo 'Neon'
    apt install -y --no-install-recommends plasma-discover-backend-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y org.gtk.Gtk3theme.Breeze
    elif [ -f /UGLR ]; then
    echo 'GNOME Lite Rolling'
    apt install -y --no-install-recommends gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
    elif [ -f /XLR ]; then
    echo 'Xubuntu Lite Rolling'
    apt install -y --no-install-recommends gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y org.gtk.Gtk3theme.Greybird-dark
    elif [ -f /Kubuntu ]; then
    echo 'Kubuntu'
    elif [ -f /KDeck ]; then
    echo 'Kubuntu Deck'
    apt install -y --no-install-recommends plasma-discover-backend-flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y org.gtk.Gtk3theme.Breeze
    else
    echo 'Flavours'
    apt install -y --no-install-recommends gnome-software
fi

# KDE custom-apturl
#if [ -f /usr/share/xsessions/plasma.desktop ]; then
#    apt install -y --no-install-recommends libnotify-bin qapt-deb-installer
#    mkdir -p /usr/local/{bin,share/applications}
#    cat <<EOF |tee /usr/local/bin/qapt-apturl-installer.sh>/dev/null
#!/bin/bash
#set -e
#cd /tmp
#rm -f "\$(find /tmp -name \$(echo \$@*|sed 's/apt://g'|grep -v .deb))"
#notify-send -a "Instalação de programas" -i kget "Baixando o pacote, aguarde alguns instantes..."&
#apt download "\$(echo \$@|sed 's/apt://g')"
#qapt-deb-installer "\$(find /tmp -name \$(echo \$@*|sed 's/apt://g'))"
#EOF
#    chmod +x /usr/local/bin/qapt-apturl-installer.sh
#    cat <<EOF |tee /usr/local/share/applications/qapt-apturl-installer.desktop>/dev/null
#[Desktop Entry]
#Name=AptURL
#Exec=qapt-apturl-installer.sh %u
#Type=Application
#NoDisplay=true
#Categories=System;
#MimeType=x-scheme-handler/apt;
#EOF
#fi

# KDocker
apt install -y kdocker libdbus-glib-1-2

# Kubuntu backports
if [ -f /KDeck ]; then
    add-apt-repository -y ppa:kubuntu-ppa/backports
    apt dist-upgrade -y
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
    elif [ -f /XLR ];then
    echo 'Xubuntu Lite Rolling'
    else
    echo 'Flavours'
    add-apt-repository -y ppa:libreoffice/ppa
    apt dist-upgrade -y -o Dpkg::Options::="--force-confdef" --force-yes
fi

# nala
wget -q --show-progress http://mirrors.kernel.org/ubuntu/pool/universe/n/nala/"$(wget -qO- http://mirrors.kernel.org/ubuntu/pool/universe/n/nala|grep .deb|head -n1|cut -d '"' -f2)"
apt install -y ./nala*.deb

# nohang
apt install -y nohang

# Papirus
add-apt-repository -ny ppa:papirus/hardcode-tray
sed -i 's/jammy/focal/g' /etc/apt/sources.list.d/*hardcode-tray* #tmp-downgrade-fix
add-apt-repository -y ppa:papirus/papirus-dev
apt install -y hardcode-tray papirus-icon-theme papirus-folders
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
    elif [ -f /XLR ];then
    echo 'Xubuntu Lite Rolling'
    else
    echo 'Flavours'
    wget -q --show-progress https://launchpad.net/~papirus/+archive/ubuntu/papirus/+files/libreoffice-style-papirus_20180413-46+pkg3~ubuntu20.04.1_all.deb
    apt install ./libreoffice-style-papirus*.deb
fi

# pipx
rm -rf /opt/pipx/logs
find /opt/pipx -type d -exec chmod 777 {} \;
cat <<EOF |tee /etc/X11/Xsession.d/99pipx
export PIPX_HOME='/opt/pipx'
export PIPX_BIN_DIR='/opt/pipx/bin'
export PATH="\$PATH:/opt/pipx/bin"
EOF

# Qt5 style plugins
if [ -f /Kubuntu ]; then
    echo 'Qt environment'
    elif [ -f /KDeck ]; then
    echo 'Qt environment'
    elif [ -f /Neon ]; then
    echo 'Qt environment'
    else
    echo 'Non-Qt environment, running Qt5 style plugins install'
    apt install -y qt5-style-plugins
fi

# Synaptic
apt install -y synaptic

# Timeshift
apt install -y timeshift

# UnRAR
apt install -y unrar

# Xubuntu extras
if [ -f /Xubuntu ]; then
    add-apt-repository -y ppa:xubuntu-dev/extras
    apt install -y volumeicon-alsa xfce4-appmenu-plugin xfce4-docklike-plugin
    elif [ -f /XLR ]; then
    add-apt-repository -y ppa:xubuntu-dev/extras
    apt install -y volumeicon-alsa xfce4-appmenu-plugin xfce4-docklike-plugin
    # LightPad
    #add-apt-repository -ny ppa:libredeb/lightpad
    #sed -i 's/jammy/focal/g' /etc/apt/sources.list.d/*lightpad* #tmp-downgrade-fix
    #apt update
    #apt install -y com.github.libredeb.lightpad
fi