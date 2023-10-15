#!/bin/bash
set -e
# Kubuntu Deck
if [ -f /KDeck ]; then
    echo 'Kubuntu Deck'
    bash -x enhancements/custom-spin/kdeck.sh
    wget -q --show-progress -O /usr/share/hardcode-tray/database/deltachat.json https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/hardcode-tray/deltachat.json
    wget -q --show-progress -O /usr/share/hardcode-tray/database/deltachat.electron.json https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/hardcode-tray/deltachat.electron.json
    cat <<EOF |tee /etc/skel/.config/hardcode-tray.json
{
    "icons": {
        "theme": "Papirus-Dark",
        "size": 22
    },
    "backup_ignore": true
}
EOF
    hardcode-tray --apply --theme Papirus-Dark --size 22
    sudo papirus-folders -C violet
    cat <<EOF |tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    wget -q --show-progress -O /usr/share/color-schemes/BreezeBlack.colors https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/KDE/BreezeBlack.colors
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/KDE/breeze-alphablack-v20.zip
    unzip breeze-alphablack-v20.zip -d /usr/share/plasma/desktoptheme/breeze-alphablack
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    mkdir -p /etc/skel/.var/app/info.smplayer.SMPlayer/config/smplayer
    wget -q --show-progress -O /etc/skel/.var/app/info.smplayer.SMPlayer/config/smplayer/smplayer.ini https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/smplayer/smplayer.ini
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
    git clone -q https://github.com/dragoonDorise/es-theme-epicnoir /usr/share/emulationstation/themes/epicnoir
    mkdir -p /usr/local/share/applications
#    cp /usr/share/applications/steam.desktop /usr/local/share/applications/
#    sed -i 's@steam://open/bigpicture@-gamepadui@g' /usr/local/share/applications/steam.desktop
#    sed -i 's/Name=Big Picture/Name=Gamepad UI/g' /usr/local/share/applications/steam.desktop
#    sed -i 's/Categories=Network;/Categories=/g' /usr/local/share/applications/steam.desktop
    cp /usr/share/applications/steam.desktop /etc/xdg/autostart/
    sed -i 's/%U/-gamepadui %U/g' /etc/xdg/autostart/steam.desktop
#    cat <<EOF |tee /etc/xdg/autostart/steam.desktop
#[Desktop Entry]
#Type=Application
#Name=Steam
#Exec=flatpak run com.valvesoftware.Steam -gamepadui
#EOF
#    sed -i 's/plasma/steamos/g' /var/lib/sddm/state.conf
#    mkdir -p /etc/sddm.conf.d
#    cat <<EOF |tee /etc/sddm.conf.d/kdeck.conf
#[Autologin]
#Session=/usr/share/xsessions/steamos.desktop
#EOF
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-alphablack/
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i '/DataCount=8/{n;s/Enabled=false/Enabled=true/;}' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i '/zh_TW/{n;s/Enabled=false/Enabled=true/;}' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i 's/CommandURL=konsole/CommandURL=kitty/g' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's/org.kde.konsole/kitty/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/org.kde.konsole/kitty/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-steamos/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-steamos/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/systemsettings/steam/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    cat <<EOF |tee /usr/share/plasma/look-and-feel/org.kubuntu.desktop/contents/defaults /usr/share/plasma/look-and-feel/org.kde.breezedark.desktop/contents/defaults
[kdeglobals][KDE]
widgetStyle=Breeze

[kdeglobals][General]
ColorScheme=BreezeBlack

[kdeglobals][Icons]
Theme=Papirus-Dark

[plasmarc][Theme]
name=breeze-alphablack

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