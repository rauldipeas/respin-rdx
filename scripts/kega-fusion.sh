#!/bin/bash
set -e

## Kega Fusion
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        echo 'O kega-fusion não está disponível no Debian Bookworm.'
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        if  grep ii <(dpkg --list kega-fusion 2>/dev/null);then
            echo kega-fusion instalado!
            else
            rm -f Kega-fusion*.deb>/dev/null
            wget -q --show-progress https://retrocdn.net/images/c/ca/Kega-fusion_3.63-2_i386.deb
            sudo apt install -y ./Kega-fusion*.deb
            rm Kega-fusion*.deb
            sudo sed -i 's/kega-fusion.png/kega-fusion/g' /usr/share/applications/kega-fusion.desktop
            echo 'StartupWMClass=Fusion'|sudo tee -a /usr/share/applications/kega-fusion.desktop>/dev/null
        fi
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi