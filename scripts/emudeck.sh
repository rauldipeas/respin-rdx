#!/bin/bash
set -e

## EmuDeck
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        if  grep ii <(dpkg --list libfuse2 2>/dev/null);then
            echo libfuse2 instalado!
            else
            sudo apt install -y	libfuse2
        fi
        mkdir -p "$HOME"/Applications
        wget -q --show-progress -O "$HOME"/Applications/EmuDeck.AppImage "$(wget -qO- https://api.github.com/repos/EmuDeck/emudeck-electron/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
        chmod +x "$HOME"/Applications/EmuDeck.AppImage
        "$HOME"/Applications/EmuDeck.AppImage --no-sandbox
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
            echo libfuse2t64 instalado!
            else
            sudo apt install -y	libfuse2t64
        fi
        mkdir -p "$HOME"/Applications
        wget -q --show-progress -O "$HOME"/Applications/EmuDeck.AppImage "$(wget -qO- https://api.github.com/repos/EmuDeck/emudeck-electron/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
        chmod +x "$HOME"/Applications/EmuDeck.AppImage
        "$HOME"/Applications/EmuDeck.AppImage --no-sandbox
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi
#bash <(wget -qO- --show-progress https://www.emudeck.com/EmuDeck.sh)