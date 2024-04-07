#!/bin/bash
set -e
# Xubuntu Lite Rolling
if [ -f /XLR ]; then
    echo 'Xubuntu Lite Rolling'
    bash -x enhancements/custom-spin/xubuntu-lite-rolling.sh
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
    sudo papirus-folders -C paleorange
    cat <<EOF |tee /etc/profile.d/gtk-theme.sh
export GTK_THEME="\$(gsettings get org.gnome.desktop.interface gtk-theme|cut -d "'" -f2)"
EOF
    cat <<EOF |tee /etc/profile.d/mozilla-pixel-perfect-scrolling.sh
export MOZ_USE_XINPUT2=1
EOF
    cat <<EOF |tee /etc/profile.d/qt-qpa-platformtheme.sh
export QT_QPA_PLATFORMTHEME=gtk2
EOF
    #rm -r /etc/skel/.config/libreoffice
    mkdir -p /etc/skel/.config/{autostart,gtk-3.0,smplayer,volumeicon,xfce4/panel,xfce4/xfconf/xfce-perchannel-xml}
    wget -q --show-progress -O /etc/xdg/autostart/natural-scrolling.desktop https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/natural-scrolling.desktop
    wget -q --show-progress -O /etc/xdg/autostart/volumeicon.desktop https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon.desktop
    sed -i 's/Hidden=true//g' /etc/xdg/autostart/volumeicon.desktop
    wget -q --show-progress -O /etc/skel/.config/gtk-3.0/gtk.css https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/gtk.css
    wget -q --show-progress -O /etc/skel/.config/smplayer/smplayer.ini https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/smplayer/smplayer.ini
    wget -q --show-progress -O /etc/skel/.config/volumeicon/volumeicon https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/volumeicon
    wget -q --show-progress -O /etc/skel/.config/xfce4/panel/docklike-2.rc https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/docklike-2.rc
    wget -q --show-progress -O /etc/skel/.config/xfce4/panel/docklike-8.rc https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/docklike-8.rc
    wget -q --show-progress -O /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/xfce4-panel.xml
    wget -q --show-progress -O /etc/xdg/autostart/xcape.desktop https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/xcape.desktop
    wget -q --show-progress -O /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-appfinder.xml https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/XFCE/xfce4-appfinder.xml
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-rhino.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-rhino.tar.bz2
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-superbar.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-superbar.tar.bz2
    wget -q --show-progress -O /usr/share/xfce4-panel-profiles/layouts/rauldipeas-unity.tar.bz2 https://github.com/rauldipeas/respin-rdx/raw/main/assets/XFCE/rauldipeas-unity.tar.bz2
    sed -i "/color-scheme/{n;s/'default'/'prefer-dark'/;}" /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml
    sed -i '/tooltip-size/{n;s/  /\    <property name="gravity" type="int" value="2"\/\>\n \ /;}' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/\&lt;Alt\&gt;F3/\&lt;Super\&gt;x/g' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
    sed -i 's/Alt/Super/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/elementary-xfce-dark/Papirus-Dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/Greybird/Greybird-dark/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/home" type="bool" value="true/home" type="bool" value="false/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/name="show" type="bool" value="false/name="show" type="bool" value="true/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/Noto Sans/FreeSans/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
    sed -i 's/Noto Sans Bold/FreeSans Semi-Bold/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
    sed -i 's/org.gnome.Software/synaptic/g' /etc/skel/.config/xfce4/panel/whiskermenu-1.rc /etc/xdg/xdg-xubuntu/xfce4/whiskermenu/defaults.rc
    sed -i 's/trash" type="bool" value="true/trash" type="bool" value="false/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
    sed -i 's/xfce4-terminal/kitty/g' /etc/xdg/xdg-xubuntu/xfce4/helpers.rc
    sed -i 's/xubuntu-wallpaper.png/Kanchanjunga_Peaks_by_Pushkar_Deshpande.jpg/g' /etc/xdg/xdg-xubuntu/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
fi