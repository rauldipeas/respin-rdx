#!/bin/bash
set -e

## Papirus
if  grep ii <(dpkg --list papirus-icon-theme 2>/dev/null);then
    echo papirus-icont-theme instalado!
    else
    sudo apt install -y papirus-icon-theme
    if [ -f /usr/share/applications/tuxguitar.desktop ];then
        echo tuxguitar encontrado!
        if [ "$(cut -d= -f2 <(grep Icon <(cat /usr/share/applications/tuxguitar.desktop)))" = tuxguitar ];then
            echo 'Ícone do tuxguitar configuado corretamente!'
            else
            sudo sed -i 's@/usr/share/tuxguitar/skins/Oxygen/icon-96x96.png@tuxguitar@g' /usr/share/applications/tuxguitar.desktop
        fi
        else
        echo tuxguitar não encontrado!
    fi
    if [ "$XDG_CURRENT_DESKTOP" = ubuntu:GNOME ];then
        gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
        elif [ "$XDG_CURRENT_DESKTOP" = GNOME ];then
        gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
        else
        echo Ambiente gráfico não identificado.
    fi
fi