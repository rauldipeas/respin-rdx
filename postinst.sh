#!/bin/bash
set -e

# postinst (media-center)
## Atualização do sistema
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/system-update.sh)
## CFS Zen tweaks
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/cfs-zen-tweaks.sh)
## ZSwap
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/zswap.sh)
## nohang
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/nohang.sh)
## apt-rollback
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/apt-rollback.sh)
## nala
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/nala.sh)
## Pacstall
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/pacstall.sh)
## pipx
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/pipx.sh)
## Synaptic
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/synaptic.sh)
## Bat
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/bat.sh)
## Micro
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/micro.sh)
## Topgrade
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/topgrade.sh)
## Papirus
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/papirus-icon-theme.sh)
## Warp
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/warp-terminal.sh)
## RustDesk
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rustdesk.sh)
## Stremio
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/stremio.sh)
## VLC
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/vlc.sh)
## Retrogaming
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/retrogaming.sh|sed 's/libfuse2t64/libfuse2/g')
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/retrogaming.sh)
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi
## Steam
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/steam.sh)
## Heroic
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/heroic.sh|sed 's/libfuse2t64/libfuse2/g')
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/heroic.sh)
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi
## Minigalaxy
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/minigalaxy.sh)
## MangoHUD
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/mangohud.sh)
## Superpaper
bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/superpaper.sh)
## Dropbear
if  grep ii <(dpkg --list dropbear 2>/dev/null);then
    echo dropbear instalado!
    else
    sudo apt install -y dropbear
fi
## GNOME tweaks
if [[ "$XDG_CURRENT_DESKTOP" =~ ^(ubuntu:GNOME|GNOME)$ ]];then
    echo Você está executando o GNOME...
    if  grep ii <(dpkg --list gnome-shell-extension-manager 2>/dev/null);then
        echo gnome-shell-extension-manager instalado!
        else
        sudo apt install -y gnome-shell-extension-manager
    fi
    if  grep ii <(dpkg --list pipx 2>/dev/null);then
        echo pipx instalado!
        else
        sudo apt install -y pipx
        pipx ensurepath
        source "$HOME"/.bashrc
    fi
    if  grep gnome-extensions-cli <(pipx list --short 2>/dev/null);then
        echo gnome-extensions-cli instalado!
        else
        pipx install gnome-extensions-cli
    fi
    if grep blur-my-shell@aunetx <(gext list);then
        echo blur-my-shell@aunetx instalado!
        else
        gext install blur-my-shell@aunetx
        gext enable blur-my-shell@aunetx
    fi
    if grep burn-my-windows@schneegans.github.com <(gext list);then
        echo burn-my-windows@schneegans.github.com instalado!
        else
        gext install burn-my-windows@schneegans.github.com
        gext enable burn-my-windows@schneegans.github.com
    fi
    if grep compiz-alike-magic-lamp-effect@hermes83.github.com <(gext list);then
        echo compiz-alike-magic-lamp-effect@hermes83.github.com instalado!
        else
        gext install compiz-alike-magic-lamp-effect@hermes83.github.com
        gext enable compiz-alike-magic-lamp-effect@hermes83.github.com
    fi
    if grep compiz-windows-effect@hermes83.github.com <(gext list);then
        echo compiz-windows-effect@hermes83.github.com instalado!
        else
        gext install compiz-windows-effect@hermes83.github.com
        gext enable compiz-windows-effect@hermes83.github.com
    fi
    if grep desktop-cube@schneegans.github.com <(gext list);then
        echo desktop-cube@schneegans.github.com instalado!
        else
        gext install desktop-cube@schneegans.github.com
        gext enable desktop-cube@schneegans.github.com
    fi
    if grep monitor@astraext.github.io <(gext list);then
        echo monitor@astraext.github.io instalado!
        else
        gext install monitor@astraext.github.io
        gext enable monitor@astraext.github.io
    fi
    if grep quick-settings-tweaks@qwreey <(gext list);then
        echo quick-settings-tweaks@qwreey instalado!
        else
        gext install quick-settings-tweaks@qwreey
        gext enable quick-settings-tweaks@qwreey
    fi
    if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
        echo 'Você está numa instalação do Debian...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
            echo Bookworm
            if grep dash-to-dock@micxgx.gmail.com <(gext list);then
                echo dash-to-dock@micxgx.gmail.com instalado!
                else
                gext install dash-to-dock@micxgx.gmail.com
                gext enable dash-to-dock@micxgx.gmail.com
            fi    
            gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
            else
            echo 'Sua versão do Debian não é suportada no momento.'
        fi
    elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
        echo 'Você está numa instalação do Ubuntu...'
        if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
            echo Noble
            gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
            else
            echo 'Sua versão do Ubuntu não é suportada no momento.'
        fi
        else
        echo 'Sua distribuição não é suportada no momento.'
    fi
    ### File roller
    if  grep ii <(dpkg --list file-roller 2>/dev/null);then
        echo file-roller instalado!
        else
        sudo apt install -y file-roller
    fi
    ### MESA utils
    if  grep ii <(dpkg --list mesa-utils 2>/dev/null);then
        echo mesa-utils instalado!
        else
        sudo apt install -y mesa-utils
    fi
    ### Transmission
    if  grep ii <(dpkg --list transmission-gtk 2>/dev/null);then
        echo transmission-gtk instalado!
        else
        sudo apt install -y transmission-gtk
    fi
    else
    echo Você não está executando o GNOME.
fi
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
            sudo add-apt-repository -ny non-free
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
                sudo apt install -y	nvtop
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
            sudo add-apt-repository -ny universe
        fi
        if [ "$(cut -d' ' -f9 <(grep NVIDIA <(sudo lshw -C display)))" == NVIDIA ];then
            if  grep ii <(dpkg --list nvtop 2>/dev/null);then
                echo nvtop instalado!
                else
                sudo apt install -y	nvtop
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
## OpenSSH SFTP server
if  grep ii <(dpkg --list openssh-sftp-server 2>/dev/null);then
    echo openssh-sftp-server instalado!
    else
    sudo apt install -y openssh-sftp-server
fi
## Speedtest
if  grep ii <(dpkg --list speedtest-cli 2>/dev/null);then
    echo speedtest-cli instalado!
    else
    sudo apt install -y speedtest-cli
fi
## XScreenSaver
if  grep ii <(dpkg --list xscreensaver 2>/dev/null) && grep ii <(dpkg --list xscreensaver-gl-extra 2>/dev/null) && grep ii <(dpkg --list xscreensaver-data-extra 2>/dev/null);then
    echo xscreensaver instalado!
    else
    sudo apt install -y xscreensaver xscreensaver-data-extra xscreensaver-gl-extra
    cat <<EOF |sudo tee /etc/xdg/autostart/xscreensaver.desktop>/dev/null
[Desktop Entry]
Exec=xscreensaver -nosplash
Icon=xscreensaver
Name=XScreenSaver
Type=Application
Terminal=false
X-Ubuntu-Gettext-Domain=xscreensaver
EOF
fi
## Ora
if  grep ii <(dpkg --list snapd 2>/dev/null);then
    echo snapd instalado!
    if grep ora <(snap list);then
        echo ora instalado!
        else
        sudo snap install ora
    fi
    else
    sudo apt install -y snapd
    sudo snap install ora
fi

# Debian cleanup
#sudo apt autoremove --purge -y\
#    anthy*\
#    gnome-games\
#    goldendict*\
#    mlterm*\
#    *mozc*\
#    xiterm*