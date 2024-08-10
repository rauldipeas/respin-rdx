#!/bin/bash
set -e

## XScreenSaver
if  grep ii <(dpkg --list xscreensaver 2>/dev/null) && grep ii <(dpkg --list xscreensaver-gl-extra 2>/dev/null) && grep ii <(dpkg --list xscreensaver-data-extra 2>/dev/null);then
    echo xscreensaver instalado!
    else
    sudo apt install -y xscreensaver xscreensaver-data-extra xscreensaver-gl-extra
    systemctl --user enable xscreensaver.service
    systemctl --user start xscreensaver.service
fi