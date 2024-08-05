#!/bin/bash
set -e

## NVTop
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        if grep contrib /etc/apt/sources.list;then
            echo contrib configurado!
            else
            sudo add-apt-repository -ny contrib
        fi
        if grep non-free /etc/apt/sources.list;then
            echo non-free configurado!
            else
            sudo add-apt-repository -y non-free
        fi
        if  grep ii <(dpkg --list lshw 2>/dev/null);then
            echo lshw instalado!
            else
            sudo apt install -y lshw
        fi            
        if [ "$(cut -d' ' -f9 <(grep NVIDIA <(sudo lshw -C display)))" == NVIDIA ];then
            if  grep ii <(dpkg --list nvtop 2>/dev/null);then
                echo nvtop instalado!
                else
                sudo apt install -y nvtop
            fi
            else
            echo GPU NVIDIA não encontrada.
        fi
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        if grep multiverse /etc/apt/sources.list.d/ubuntu.sources;then
            echo multiverse configurado!
            else
            sudo add-apt-repository -ny multiverse
        fi
        if grep universe /etc/apt/sources.list.d/ubuntu.sources;then
            echo universe configurado!
            else
            sudo add-apt-repository -y universe
        fi
        if [ "$(cut -d' ' -f9 <(grep NVIDIA <(sudo lshw -C display)))" == NVIDIA ];then
            if  grep ii <(dpkg --list nvtop 2>/dev/null);then
                echo nvtop instalado!
                else
                sudo apt install -y nvtop
            fi
            else
            echo GPU NVIDIA não encontrada.
        fi
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi