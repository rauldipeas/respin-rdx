#!/bin/bash
set -e

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
    else
    echo 'Flavours'
    wget -q --show-progress https://launchpad.net/~papirus/+archive/ubuntu/papirus/+files/libreoffice-style-papirus_20180413-46+pkg3~ubuntu20.04.1_all.deb
    apt install ./libreoffice-style-papirus*.deb
fi

## Ubuntu
if [ -f /Ubuntu ]; then
    echo 'Ubuntu'
    sudo papirus-folders -C yaru
    sed -i 's/firefox_firefox/firefox/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/gtk-theme = "Yaru"/gtk-theme = "Yaru-dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/icon-theme = "Yaru"/icon-theme = "Papirus-Dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/snap-store_ubuntu-software/org.gnome.Software/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/warty-final-ubuntu.png/DSC2943_by_kcpru.jpg/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
fi
## GNOME Lite
if [ -f /UGL ]; then
    echo 'GNOME Lite'
    bash -x enhancements/gnome-lite.sh
    sudo papirus-folders -C adwaita
    cp /usr/share/applications/info.desktop /usr/local/share/applications/
    echo 'Hidden=true'|tee -a /usr/local/share/applications/info.desktop>/dev/null
    wget -q --show-progress  --header="X-Auth-Token: $GITHUB_TOKEN" "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/lassekongo83/adw-gtk3/releases|grep browser_download_url|grep tar.xz|head -n1|cut -d '"' -f4)"
    tar fx adw-gtk3*.tar.xz -C /usr/share/themes/
    sed -i 's/firefox-esr/firefox/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/org.gnome.Evolution/thunderbird/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    #sed -i 's/org.gnome.Software/synaptic/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/adw-gtk3-dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/Adwaita/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/picture-uri/{n;s/adwaita-l.jpg/blobs-l.svg/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/picture-uri-dark/{n;s/adwaita-d.jpg/blobs-d.svg/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.peripherals.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.peripherals.gschema.xml
fi
## GNOME Lite Rolling
if [ -f /UGLR ]; then
    echo 'GNOME Lite Rolling'
    bash -x enhancements/gnome-lite-rolling.sh
    sudo papirus-folders -C adwaita
    cp /usr/share/applications/info.desktop /usr/local/share/applications/
    echo 'Hidden=true'|tee -a /usr/local/share/applications/info.desktop>/dev/null
    wget -q --show-progress "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/lassekongo83/adw-gtk3/releases|grep browser_download_url|grep tar.xz|head -n1|cut -d '"' -f4)"
    tar fx adw-gtk3*.tar.xz -C /usr/share/themes/
    sed -i 's/firefox-esr/firefox/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/org.gnome.Evolution/thunderbird/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    #sed -i 's/org.gnome.Software/synaptic/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/adw-gtk3-dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/Adwaita/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/picture-uri/{n;s/adwaita-l.webp/blobs-l.svg/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/picture-uri-dark/{n;s/adwaita-d.webp/blobs-d.svg/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.peripherals.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.peripherals.gschema.xml
fi
## Kubuntu
if [ -f /Kubuntu ]; then
    echo 'Kubuntu'
    sudo papirus-folders -C breeze
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
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
## Neon
if [ -f /Neon ]; then
    echo 'Neon'
    sudo papirus-folders -C breeze
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    sed -i 's/start-here-kde/distributor-logo-neon/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-neon/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml    
    cat <<EOF |tee /usr/share/plasma/look-and-feel/org.kde.breeze.desktop/contents/defaults
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

[KSplash]
Theme=org.kde.Breeze
EOF
fi
## Xubuntu
if [ -f /Xubuntu ]; then
    echo 'Xubuntu'
    sudo papirus-folders -C paleorange
    rm -r /etc/skel/.config/libreoffice
    mkdir -p /etc/skel/.config/{autostart,volumeicon,xfce4/panel}
    wget -q --show-progress -O /etc/skel/.config/autostart/volumeicon.desktop https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon.desktop
    wget -q --show-progress -O /etc/skel/.config/volumeicon/volumeicon https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon
    wget -q --show-progress -O /etc/skel/.config/xfce4/panel/docklike-2.rc https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/docklike-2.rc
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-superbar.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-superbar.tar.bz2
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-unity.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-unity.tar.bz2
    #sed -i 's/org.gnome.Software/synaptic/g' /etc/skel/.config/xfce4/panel/whiskermenu-1.rc /etc/xdg/xdg-xubuntu/xfce4/whiskermenu/defaults.rc
    sed -i 's/xubuntu-wallpaper.png/Kanchanjunga_Peaks_by_Pushkar_Deshpande.jpg/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/elementary-xfce-darker/Papirus-Dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
fi
## Cinnamon Lite
if [ -f /UCL ]; then
    echo 'Cinnamon Lite'
    bash -x enhancements/cinnamon-lite.sh
    sudo papirus-folders -C orange
    cp /usr/share/applications/info.desktop /usr/local/share/applications/
    echo 'Hidden=true'|tee -a /usr/local/share/applications/info.desktop>/dev/null
    git clone -q https://github.com/germanfr/cinnamon-transparent-panels
    cd cinnamon-transparent-panels
    ./utils.sh install
    mv /root/.local/share/cinnamon/extensions /usr/share/cinnamon/
    cd ..
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.interface.gschema.xml
    sed -i "/enabled-extensions/{n;s/>\[\]</>\['transparent-panels@germanfr'\]</;}" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/Flat-Remix-GTK-Brown-Darkest/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/gnome/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.interface.gschema.xml
    sed -i '/natural-scroll/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.cinnamon.settings-daemon.peripherals.gschema.xml
    sed -i '/org\/cinnamon\/theme/{n;n;n;s/>""</>"Flat-Remix-GTK-Brown-Darkest"</;}' /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/ 'panel1:left:1:show-desktop@cinnamon.org',//g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:left:2:grouped-window-list/panel1:center:1:grouped-window-list/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/ 'panel1:right:5:keyboard@cinnamon.org',//g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/ 'panel1:right:7:network@cinnamon.org',//g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:6/panel1:right:5/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:8/panel1:right:6/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:9/panel1:right:7/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:10/panel1:right:8/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i '/picture-uri/{n;s@themes/Adwaita/backgrounds/adwaita-timed.xml@backgrounds/DSC2943_by_kcpru.jpg@;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.background.gschema.xml
    sed -i 's/tango/oblivion/g' /usr/share/glib-2.0/schemas/org.gnome.gedit.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.cinnamon.settings-daemon.peripherals.gschema.xml
    sed -i '/theme/{n;s/Default/Flat-Remix-Darkest-Metacity/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.wm.preferences.gschema.xml
    rm /usr/share/glib-2.0/schemas/{10_cinnamon-core.gschema.override,10_cinnamon-settings-daemon.gschema.override}
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/Flat-Remix-GTK-Brown-Darkest/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/Adwaita/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.peripherals.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.peripherals.gschema.xml
    sed -i 's@#background=@background=/usr/share/backgrounds/DSC2943_by_kcpru.jpg@g' /etc/lightdm/lightdm-gtk-greeter.conf
    sed -i 's/#theme-name=/theme-name=Flat-Remix-GTK-Brown-Darkest/g' /etc/lightdm/lightdm-gtk-greeter.conf
    sed -i 's/#icon-theme-name=/icon-theme-name=Papirus-Dark/g' /etc/lightdm/lightdm-gtk-greeter.conf
    echo '[SeatDefaults]'|tee -a /etc/lightdm/lightdm.conf.d/50-user-session.conf
    echo 'user-session=cinnamon'|tee -a /etc/lightdm/lightdm.conf.d/50-user-session.conf
fi
## Kubuntu Deck
if [ -f /KDeck ]; then
    echo 'Kubuntu Deck'
    bash -x enhancements/kdeck.sh
    sudo hardcode-tray --apply --theme Papirus-Dark
    sudo papirus-folders -C breeze
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
    git clone -q https://github.com/dragoonDorise/es-theme-epicnoir /usr/share/emulationstation/themes/epicnoir
    mkdir -p /usr/local/share/applications
    cp /usr/share/applications/steam.desktop /usr/local/share/applications/
    sed -i 's@steam://open/bigpicture@-gamepadui@g' /usr/local/share/applications/steam.desktop
    sed -i 's/Name=Big Picture/Name=Gamepad UI/g' /usr/local/share/applications/steam.desktop
    sed -i 's/Categories=Network;/Categories=/g' /usr/local/share/applications/steam.desktop
    cp /usr/share/applications/steam.desktop /etc/xdg/autostart/
    sed -i 's/%U/-gamepadui/g' /etc/xdg/autostart/steam.desktop
#    sed -i 's/plasma/steamos/g' /var/lib/sddm/state.conf
    mkdir -p /etc/sddm.conf.d
    cat <<EOF |sudo tee /etc/sddm.conf.d/kdeck.conf
[Autologin]
Session=/usr/share/xsessions/steamos.desktop
EOF
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    #sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's/systemsettings/steam/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    sed -i 's/start-here-kde/distributor-logo-steamos/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-steamos/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
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
Image=Shell

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

# Ubiquity
find /usr/share/applications -name "*ubiquity*.desktop" -delete