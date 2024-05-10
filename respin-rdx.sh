#!/bin/bash
set -e

if [ "$(whoami)" = root ];then
    echo Nunca execute este script como root.
    else
    # Atualização do sistema
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/system-update.sh)

    # Desempenho
    ## CFS Zen tweaks
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/cfs-zen-tweaks.sh)
    ## ZSwap
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/zswap.sh)
    ## nohang
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/nohang.sh)

    # Instaladores de programas
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

    # Drivers
    ## JACK
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/jack.sh)
    ## udev-rtirq
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/udev-rtirq.sh)

    # rtcqs
    bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rtcqs.sh)

    if [ "$1" = multimedia ];then
        # Multimídia
        if [ "$2" = audio ];then
            ## Audacity
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/audacity.sh)
            ## Cadence
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/cadence.sh)
            ## REAPER
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/reaper.sh)
            ## TuxGuitar
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/tuxguitar.sh)
            ## WINE TkG
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/wine-tkg.sh)
            ## yabridge
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/yabridge.sh)
        fi
        if [ "$2" = video ];then
            ## 4kVideoDownloader
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/4kvideodownloader.sh)
            ## Blender
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/blender.sh)
            ## Glaxnimate (snap)
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/glaxnimate.sh)
            ## KDEnLive
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/kdenlive.sh)
            ## Mini-video-me
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/mini-video-me.sh)
            ## OBS Studio
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/obs-studio.sh)
            ## VLC
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/vlc.sh)
        fi
        if [ "$2" = image ];then
            ## GIMP
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/gimp.sh)
            ## Inkscape
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/inkscape.sh)
            ## Krita
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/krita.sh)
            ## Shotwell
            bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/shotwell.sh)
        fi
        ## MediaInfo GUI
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/mediainfo-gui.sh)
        ## Stremio
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/stremio.sh)
        ## WinFF
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/winff.sh)
    elif [ "$1" = game ];then
        # Jogos
        ## Steam
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/steam.sh)
        ## EmuDeck
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/emudeck.sh)
        ## Hydra Launcher
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hydra-launcher.sh)
    fi

    # Miscelânea
    if [ "$1 = cli-tools" ];then
        ## Bat
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/bat.sh)
        ## Micro
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/micro.sh)
    fi
    if [ "$1 = papirus"];then
        ## Papirus
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/papirus-icon-theme.sh)
    fi
    if [ "$1 = rustdesk"];then
        ## RustDesk
        bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/rustdesk.sh)
    ## BZip2 (vbox-extras)
    #bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/bzip2.sh)
    ## UnRAR
    #bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/unrar.sh)
fi

#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh) # núcleo
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh multimedia) # multimídia
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh multimedia audio) # áudio
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh multimedia video) # vídeo
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh multimedia image) # imagem
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh game) # jogos
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh cli-tools) # ferramentas cli
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh papirus) # papirus
#bash <(wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/respin-rdx.sh rustdesk) # rustdesk