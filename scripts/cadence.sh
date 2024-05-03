#!/bin/bash
set -e

## Cadence
if  grep ii <(dpkg --list kxstudio-repos);then
    echo kxstudio-repos instalado!
    else
    rm -f kxstudio-repos*.deb>/dev/null
    wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
    sudo apt install -y ./kxstudio-repos*.deb
    rm kxstudio-repos*.deb
fi
if grep multiverse /etc/apt/sources.list.d/ubuntu.sources;then
    echo multiverse configurado!
    else
    sudo add-apt-repository -y multiverse
fi
if grep universe /etc/apt/sources.list.d/ubuntu.sources;then
    echo universe configurado!
    else
    sudo add-apt-repository -y universe
fi
sudo apt update 2>/dev/null
if [ $(cut -d' ' -f4 <(grep "Nome do servidor" <(pactl info))) = pipewire ];then
    if  grep ii <(dpkg --list pulseaudio);then
        echo pulseaudio instalado!
        else
        sudo apt install -y pulseaudio
        systemctl --user mask pipewire.service pipewire.socket
        systemctl --user stop pipewire.service pipewire.socket
        systemctl --user disable pipewire.service pipewire.socket
        sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/pulseaudio.desktop
        sudo sed -i 's/Systemd=true/Systemd=false/g' /etc/xdg/autostart/pulseaudio.desktop
        sudo sed -i 's/start-pulseaudio-x11/systemctl --user start pulseaudio.service/g' /etc/xdg/autostart/pulseaudio.desktop
        systemctl --user start pulseaudio.service pulseaudio.socket
        grep "Nome do servidor" <(pactl info)
    fi
    else
    grep "Nome do servidor" <(pactl info)
fi
if  grep ii <(dpkg --list alsa-firmware) && grep ii <(dpkg --list cadence) && grep ii <(dpkg --list pulseaudio) && grep ii <(dpkg --list pulseaudio-module-jack);then
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