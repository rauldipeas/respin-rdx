#!/bin/bash
set -e

## Cadence
if  grep ii <(dpkg --list kxstudio-repos 2>/dev/null);then
    echo kxstudio-repos instalado!
    else
    rm -f kxstudio-repos*.deb>/dev/null
    wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
    sudo apt install -y ./kxstudio-repos*.deb
    rm kxstudio-repos*.deb
fi

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
            sudo add-apt-repository -ny non-free
        fi
        sudo apt update 2>/dev/null
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
            sudo add-apt-repository -ny universe
        fi
        sudo apt update 2>/dev/null
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi
if [ $(cut -d' ' -f14 <(grep pipewire-pulse <(ps -e))) = pipewire-pulse 2>/dev/null ];then
    if  grep ii <(dpkg --list pulseaudio 2>/dev/null);then
        echo pulseaudio instalado!
        systemctl --user mask pipewire.service pipewire.socket
        systemctl --user stop pipewire.service pipewire.socket
        systemctl --user disable pipewire.service pipewire.socket
        sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/pulseaudio.desktop
        sudo sed -i 's/Systemd=true/Systemd=false/g' /etc/xdg/autostart/pulseaudio.desktop
        sudo sed -i 's/start-pulseaudio-x11/systemctl --user start pulseaudio.service/g' /etc/xdg/autostart/pulseaudio.desktop
        systemctl --user start pulseaudio.service pulseaudio.socket
        grep 'Nome do servidor' <(pactl info)
        else
        sudo apt install -y pulseaudio
        systemctl --user mask pipewire.service pipewire.socket
        systemctl --user stop pipewire.service pipewire.socket
        systemctl --user disable pipewire.service pipewire.socket
        sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/pulseaudio.desktop
        sudo sed -i 's/Systemd=true/Systemd=false/g' /etc/xdg/autostart/pulseaudio.desktop
        sudo sed -i 's/start-pulseaudio-x11/systemctl --user start pulseaudio.service/g' /etc/xdg/autostart/pulseaudio.desktop
        systemctl --user start pulseaudio.service pulseaudio.socket
        grep 'Nome do servidor' <(pactl info)
    fi
    else
    grep 'Nome do servidor' <(pactl info)
fi
if grep ii <(dpkg --list alsa-firmware 2>/dev/null) && grep ii <(dpkg --list cadence 2>/dev/null) && grep ii <(dpkg --list pulseaudio 2>/dev/null) && grep ii <(dpkg --list pulseaudio-module-jack 2>/dev/null);then
    echo cadence instalado!
    else
    cat <<EOF |sudo tee /etc/apt/preferences.d/meterbridge.pref>/dev/null
Package: meterbridge
Pin: release a=*
Pin-Priority: -10
EOF
    sudo apt install -y alsa-firmware cadence
    sudo rm /etc/apt/preferences.d/meterbridge.pref
fi