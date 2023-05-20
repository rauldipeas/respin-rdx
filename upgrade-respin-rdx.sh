#!/bin/bash
set -e
# deb-get
#if [ -f /usr/bin/deb-get ];then
#        deb-get update
#        deb-get upgrade
#        else
#        echo 'deb-get não encontrado'
#fi
# nala
if [ -f /usr/bin/nala ];then
        sudo nala upgrade
        else
        echo 'nala não encontrado'
fi
# pacstall
if [ -f /usr/bin/pacstall ];then
        pacstall -Up
        else
        echo 'pacstall não encontrado'
fi
# flatpak
if [ -f /usr/bin/flatpak ];then
        flatpak update
        else
        echo 'flatpak não encontrado'
fi
# mainline
if [ -f /usr/bin/mainline ];then
        #rm -rf "$HOME"/.cache/mainline
        sudo rm -rf /root/.cache/mainline
        sudo mainline --install-latest
        else
        echo 'mainline não encontrado'
fi
# pkcon
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