#!/bin/bash
set -e
# Kubuntu Autio Video Image Studio
if [ -f /KAVIS ]; then
    echo 'KAVIS'
    bash -x enhancements/custom-spin/kavis.sh
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
    sudo papirus-folders -C breeze
    cat <<EOF |tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    mkdir -p /etc/skel/.config/touchegg
    wget -q --show-progress -O /etc/skel/.config/touchegg/touchegg.conf https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/touchegg/touchegg.conf
    mkdir -p /usr/share/color-schemes
    wget -q --show-progress -O /usr/share/color-schemes/BreezeBlack.colors https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/KDE/BreezeBlack.colors
    wget -q --show-progress https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/KDE/breeze-alphablack-v20.zip
    unzip breeze-alphablack-v20.zip -d /usr/share/plasma/desktoptheme/breeze-alphablack
    echo 'gtk-application-prefer-dark-theme=true'|tee -a /etc/gtk-3.0/settings.ini
    mkdir -p /etc/skel/.config/smplayer
    wget -q --show-progress -O /etc/skel/.config/smplayer/smplayer.ini https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/smplayer/smplayer.ini
    sed -i 's/Yaru/Breeze/g' /etc/gtk-3.0/settings.ini
    git clone -q https://github.com/dark-eye/com.darkeye.chatGPT
    cp -r com.darkeye.chatGPT/package /usr/share/plasma/plasmoids/com.darkeye.chatGPT
    git clone -q https://github.com/HimDek/Overview-Widget-for-Plasma
    cp -r Overview-Widget-for-Plasma /usr/share/plasma/plasmoids/com.himdek.kde.plasma.overview
    sed -i 's/bottom/temp/g' /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
    sed -i 's/top/bottom/g' /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
    sed -i 's/temp/top/g' /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
    sed -i 's/panel.addWidget("org.kde.plasma.minimizeall")//g' /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
    sed -i 's/panel.height = 2/panel.height = 1.7/g' /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
    sed -i 's/panel.addWidget("org.kde.plasma.digitalclock")/var digitalclock = panel.addWidget("org.kde.plasma.digitalclock")/g' /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
    cat <<EOF |tee -a /usr/share/plasma/layout-templates/org.kubuntu.desktop.defaultPanel/contents/layout.js
digitalclock.writeConfig("showDate", "false")
var appmenu = panel.addWidget("org.kde.plasma.appmenu")
appmenu.writeConfig("compactView", "true")
panel.addWidget("com.darkeye.chatGPT")
panel.addWidget("com.himdek.kde.plasma.overview")
panel.addWidget("org.kde.plasma.minimizeall")
EOF
    cat <<EOF |tee -a /usr/share/kubuntu-default-settings/kf5-settings/kwinrc
magiclampEnabled=true

[Script-bismuth]
floatingClass=cpu-x,kcalc,mini-video-me,reaper,rtcqs,simplescreenrecorder,wineboot.exe,yabridge-host.exe.so
screenGapBottom=10
screenGapLeft=10
screenGapRight=10
screenGapTop=10
tileLayoutGap=10
EOF
    wget -q --show-progress -O /etc/skel/.config/kwinrulesrc https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/kwin/kwinrulesrc
    git clone -q https://github.com/PapirusDevelopmentTeam/materia-kde
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-alphablack/
    mkdir -p /usr/share/plasma/desktoptheme/breeze-dark
    cp -r materia-kde/plasma/desktoptheme/Materia/icons /usr/share/plasma/desktoptheme/breeze-dark/
    cp -r materia-kde/plasma/desktoptheme/Materia-Color/icons /usr/share/plasma/desktoptheme/breeze-light/
    cp /usr/share/applications/cadence.desktop /etc/xdg/autostart/
    sed -i 's@applications:systemsettings.desktop,applications:org.kde.discover.desktop,preferred://filemanager,preferred://browser@preferred://filemanager,applications:firefox.desktop,applications:cockos-reaper.desktop,applications:org.kde.kdenlive.desktop,applications:gimp.desktop@g' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickerdash/contents/config/main.xml
    sed -i 's@>preferred://browser,@>firefox.desktop,@g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i '/DataCount=8/{n;s/Enabled=false/Enabled=true/;}' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i '/zh_TW/{n;s/Enabled=false/Enabled=true/;}' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i 's/ --minimized-/-/g' /etc/xdg/autostart/cadence.desktop 
    sed -i 's/CommandURL=konsole/CommandURL=kitty/g' /usr/share/khotkeys/kde32b1.khotkeys
    sed -i 's/Exec=cadence/Exec=cadence --minimized/g' /etc/xdg/autostart/cadence.desktop
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickerdash/contents/config/main.xml
    sed -i 's/org.kde.discover/synaptic/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/org.kde.konsole/kitty/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickerdash/contents/config/main.xml
    sed -i 's/org.kde.konsole/kitty/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
    sed -i 's/start-here-kde/audio-speaker-mono-testing/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickerdash/contents/config/main.xml
    sed -i 's/start-here-kde/audio-speaker-mono-testing/g' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
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
Image=Flow

[kcminputrc][Mouse]
cursorTheme=Breeze_Snow

[kwinrc][WindowSwitcher]
LayoutName=org.kde.breeze.desktop

[kwinrc][DesktopSwitcher]
LayoutName=org.kde.breeze.desktop

[kwinrc][org.kde.kdecoration2]
library=org.kde.breeze

[KSplash]
Theme=none
EOF
    cat <<EOF |tee /usr/share/kubuntu-default-settings/kf5-settings/kdeglobals
[General]
XftAntialias=true
XftHintStyle=hintslight
XftSubPixel=rgb
BrowserApplication=firefox.desktop
font=FreeSans,10,-1,5,50,0,0,0,0,0
menuFont=FreeSans,10,-1,5,50,0,0,0,0,0
smallestReadableFont=FreeSans,8,-1,5,50,0,0,0,0,0
toolBarFont=FreeSans,10,-1,5,50,0,0,0,0,0

[KDE]
LookAndFeelPackage=org.kubuntu.desktop
SingleClick=false

[WM]
activeFont=FreeSans,10,-1,5,50,0,0,0,0,0
EOF
    cat <<EOF |tee /etc/skel/.config/plasmahudrc
[Style]
Font=FreeSans 10

[Icons]
Enabled=true
Theme=Papirus-Dark
EOF
fi