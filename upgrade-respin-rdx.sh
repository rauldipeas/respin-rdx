#!/bin/bash
set -e
if [ -f /usr/bin/deb-get ];then
        deb-get update
        deb-get upgrade
        else
        echo 'deb-get não encontrado'
fi
if [ -f /usr/bin/pacstall ];then
        pacstall -U
        pacstall -Up
        else
        echo 'pacstall não encontrado'
fi
if [ -f /usr/bin/mainline ];then
        mainline --install-latest
        else
        echo 'mainline não encontrado'
fi
if [ -f /usr/bin/pkcon ];then
        sudo pkcon update -y
        else
        echo 'pkcon não encontrado'
fi