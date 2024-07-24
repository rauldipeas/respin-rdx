#!/bin/bash
set -e

## Heroic
#if  grep ii <(dpkg --list heroic 2>/dev/null);then
#    echo heroic instalado!
#    else
#    rm -rf heroic*.deb>/dev/null
#    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
#    sudo apt install -y ./heroic*.deb
#    rm heroic*.deb
#fi
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        if  grep ii <(dpkg --list libfuse2 2>/dev/null);then
            echo libfuse2 instalado!
            else
            sudo apt install -y	libfuse2
        fi
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
            if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
                echo libfuse2t64 instalado!
                else
                sudo apt install -y	libfuse2t64
            fi
        fi
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi
if [ -f "$HOME"/Applications/heroic.AppImage ] && [ -f "$HOME"/.local/share/applications/heroic.desktop ];then
    echo heroic instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/heroic.AppImage "$(wget -qO- https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases|grep browser_download_url|grep .AppImage|head -n1|cut -d '"' -f4)"
    chmod +x "$HOME"/Applications/heroic.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/heroic.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/heroic.AppImage --no-sandbox
Icon=heroic
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;
Name=Heroic Games Launcher
Keywords=game;epic;
EOF
fi