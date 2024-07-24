#!/bin/bash
set -e

## Pacstall
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        echo 'O pacstall não está disponível no Debian Bookworm.'
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        if  grep ii <(dpkg --list pacstall 2>/dev/null);then
            echo pacstall instalado!
            else
            rm -rf pacstall*.deb>/dev/null
            wget -q --show-progress "$(wget -qO- https://api.github.com/repos/pacstall/pacstall/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
            sudo apt install -y ./pacstall*.deb
            rm pacstall*.deb
        fi
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi