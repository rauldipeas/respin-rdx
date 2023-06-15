#!/bin/bash
set -e
# Neon
if [ -f /Neon ]; then
    echo 'Neon'
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
    sudo hardcode-tray --apply --theme Papirus-Dark --size 22
    sudo papirus-folders -C breeze
    cat <<EOF |sudo tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's@,preferred://browser<@,applications:firefox.desktop<@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i '/Konsole/{n;s/Enabled=false/Enabled=true/;}' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's/org.kde.konsole/kitty/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml
    sed -i 's/org.kde.konsole/kitty/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-neon/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/start-here-kde/distributor-logo-neon/g' /usr/share/plasma/plasmoids/org.kde.plasma.kicker/contents/config/main.xml    
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
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