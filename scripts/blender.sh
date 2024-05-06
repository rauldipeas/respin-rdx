#!/bin/bash
set -e


if  grep ii <(dpkg --list blender 2>/dev/null) || grep blender <(snap list);then
    echo blender instalado!
    echo desinstalando blender...
    sudo apt autoremove --purge -y blender*
    sudo snap remove blender
    BLENDER_VER=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release|grep Blender4.|tail -n1|cut -d \" -f6)
    BLENDER_FILE=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER"|grep .tar.xz|tail -n1|cut -d \" -f6)
    wget -cq --show-progress -O /tmp/"$BLENDER_FILE" https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER""$BLENDER_FILE"
    sudo rm -rf /opt/blender*>/dev/null
    sudo tar -xf /tmp/"$BLENDER_FILE" -C /opt/
    sudo mv /opt/blender* /opt/blender
    sudo ln -sf /opt/blender/blender /usr/bin/blender
    sudo cp /opt/blender/blender.desktop /usr/share/applications/blender.desktop
    sudo ln -sf /opt/blender/blender.svg /usr/share/pixmaps/blender.svg
    else
    BLENDER_VER=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release|grep Blender4.|tail -n1|cut -d \" -f6)
    BLENDER_FILE=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER"|grep .tar.xz|tail -n1|cut -d \" -f6)
    wget -cq --show-progress -O /tmp/"$BLENDER_FILE" https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER""$BLENDER_FILE"
    sudo rm -rf /opt/blender*>/dev/null
    sudo tar -xf /tmp/"$BLENDER_FILE" -C /opt/
    sudo mv /opt/blender* /opt/blender
    sudo ln -sf /opt/blender/blender /usr/bin/blender
    sudo cp /opt/blender/blender.desktop /usr/share/applications/blender.desktop
    sudo ln -sf /opt/blender/blender.svg /usr/share/pixmaps/blender.svg
fi

if  grep ii <(dpkg --list audacity 2>/dev/null);then
    echo audacity instalado!
    mkdir -p "$HOME"/.audacity-data/Theme
    wget -qO "$HOME"/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
    rm -f main.zip>/dev/null
    wget -q --show-progress https://github.com/tin2tin/audacity_tools_for_blender/archive/main.zip
    mkdir -p "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    unzip main.zip -d "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    rm main.zip
    else
    sudo apt install -y	audacity
    mkdir -p "$HOME"/.audacity-data/Theme
    wget -qO "$HOME"/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
    rm -f main.zip>/dev/null
    wget -q --show-progress https://github.com/tin2tin/audacity_tools_for_blender/archive/main.zip
    mkdir -p "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    unzip main.zip -d "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    rm main.zip
fi