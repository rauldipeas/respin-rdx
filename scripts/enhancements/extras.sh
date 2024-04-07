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
#apt autoremove --purge -y muon plasma-discover-common

# gdebi
#if [ -f /usr/share/xsessions/ubuntu.desktop ]; then
#    apt install -y gdebi
#fi

# GNOME software
if [ -f /Kubuntu ]; then
    echo 'Kubuntu'
    elif [ -f /KAVIS ]; then
    echo 'Kubuntu Audio Video Image Studio'
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

# Kitty
apt install -y kitty
apt autoremove --purge -y gnome-terminal konsole xfce4-terminal

# Kubuntu backports
if [ -f /KDeck ]; then
    #add-apt-repository ppa:kubuntu-ppa/backports 
    wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe4dfec907deda4b8a670e8042836cb0a8ac93f7a'|gpg --dearmor -o /etc/apt/trusted.gpg.d/kubuntu-ppa-backports.gpg
    echo 'deb https://ppa.launchpadcontent.net/kubuntu-ppa/backports/ubuntu jammy main'|tee /etc/apt/sources.list.d/kubuntu-ppa-backports.list
    apt update -qq
    apt dist-upgrade -y
    elif [ -f /KAVIS ]; then
    #add-apt-repository ppa:kubuntu-ppa/backports
    wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe4dfec907deda4b8a670e8042836cb0a8ac93f7a'|gpg --dearmor -o /etc/apt/trusted.gpg.d/kubuntu-ppa-backports.gpg
    echo 'deb https://ppa.launchpadcontent.net/kubuntu-ppa/backports/ubuntu jammy main'|tee /etc/apt/sources.list.d/kubuntu-ppa-backports.list
    apt update -qq
    apt dist-upgrade -y
fi

# LibreOffice
if [ -f /KDeck ];then
    echo 'Kubuntu Deck'
    elif [ -f /UCL ];then
    echo 'Cinnamon Lite'
    elif [ -f /UGL ]; then
    echo 'GNOME Lite'
    else
    echo 'Flavours'
    #add-apt-repository ppa:libreoffice/ppa
    wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x36e81c9267fd1383fcc4490983fba1751378b444'|gpg --dearmor -o /etc/apt/trusted.gpg.d/libreoffice-ppa.gpg
    echo 'deb https://ppa.launchpadcontent.net/libreoffice/ppa/ubuntu jammy main'|tee /etc/apt/sources.list.d/libreoffice-ppa.list
    apt update -qq
    apt dist-upgrade -y -o Dpkg::Options::="--force-confdef" --force-yes
fi

# nala
wget -q --show-progress http://mirrors.kernel.org/ubuntu/pool/universe/n/nala/"$(wget -qO- http://mirrors.kernel.org/ubuntu/pool/universe/n/nala|grep .deb|head -n1|cut -d '"' -f2)"
apt install -y ./nala*.deb

# nohang
apt install -y nohang

# Papirus
#add-apt-repository ppa:papirus/hardcode-tray
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446faf0df770bfc9ae58a9d36647cae7f'|gpg --dearmor -o /etc/apt/trusted.gpg.d/papirus-hardcode-tray.gpg
echo 'deb https://ppa.launchpadcontent.net/papirus/hardcode-tray/ubuntu focal main'|tee /etc/apt/sources.list.d/papirus-hardcode-tray.list
apt update -qq
#sed -i 's/jammy/focal/g' /etc/apt/sources.list.d/*hardcode-tray* #tmp-downgrade-fix
#add-apt-repository ppa:papirus/papirus-dev
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446faf0df770bfc9ae58a9d36647cae7f'|gpg --dearmor -o /etc/apt/trusted.gpg.d/papirus-papirus-dev.gpg
echo 'deb https://ppa.launchpadcontent.net/papirus/papirus-dev/ubuntu jammy main'|tee /etc/apt/sources.list.d/papirus-papirus-dev.list
apt update -qq
apt install -y hardcode-tray papirus-icon-theme papirus-folders
if [ -f /KDeck ];then
    echo 'Kubuntu Deck'
    elif [ -f /UCL ];then
    echo 'Cinnamon Lite'
    elif [ -f /UGL ]; then
    echo 'GNOME Lite'
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
    elif [ -f /KAVIS ]; then
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
    #add-apt-repository ppa:xubuntu-dev/extras
    wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x07d44a5424c7c12a4bab1e80eb563f93142986ce'|gpg --dearmor -o /etc/apt/trusted.gpg.d/xubuntu-dev-extras.gpg
    echo 'deb https://ppa.launchpadcontent.net/xubuntu-dev/extras/ubuntu jammy main'|tee /etc/apt/sources.list.d/xubuntu-dev-extras.list
    apt update -qq
    apt install -y volumeicon-alsa xfce4-appmenu-plugin xfce4-docklike-plugin
    # LightPad
    ##add-apt-repository ppa:libredeb/lightpad
    #wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x915a8790215835440cb8d7c09f5ab4ce89a00d47'|gpg --dearmor -o /etc/apt/trusted.gpg.d/libredeb-lightpad.gpg
    #echo 'deb https://ppa.launchpadcontent.net/libredeb/lightpad/ubuntu focal main'|tee /etc/apt/sources.list.d/libredeb-lightpad.list
    #apt update -qq
    ##sed -i 's/jammy/focal/g' /etc/apt/sources.list.d/*lightpad* #tmp-downgrade-fix
    #apt update
    #apt install -y com.github.libredeb.lightpad
fi