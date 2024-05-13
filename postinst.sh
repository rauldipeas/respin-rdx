#!/bin/bash
set -e

# postinst (media-center)
## Stremio
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/stremio.sh)
## Steam
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/steam.sh)
## Hydra Launcher
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hydra-launcher.sh)
## EmuDeck
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/emudeck.sh)
## Papirus
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/papirus-icon-theme.sh)
## Dropbear
if  grep ii <(dpkg --list dropbear 2>/dev/null);then
    echo dropbear instalado!
    else
    sudo apt install -y dropbear
fi
## Flatpak
if  grep ii <(dpkg --list flatpak 2>/dev/null);then
    echo flatpak instalado!
    else
    sudo apt install -y flatpak
    flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    find "$HOME"/.var/app -mindepth 1 -maxdepth 1 -printf '%f\n'|xargs flatpak --user install -y
fi
## GNOME tweaks
#if  grep ii <(dpkg --list gnome-tweaks 2>/dev/null);then
#    echo gnome-tweaks instalado!
#    else
#    sudo apt install -y gnome-tweaks
#fi
## GNOME shell extension manager
if  grep ii <(dpkg --list gnome-shell-extension-manager 2>/dev/null);then
    echo gnome-shell-extension-manager instalado!
    else
    sudo apt install -y gnome-shell-extension-manager
fi
## MESA utils
if  grep ii <(dpkg --list mesa-utils 2>/dev/null);then
    echo mesa-utils instalado!
    else
    sudo apt install -y mesa-utils
fi
## OpenSSH SFTP server
if  grep ii <(dpkg --list openssh-sftp-server 2>/dev/null);then
    echo openssh-sftp-server instalado!
    else
    sudo apt install -y openssh-sftp-server
fi
## Oxygen cursor
#if  grep ii <(dpkg --list oxygen-cursor-theme 2>/dev/null);then
#    echo oxygen-cursor-theme instalado!
#    else
#    sudo apt install -y oxygen-cursor-theme
#    sudo update-alternatives --set x-cursor-theme /etc/X11/cursors/oxy-white.theme
#fi
## XScreenSaver
if  grep ii <(dpkg --list xscreensaver 2>/dev/null) && grep ii <(dpkg --list xscreensaver-gl-extra 2>/dev/null) && grep ii <(dpkg --list xscreensaver-data-extra 2>/dev/null);then
    echo xscreensaver instalado!
    else
    sudo apt install -y xscreensaver xscreensaver-data-extra xscreensaver-gl-extra
    cat <<EOF |sudo tee /etc/xdg/autostart/xscreensaver.desktop>/dev/null
[Desktop Entry]
Exec=xscreensaver -nosplash
Icon=xscreensaver
Name=XScreenSaver
Type=Application
Terminal=false
X-Ubuntu-Gettext-Domain=xscreensaver
EOF
fi