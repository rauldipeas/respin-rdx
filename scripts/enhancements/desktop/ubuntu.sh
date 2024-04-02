#!/bin/bash
set -e
# Ubuntu
if [ -f /Ubuntu ]; then
    echo 'Ubuntu'
    cat <<EOF |tee /etc/skel/.config/hardcode-tray.json
{
    "icons": {
        "theme": "Papirus-Dark",
        "size": 16
    },
    "backup_ignore": true
}
EOF
    hardcode-tray --apply --theme Papirus-Dark --size 16
    sudo papirus-folders -C yaru
    cat <<EOF |tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    cat <<EOF |tee /etc/profile.d/qt-qpa-platformtheme.sh
export QT_QPA_PLATFORMTHEME=gtk2
EOF
    sed -i 's/firefox_firefox/firefox/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/gnome-terminal/kitty/g' /usr/share/glib-2.0/schemas/org.gnome.desktop.default-applications.gschema.xml
    sed -i 's/gtk-theme = "Yaru"/gtk-theme = "Yaru-dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/icon-theme = "Yaru"/icon-theme = "Papirus-Dark"/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/snap-store_ubuntu-software/synaptic/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/warty-final-ubuntu.png/DSC2943_by_kcpru.jpg/g' /usr/share/glib-2.0/schemas/10_ubuntu-settings.gschema.override
    sed -i 's/x-terminal-emulator/kitty/g' /usr/share/glib-2.0/schemas/10_gsettings-desktop-schemas.gschema.override
fi