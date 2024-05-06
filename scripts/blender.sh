#!/bin/bash
set -e


if  grep ii <(dpkg --list blender);then
    echo blender instalado!
    echo desinstalando blender...
    sudo apt autoremove --purge -y blender*
    BLENDER_VER=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release|grep Blender3.|tail -n1|cut -d \" -f6)
    BLENDER_FILE=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER"|grep .tar.xz|tail -n1|cut -d \" -f6)
    rm -rf blender*/ blender*.tar.xz
    wget -c https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER""$BLENDER_FILE"
    sudo tar -xf blender*.tar.xz -C /opt/blender
    rm -r blender*/ blender*.tar.xz
    sudo ln -sf /opt/blender/blender /usr/bin/blender
    sudo cp /opt/blender/blender.desktop /usr/share/applications/blender.desktop
    sudo ln -sf /opt/blender/blender.svg /usr/share/pixmaps/blender.svg
    else
    BLENDER_VER=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release|grep Blender3.|tail -n1|cut -d \" -f6)
    BLENDER_FILE=$(wget -qO- https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER"|grep .tar.xz|tail -n1|cut -d \" -f6)
    rm -rf blender*/ blender*.tar.xz
    wget -c https://ftp.nluug.nl/pub/graphics/blender/release/"$BLENDER_VER""$BLENDER_FILE"
    sudo tar -xf blender*.tar.xz -C /opt/blender
    rm -r blender*/ blender*.tar.xz
    sudo ln -sf /opt/blender/blender /usr/bin/blender
    sudo cp /opt/blender/blender.desktop /usr/share/applications/blender.desktop
    sudo ln -sf /opt/blender/blender.svg /usr/share/pixmaps/blender.svg
fi

if  grep ii <(dpkg --list audacity);then
    echo audacity instalado!
    mkdir -p "$HOME"/.audacity-data/Theme
    wget -cO "$HOME"/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
    wget -q --show-progress https://github.com/tin2tin/audacity_tools_for_blender/archive/main.zip
    mkdir -p "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    unzip audacity_tools_for_blender-main.zip -d "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    rm audacity_tools_for_blender-main.zip
    else
    sudo apt install -y	audacity
    mkdir -p "$HOME"/.audacity-data/Theme
    wget -cO "$HOME"/.audacity-data/Theme/ImageCache.png https://github.com/visoart/audacity-themes/raw/master/themes/dark-blue/ImageCache.png
    wget -q --show-progress https://github.com/tin2tin/audacity_tools_for_blender/archive/main.zip
    mkdir -p "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    unzip audacity_tools_for_blender-main.zip -d "$HOME"/.config/blender/"$(find /opt/blender/* -type d|head -n1|sed "s@/opt/blender/@@g")"/scripts/addons/
    rm audacity_tools_for_blender-main.zip
fi