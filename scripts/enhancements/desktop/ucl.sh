#!/bin/bash
set -e
# Cinnamon Lite
if [ -f /UCL ]; then
    echo 'Cinnamon Lite'
    bash -x enhancements/cinnamon-lite.sh
    wget -q --show-progress -O /usr/share/hardcode-tray/database/deltachat.json https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/hardcode-tray/deltachat.json
    wget -q --show-progress -O /usr/share/hardcode-tray/database/deltachat.electron.json https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/hardcode-tray/deltachat.electron.json
    cat <<EOF |tee /etc/skel/.config/hardcode-tray.json
{
    "icons": {
        "theme": "Papirus-Dark",
        "size": 24
    },
    "backup_ignore": true
}
EOF
    sudo hardcode-tray --apply --theme Papirus-Dark --size 24
    sudo papirus-folders -C orange
    cat <<EOF |sudo tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    cat <<EOF |sudo tee /etc/profile.d/qt-qpa-platformtheme.sh
export QT_QPA_PLATFORMTHEME=gtk2
EOF
    cp /usr/share/applications/info.desktop /usr/local/share/applications/
    echo 'Hidden=true'|tee -a /usr/local/share/applications/info.desktop>/dev/null
    git clone -q https://github.com/germanfr/cinnamon-transparent-panels
    cd cinnamon-transparent-panels
    ./utils.sh install
    mv /root/.local/share/cinnamon/extensions /usr/share/cinnamon/
    cd ..
    mkdir -p /etc/skel/.config/smplayer
    wget -q --show-progress -O /etc/skel/.config/smplayer/smplayer.ini https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/smplayer/smplayer.ini    
    echo '[SeatDefaults]'|tee -a /etc/lightdm/lightdm.conf.d/50-user-session.conf
    echo 'user-session=cinnamon'|tee -a /etc/lightdm/lightdm.conf.d/50-user-session.conf
    rm /usr/share/glib-2.0/schemas/{10_cinnamon-core.gschema.override,10_cinnamon-settings-daemon.gschema.override}
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/Adwaita/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/gnome/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.interface.gschema.xml
    sed -i "/enabled-extensions/{n;s/>\[\]</>\['transparent-panels@germanfr'\]</;}" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/Flat-Remix-GTK-Brown-Darkest/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.interface.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/Flat-Remix-GTK-Brown-Darkest/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/natural-scroll/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.cinnamon.settings-daemon.peripherals.gschema.xml
    sed -i '/natural-scroll/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.cinnamon.settings-daemon.peripherals.gschema.xml
    sed -i '/org\/cinnamon\/theme/{n;n;n;s/>""</>"Flat-Remix-GTK-Brown-Darkest"</;}' /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i '/picture-uri/{n;s@themes/Adwaita/backgrounds/adwaita-timed.xml@backgrounds/DSC2943_by_kcpru.jpg@;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.background.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.cinnamon.settings-daemon.peripherals.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.peripherals.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.peripherals.gschema.xml
    sed -i '/theme/{n;s/Default/Flat-Remix-Darkest-Metacity/;}' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.wm.preferences.gschema.xml
    sed -i 's@#background=@background=/usr/share/backgrounds/DSC2943_by_kcpru.jpg@g' /etc/lightdm/lightdm-gtk-greeter.conf
    sed -i 's/gnome-terminal/kitty/g' /usr/share/glib-2.0/schemas/org.cinnamon.desktop.default-applications.gschema.xml
    sed -i 's/#icon-theme-name=/icon-theme-name=Papirus-Dark/g' /etc/lightdm/lightdm-gtk-greeter.conf
    sed -i 's/org.gnome.Terminal/kitty/g' /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/ 'panel1:left:1:show-desktop@cinnamon.org',//g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/ 'panel1:right:5:keyboard@cinnamon.org',//g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/ 'panel1:right:7:network@cinnamon.org',//g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:left:2:grouped-window-list/panel1:center:1:grouped-window-list/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:6/panel1:right:5/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:8/panel1:right:6/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:9/panel1:right:7/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i "s/panel1:right:10/panel1:right:8/g" /usr/share/glib-2.0/schemas/org.cinnamon.gschema.xml
    sed -i 's/tango/oblivion/g' /usr/share/glib-2.0/schemas/org.gnome.gedit.gschema.xml
    sed -i 's/#theme-name=/theme-name=Flat-Remix-GTK-Brown-Darkest/g' /etc/lightdm/lightdm-gtk-greeter.conf
fi