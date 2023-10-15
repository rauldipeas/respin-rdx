#!/bin/bash
set -e
# GNOME Lite Rolling
if [ -f /UGLR ]; then
    echo 'GNOME Lite Rolling'
    bash -x enhancements/custom-spin/gnome-lite-rolling.sh
    wget -q --show-progress -O /usr/share/hardcode-tray/database/deltachat.json https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/hardcode-tray/deltachat.json
    wget -q --show-progress -O /usr/share/hardcode-tray/database/deltachat.electron.json https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/hardcode-tray/deltachat.electron.json
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
    sudo papirus-folders -C adwaita
    cat <<EOF |tee /etc/profile.d/gtk-theme.sh
export GTK_THEME="\$(gsettings get org.gnome.desktop.interface gtk-theme|cut -d "'" -f2)"
EOF
    cat <<EOF |tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    cp /usr/share/applications/info.desktop /usr/local/share/applications/
    echo 'Hidden=true'|tee -a /usr/local/share/applications/info.desktop>/dev/null
    wget -q --show-progress "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/lassekongo83/adw-gtk3/releases|grep browser_download_url|grep tar.xz|head -n1|cut -d '"' -f4)"
    tar fx adw-gtk3*.tar.xz -C /usr/share/themes/
    mkdir -p /etc/skel/.config/smplayer
    wget -q --show-progress -O /etc/skel/.config/smplayer/smplayer.ini https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/smplayer/smplayer.ini
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/cursor-theme/{n;s/Adwaita/DMZ-White/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i "/enabled-extensions/{n;s/\[\]/\['ubuntu-appindicators@ubuntu.com'\]/;}" /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.xml
    sed -i '/gtk-theme/{n;s/Adwaita/adw-gtk3-dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/icon-theme/{n;s/Adwaita/Papirus-Dark/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/picture-uri/{n;s/adwaita-l.webp/blobs-l.svg/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/picture-uri-dark/{n;s/adwaita-d.webp/blobs-d.svg/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.desktop.peripherals.gschema.xml
    sed -i '/tap-to-click/{n;s/false/true/;}' /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.peripherals.gschema.xml
    sed -i 's/firefox-esr/firefox/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/gnome-terminal/kitty/g' /usr/share/glib-2.0/schemas/org.gnome.desktop.default-applications.gschema.xml
    sed -i 's/org.gnome.Evolution/thunderbird/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/org.gnome.Software/synaptic/g' /usr/share/glib-2.0/schemas/10_gnome-shell.gschema.override
    sed -i 's/x-terminal-emulator/kitty/g' /usr/share/glib-2.0/schemas/10_gsettings-desktop-schemas.gschema.override
fi