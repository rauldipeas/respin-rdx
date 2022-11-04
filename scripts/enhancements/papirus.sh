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
    echo "GNOME"
    sudo papirus-folders -C yaru
    apt install gnome-software
    sed -i 's/firefox_firefox/firefox/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/gtk-theme = "Yaru"/gtk-theme = "Yaru-dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/icon-theme = "Yaru"/icon-theme = "Papirus-Dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/snap-store_ubuntu-software/appgrid/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/warty-final-ubuntu.png/DSC2943_by_kcpru.jpg/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
fi
## KDE
if [ -f /usr/share/xsessions/plasma.desktop ]; then
    echo "KDE"
    sudo papirus-folders -C breeze
    sed -i 's/org.kde.discover/appgrid/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/org.kde.discover/appgrid/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/org.kde.discover/appgrid/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
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
    echo "XFCE"
    sudo papirus-folders -C paleorange
    rm -r /etc/skel/.config/libreoffice
    sed -i 's/org.gnome.Software/appgrid/g' /etc/skel/.config/xfce4/panel/whiskermenu-1.rc /etc/xdg/xdg-xubuntu/xfce4/whiskermenu/defaults.rc
    sed -i 's/xubuntu-wallpaper.png/Kanchanjunga_Peaks_by_Pushkar_Deshpande.jpg/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/elementary-xfce-darker/Papirus-Dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
fi