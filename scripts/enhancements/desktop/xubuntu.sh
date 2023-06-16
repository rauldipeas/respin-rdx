#!/bin/bash
set -e
# Xubuntu
if [ -f /Xubuntu ]; then
    echo 'Xubuntu'
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
    papirus-folders -C paleorange
    cat <<EOF |tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    cat <<EOF |tee /etc/profile.d/qt-qpa-platformtheme.sh
export QT_QPA_PLATFORMTHEME=gtk2
EOF
    rm -r /etc/skel/.config/libreoffice
    mkdir -p /etc/skel/.config/{autostart,volumeicon,xfce4/panel}
    wget -q --show-progress -O /etc/xdg/autostart/volumeicon.desktop https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon.desktop
    wget -q --show-progress -O /etc/skel/.config/volumeicon/volumeicon https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon
    wget -q --show-progress -O /etc/skel/.config/xfce4/panel/docklike-2.rc https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/docklike-2.rc
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-superbar.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-superbar.tar.bz2
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-unity.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-unity.tar.bz2
    wget -q --show-progress -O /usr/share/xfce4/helpers/kitty.desktop https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/kitty.desktop
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i 's/elementary-xfce-darker/Papirus-Dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/org.gnome.Software/synaptic/g' /etc/skel/.config/xfce4/panel/whiskermenu-1.rc /etc/xdg/xdg-xubuntu/xfce4/whiskermenu/defaults.rc
    sed -i 's/xfce4-terminal/kitty/g' /etc/xdg/xdg-xubuntu/xfce4/helpers.rc
    sed -i 's/xubuntu-wallpaper.png/Kanchanjunga_Peaks_by_Pushkar_Deshpande.jpg/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
fi