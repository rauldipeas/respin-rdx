#!/bin/bash
set -e

### RetroArch
if  grep ii <(dpkg --list retroarch 2>/dev/null) && grep ii <(dpkg --list libaio1t64:amd64 2>/dev/null||dpkg --list libaio1 2>/dev/null);then
    echo retroarch instalado!
    else
    if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
        echo 'Você está numa instalação do Debian...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
            echo Bookworm
            sudo apt install -y libaio1 retroarch
            else
            echo 'Sua versão do Debian não é suportada no momento.'
        fi
    elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
        echo 'Você está numa instalação do Ubuntu...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
            echo Noble
            sudo apt install -y libaio1t64 retroarch
            sudo ln -fs /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1
            else
            echo 'Sua versão do Ubuntu não é suportada no momento.'
        fi
        else
        echo 'Sua distribuição não é suportada no momento.'
    fi
    if  grep ii <(dpkg --list 7zip 2>/dev/null);then
        echo 7zip instalado!
        else
        sudo apt install -y	7zip
    fi
    rm -f RetroArch_cores.7z>/dev/null
    wget -q --show-progress https://buildbot.libretro.com/stable/1.17.0/linux/x86_64/RetroArch_cores.7z
    #wget -q --show-progress https://buildbot.libretro.com/nightly/linux/x86_64/RetroArch_cores.7z
    7z x RetroArch_cores.7z
    mkdir -p "$HOME"/.config/retroarch/cores/
    find RetroArch-Linux-x86_64/ -name '*_libretro.so' -exec cp {} "$HOME"/.config/retroarch/cores/ \;
    rm -r RetroArch_cores.7z RetroArch-Linux-x86_64
fi