#!/bin/bash

# This script provides common customization options for the ISO
# 
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# The version of Ubuntu to generate.  Successfully tested: bionic, cosmic, disco, eoan, focal, groovy, jammy
# See https://wiki.ubuntu.com/DevelopmentCodeNames for details
export TARGET_UBUNTU_VERSION="jammy"

# The Ubuntu Mirror URL. It's better to change for faster download.
# More mirrors see: https://launchpad.net/ubuntu/+archivemirrors
export TARGET_UBUNTU_MIRROR="http://br.archive.ubuntu.com/ubuntu/"

# The packaged version of the Linux kernel to install on target image.
# See https://wiki.ubuntu.com/Kernel/LTSEnablementStack for details
export TARGET_KERNEL_PACKAGE="linux-rdx"

# The file (no extension) of the ISO containing the generated disk image,
# the volume id, and the hostname of the live environment are set from this name.
export TARGET_NAME="neon-rdx"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Iniciar o Neon RDX"

# Packages to be removed from the target system after installation completes succesfully
export TARGET_PACKAGE_REMOVE="
    calamares \
    casper \
    discover \
    laptop-detect \
    os-prober \
"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    # mainline
    add-apt-repository -y ppa:cappelikan/ppa
    pkcon -y mainline
    sed -i 's/Icon=mainline/Icon=mintsources-ppa/g' /usr/share/applications/mainline.desktop

    # Linux Generic
    apt autoremove --purge -y linux*generic*

    # MESA
    add-apt-repository -y ppa:kisak/kisak-mesa
    pkcon update -y

    # JACK
    add-apt-repository -y ppa:ubuntustudio-ppa/backports
    echo 'jackd2 jackd/tweak_rt_limits string true'|sudo debconf-set-selections>/dev/null
    apt install --no-install-recommends -y jackd2
    
    # rtcqs
    pkcon install -y python3-pip python3-tk
    pip install -q rtcqs
    wget -qO /usr/share/applications/rtcqs.desktop https://github.com/autostatic/rtcqs/raw/main/rtcqs.desktop
    wget -qO /usr/share/icons/rtcqs.svg https://github.com/autostatic/rtcqs/raw/main/rtcqs_logo.svg
    
    # GRUB
    echo 'GRUB_CMDLINE_LINUX_DEFAULT="cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs"'|tee /etc/default/grub.d/cmdline-linux-default.cfg>/dev/null

    # Swapiness
    echo 'vm.swappiness = 10'|tee /etc/sysctl.d/swappiness.conf>/dev/null
    
    # CPU DMA latency
    wget -qO /etc/udev/rules.d/99-cpu-dma-latency.rules https://raw.githubusercontent.com/Ardour/ardour/master/tools/udev/99-cpu-dma-latency.rules

    # Extra groups
    sed -i 's/#ADD_EXTRA_GROUPS=1/ADD_EXTRA_GROUPS=1/g' /etc/adduser.conf
    sed -i 's/#EXTRA_GROUPS=/EXTRA_GROUPS=/g' /etc/adduser.conf

    # XDG portal
    mkdir -p /etc/skel/.config/systemd/user
    ln -sf /dev/null /etc/skel/.config/systemd/user/xdg-desktop-portal.service

    # deb-get
    wget -qO- https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get|sudo -E bash -s install deb-get

    # Firefox
    apt autoremove --purge -y *firefox* snapd
    wget -qO firefox-latest-linux64-pt-br.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=pt-BR"
    tar xjf firefox-latest-linux64-pt-br.tar.bz2
    mkdir -p /opt/firefox
    chmod 777 -R /opt/firefox
    mv firefox/* /opt/firefox/
    rm -r firefox firefox-latest-linux64-pt-br.tar.bz2
    mkdir -p /usr/local/bin /usr/local/share/applications /usr/local/share/pixmaps
    ln -fs /opt/firefox/firefox /usr/local/bin/firefox
    ln -fs /opt/firefox/browser/chrome/icons/default/default128.png /usr/local/share/pixmaps/firefox.png
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml    
    cat <<EOF |tee /opt/firefox/defaults/pref/csd.js>/dev/null
pref("browser.tabs.inTitlebar", 1);
EOF
    cat <<EOF |tee /usr/local/share/applications/firefox.desktop>/dev/null
[Desktop Entry]
Version=1.0
Name=Firefox
Comment=Navegue na internet
GenericName=Navegador de internet
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true

Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=Abrir uma nova janela
Exec=firefox -new-window

[Desktop Action new-private-window]
Name=Abrir uma nova janela no modo privado
Exec=firefox -private-window
EOF

    # Thunderbird
    apt autoremove --purge -y *thunderbird*
    wget -qO thunderbird-latest-linux64-pt-br.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=pt-BR"
    tar xjf thunderbird-latest-linux64-pt-br.tar.bz2
    mkdir -p /opt/thunderbird
    chmod 777 -R /opt/thunderbird
    mv thunderbird/* /opt/thunderbird/
    rm -r thunderbird thunderbird-latest-linux64-pt-br.tar.bz2
    mkdir -p /usr/local/bin /usr/local/share/applications /usr/local/share/pixmaps
    ln -fs /opt/thunderbird/thunderbird /usr/local/bin/thunderbird
    ln -fs /opt/thunderbird/chrome/icons/default/default128.png /usr/local/share/pixmaps/thunderbird.png
    cat <<EOF |tee /usr/local/share/applications/thunderbird.desktop>/dev/null
[Desktop Entry]
Encoding=UTF-8
Name=Thunderbird
Comment=Envie e receba e-mails com o Thunderbird
GenericName=Cliente de e-mail
Keywords=Email;E-mail;Newsgroup;Feed;RSS
Exec=thunderbird %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=thunderbird
Categories=Application;Network;Email;
MimeType=x-scheme-handler/mailto;application/x-xpinstall;
StartupNotify=true
Actions=Compose;Contacts

[Desktop Action Compose]
Name=Compor uma nova mensagem
Exec=thunderbird -compose

[Desktop Action Contacts]
Name=Contatos
Exec=thunderbird -addressbook
EOF

    # HUD
    pkcon install -y plasma-hud

    # Bismith
    pkcon install -y kwin-bismuth

    # Papirus
    add-apt-repository -ny ppa:papirus/hardcode-tray
    sed -i 's/jammy/focal/g' /etc/apt/sources.list.d/*hardcode-tray*.list #tmp-downgrade-fix
    add-apt-repository -y ppa:papirus/papirus-dev
    pkcon install -y hardcode-tray papirus-icon-theme papirus-folders
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    sudo cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    sudo cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    rm -r materia-kde
    sed -i 's/start-here-kde/distributor-logo-neon/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-neon/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml    
    cat <<EOF |tee /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/defaults
[kdeglobals][KDE]
widgetStyle=Breeze

[kdeglobals][General]
ColorScheme=BreezeLight

[kdeglobals][Icons]
Theme=Papirus

[plasmarc][Theme]
name=breeze-light

[Wallpaper]
Image=Altai

[kcminputrc][Mouse]
cursorTheme=Breeze_Snow

[kwinrc][WindowSwitcher]
LayoutName=org.kde.breeze.desktop

[kwinrc][DesktopSwitcher]
LayoutName=org.kde.breeze.desktop

[kwinrc][org.kde.kdecoration2]
library=org.kde.breeze

[KSplash]
Theme=org.kde.Breeze
EOF

    # GNOME disks
    pkcon install -y gnome-disk-utility

    # Synaptic
    pkcon install -y synaptic

    # Timeshift
    pkcon install -y timeshift

    # CFS Zen tweaks
    pkcon install -y cfs-zen-tweaks
    
    # UnRAR
    pkcon install -y unrar

    # APT rollback
    pkcon install -y apt-rollback

    # purge
    apt autoremove --purge -y *partitionmanager*
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.4"