#!/bin/bash
set -e

# Papirus
add-apt-repository -ny ppa:papirus/hardcode-tray
sed -i 's/jammy/focal/g' /etc/apt/sources.list.d/*hardcode-tray* #tmp-downgrade-fix
add-apt-repository -y ppa:papirus/papirus-dev
apt install -y hardcode-tray papirus-icon-theme papirus-folders
wget -q https://launchpad.net/~papirus/+archive/ubuntu/papirus/+files/libreoffice-style-papirus_20180413-46+pkg3~ubuntu20.04.1_all.deb
apt install ./libreoffice-style-papirus*.deb
rm libreoffice-style-papirus*.deb

## GNOME
if [ -f /usr/share/xsessions/ubuntu.desktop ]; then
    echo 'GNOME'
    sudo papirus-folders -C yaru
    sed -i 's/firefox_firefox/firefox/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/gtk-theme = "Yaru"/gtk-theme = "Yaru-dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/icon-theme = "Yaru"/icon-theme = "Papirus-Dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/snap-store_ubuntu-software/synaptic/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/warty-final-ubuntu.png/DSC2943_by_kcpru.jpg/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
fi
## KDE
if [ -f /usr/share/xsessions/plasma.desktop ]; then
    echo 'KDE'
    sudo papirus-folders -C breeze
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    rm -r materia-kde
    sed -i 's/start-here-kde/distributor-logo-kubuntu/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-kubuntu/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    cat <<EOF |tee /usr/share/plasma/look-and-feel/org.kubuntu.desktop/contents/defaults
[kdeglobals][KDE]
widgetStyle=Breeze

[kdeglobals][General]
ColorScheme=BreezeDark

[kdeglobals][Icons]
Theme=Papirus-Dark

[plasmarc][Theme]
name=breeze-dark

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
EOF
fi
## XFCE
if [ -f /usr/share/xsessions/xubuntu.desktop ]; then
    echo 'XFCE'
    sudo papirus-folders -C paleorange
    rm -r /etc/skel/.config/libreoffice
    mkdir -p /etc/skel/.config/{autostart,volumeicon,xfce4/panel}
    wget -qO /etc/skel/.config/autostart/volumeicon.desktop https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon.desktop
    wget -qO /etc/skel/.config/volumeicon/volumeicon https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon
    wget -qO /etc/skel/.config/xfce4/panel/docklike-2.rc https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/docklike-2.rc
    wget -qO /usr/share/xfce4-panel-profiles/layouts/rauldipeas-superbar.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-superbar.tar.bz2
    wget -qO /usr/share/xfce4-panel-profiles/layouts/rauldipeas-unity.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-unity.tar.bz2
    sed -i 's/org.gnome.Software/synaptic/g' /etc/skel/.config/xfce4/panel/whiskermenu-1.rc /etc/xdg/xdg-xubuntu/xfce4/whiskermenu/defaults.rc
    sed -i 's/xubuntu-wallpaper.png/Kanchanjunga_Peaks_by_Pushkar_Deshpande.jpg/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/elementary-xfce-darker/Papirus-Dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
fi
## GNOME Lite
if [ -f /UGL ]; then
    echo 'GNOME Lite'
    sudo papirus-folders -C adwaita
    apt autoremove --purge -y\
        libreoffice*\
        ubuntu-desktop*\
        ubuntu-session*\
        yaru*
    apt install -y\
        baobab\
        cheese\
        dmz-cursor-theme\
        gnome-backgrounds\
        gnome-calculator\
        gnome-characters\
        gnome-disk-utility\
        gnome-font-viewer\
        gnome-logs\
        gnome-session\
        gnome-system-monitor\
        gthumb\
        nautilus\
        totem
    wget -q "$(wget -qO- https://api.github.com/repos/lassekongo83/adw-gtk3/releases|grep browser_download_url|grep tar.xz|head -n1|cut -d '"' -f4)"
    tar xf adw-gtk3*.tar.xz -C /usr/share/themes/
    sed -i 's@image/gif\;image/jpeg\;image/png\;@@g' /usr/local/share/applications/firefox.desktop
    #sed -i 's/org.gnome.Epiphany/firefox/g' /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.xml
    #sed -i 's/org.gnome.Calendar/thunderbird/g' /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.xml
    #sed -i 's/org.gnome.Software/synaptic/g' /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.xml
    sed -i 's/firefox-esr/firefox/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/org.gnome.Evolution/thunderbird/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/org.gnome.Software/synaptic/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/adwaita/blobs/g' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/adw-gtk3-dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/Adwaita/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    #sed -i '/picture-uri/{n;s/adwaita-l/blobs-l/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    #sed -i '/picture-uri-dark/{n;s/adwaita-d/blobs-d/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.peripherals.gschema.xml
fi