#!/bin/bash
set -e
#if [ -f /usr/bin/deb-get ];then
#        deb-get update
#        deb-get upgrade
#        else
#        echo 'deb-get não encontrado'
#fi
if [ -f /usr/bin/nala ];then
        sudo nala upgrade
        else
        echo 'nala não encontrado'
fi
if [ -f /usr/bin/pacstall ];then
        pacstall -Up
        else
        echo 'pacstall não encontrado'
fi
if [ -f /usr/bin/mainline ];then
        #rm -rf "$HOME"/.cache/mainline
        sudo rm -rf /root/.cache/mainline
        sudo mainline --install-latest
        else
        echo 'mainline não encontrado'
fi
if [ -f /usr/bin/pkcon ];then
        if [ -f /usr/bin/aptitude ];then
                if [ "$(aptitude search '~U')" ];then
                        sudo pkcon update -y
                        else
                        echo 'Atualização concluída com sucesso!'
                fi
                else
                echo 'aptitude não encontrado'
        fi
        else
        echo 'pkcon não encontrado'
fi