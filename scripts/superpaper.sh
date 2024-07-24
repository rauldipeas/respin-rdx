#!/bin/bash
set -e

## Superpaper
if  grep ii <(dpkg --list pipx 2>/dev/null);then
    echo pipx instalado!
    else
    sudo apt install -y	pipx
    pipx ensurepath
    source "$HOME"/.bashrc
fi
if  grep superpaper <(pipx list --short 2>/dev/null);then
    echo superpaper instalado!
    else
    if  grep ii <(dpkg --list python3-wxgtk4.0 2>/dev/null);then
        echo python3-wxgtk4.0 instalado!
        else
        sudo apt install -y	python3-wxgtk4.0
    fi
    pipx install --system-site-packages superpaper
    sed -i 's@/usr/bin/python3 -m superpaper@superpaper@g' "$HOME"/.local/pipx/venvs/superpaper/share/applications/superpaper.desktop
    mkdir -p "$HOME"/.local/share/{applications,icons/hicolor/256x256/apps}
    ln -fs "$HOME"/.local/share/pipx/venvs/superpaper/share/icons/hicolor/256x256/apps/superpaper.png "$HOME"/.local/share/icons/hicolor/256x256/apps/superpaper.png
    ln -fs "$HOME"/.local/share/pipx/venvs/superpaper/share/applications/superpaper.desktop "$HOME"/.local/share/applications/superpaper.desktop
    ln -fs "$HOME"/.local/share/pipx/venvs/superpaper/share/applications/superpaper.desktop "$HOME"/.config/autostart/superpaper.desktop
fi


