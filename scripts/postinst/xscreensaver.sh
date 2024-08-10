#!/bin/bash
set -e

## XScreenSaver
if  grep ii <(dpkg --list xscreensaver 2>/dev/null) && grep ii <(dpkg --list xscreensaver-gl-extra 2>/dev/null) && grep ii <(dpkg --list xscreensaver-data-extra 2>/dev/null);then
    echo xscreensaver instalado!
    else
    sudo apt install -y xscreensaver xscreensaver-data-extra xscreensaver-gl-extra
    cat <<EOF |sudo tee /etc/xdg/autostart/xscreensaver.desktop>/dev/null
[Desktop Entry]
Exec=xscreensaver --no-splash
Icon=xscreensaver
Name=XScreenSaver
Type=Application
Terminal=false
X-Ubuntu-Gettext-Domain=xscreensaver
EOF
fi