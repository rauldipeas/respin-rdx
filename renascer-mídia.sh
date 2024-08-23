#!/bin/bash
set -e

# Holyrics
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/holyrics.sh)

# FreeTube
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/postinst/freetube.sh)

# GNOME tweaks
if [[ "$XDG_CURRENT_DESKTOP" =~ ^(ubuntu:GNOME|GNOME)$ ]];then
    echo Você está executando o GNOME...
    if  grep ii <(dpkg --list gnome-shell-extension-manager 2>/dev/null);then
        echo gnome-shell-extension-manager instalado!
        else
        sudo apt install -y gnome-shell-extension-manager gnome-shell-extension-dash-to-panel
    fi
    if  grep ii <(dpkg --list pipx 2>/dev/null);then
        echo pipx instalado!
        else
        sudo apt install -y pipx
        pipx ensurepath
        source "$HOME"/.bashrc
    fi
    if  grep gnome-extensions-cli <(pipx list --short 2>/dev/null);then
        echo gnome-extensions-cli instalado!
        else
        pipx install gnome-extensions-cli
    fi
    #if grep blur-my-shell@aunetx <(gext list);then
    #    echo blur-my-shell@aunetx instalado!
    #    else
    #    gext install blur-my-shell@aunetx
    #    gext enable blur-my-shell@aunetx
    #fi
    if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
        echo 'Você está numa instalação do Debian...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
            echo Bookworm
            gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
            if grep dash-to-dock@micxgx.gmail.com <(gext list);then
                echo dash-to-dock@micxgx.gmail.com instalado!
                else
                gext install dash-to-dock@micxgx.gmail.com
                gext enable dash-to-dock@micxgx.gmail.com
            fi
            if grep dash-to-panel@jderose9.github.com <(gext list);then
                echo dash-to-panel@jderose9.github.com instalado!
                gext enable dash-to-panel@jderose9.github.com
            fi            
            else
            echo 'Sua versão do Debian não é suportada no momento.'
        fi
    elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
        echo 'Você está numa instalação do Ubuntu...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
            echo Noble
            gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
            if grep dash-to-panel@jderose9.github.com <(gext list);then
                echo dash-to-panel@jderose9.github.com instalado!
                gext enable dash-to-panel@jderose9.github.com
            fi            
            else
            echo 'Sua versão do Ubuntu não é suportada no momento.'
        fi
        else
        echo 'Sua distribuição não é suportada no momento.'
    fi
    else
    echo Você não está executando o GNOME.
fi