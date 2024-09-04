#!/bin/bash
set -e

# Debian cleanup
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        sudo apt autoremove --purge -y\
            anthy*\
            gnome-games\
            goldendict*\
            mlterm*\
            *mozc*\
            xiterm*
        #    cheese*\
        #    evolution\
        #    evolution-data-server\
        #    gnome-calendar\
        #    gnome-clocks\
        #    gnome-contacts\
        #    gnome-maps\
        #    gnome-music\
        #    gnome-shell-extension-prefs\
        #    gnome-sound-recorder\
        #    gnome-weather\
        #    hdate-applet\
        #    rhythmbox*\
        #    shotwell*\
        #    simple-scan
        #    thunderbird*\
        #    totem*\
        #    *yelp*
        grep ii <(dpkg --list firefox-esr-l10n-*)|cut -d' ' -f3|grep -v pt-br|xargs sudo apt autoremove --purge -y
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi