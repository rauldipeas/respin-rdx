#!/bin/bash
set -e

## GNOME tweaks
if [[ "$XDG_CURRENT_DESKTOP" =~ ^(ubuntu:GNOME|GNOME)$ ]];then
    echo Você está executando o GNOME...
    if  grep ii <(dpkg --list gnome-shell-extension-manager 2>/dev/null);then
        echo gnome-shell-extension-manager instalado!
        else
        sudo apt install -y gnome-shell-extension-manager
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
    if grep blur-my-shell@aunetx <(gext list);then
        echo blur-my-shell@aunetx instalado!
        else
        gext install blur-my-shell@aunetx
        gext enable blur-my-shell@aunetx
    fi
    if grep burn-my-windows@schneegans.github.com <(gext list);then
        echo burn-my-windows@schneegans.github.com instalado!
        else
        gext install burn-my-windows@schneegans.github.com
        gext enable burn-my-windows@schneegans.github.com
    fi
    if grep compiz-alike-magic-lamp-effect@hermes83.github.com <(gext list);then
        echo compiz-alike-magic-lamp-effect@hermes83.github.com instalado!
        else
        gext install compiz-alike-magic-lamp-effect@hermes83.github.com
        gext enable compiz-alike-magic-lamp-effect@hermes83.github.com
    fi
    if grep compiz-windows-effect@hermes83.github.com <(gext list);then
        echo compiz-windows-effect@hermes83.github.com instalado!
        else
        gext install compiz-windows-effect@hermes83.github.com
        gext enable compiz-windows-effect@hermes83.github.com
    fi
    if grep desktop-cube@schneegans.github.com <(gext list);then
        echo desktop-cube@schneegans.github.com instalado!
        else
        gext install desktop-cube@schneegans.github.com
        gext enable desktop-cube@schneegans.github.com
    fi
    if grep monitor@astraext.github.io <(gext list);then
        echo monitor@astraext.github.io instalado!
        else
        gext install monitor@astraext.github.io
        gext enable monitor@astraext.github.io
    fi
    if grep pano@elhan.io <(gext list);then
        echo pano@elhan.io instalado!
        else
        gext install pano@elhan.io
        gext enable pano@elhan.io
    fi
    if grep quick-settings-tweaks@qwreey <(gext list);then
        echo quick-settings-tweaks@qwreey instalado!
        else
        gext install quick-settings-tweaks@qwreey
        gext enable quick-settings-tweaks@qwreey
    fi
    if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
        echo 'Você está numa instalação do Debian...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
            echo Bookworm
            if grep dash-to-dock@micxgx.gmail.com <(gext list);then
                echo dash-to-dock@micxgx.gmail.com instalado!
                else
                gext install dash-to-dock@micxgx.gmail.com
                gext enable dash-to-dock@micxgx.gmail.com
            fi
            if grep appindicatorsupport@rgcjonas.gmail.com <(gext list);then
                echo appindicatorsupport@rgcjonas.gmail.com instalado!
                else
                gext install appindicatorsupport@rgcjonas.gmail.com
                gext enable appindicatorsupport@rgcjonas.gmail.com
            fi
            else
            echo 'Sua versão do Debian não é suportada no momento.'
        fi
    elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
        echo 'Você está numa instalação do Ubuntu...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
            echo Noble
            gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
            else
            echo 'Sua versão do Ubuntu não é suportada no momento.'
        fi
        else
        echo 'Sua distribuição não é suportada no momento.'
    fi
    ### File roller
    if  grep ii <(dpkg --list file-roller 2>/dev/null);then
        echo file-roller instalado!
        else
        sudo apt install -y file-roller
    fi
    ### MESA utils
    if  grep ii <(dpkg --list mesa-utils 2>/dev/null);then
        echo mesa-utils instalado!
        else
        sudo apt install -y mesa-utils
    fi
    ### Transmission
    if  grep ii <(dpkg --list transmission-gtk 2>/dev/null);then
        echo transmission-gtk instalado!
        else
        sudo apt install -y transmission-gtk
    fi
    else
    echo Você não está executando o GNOME.
fi