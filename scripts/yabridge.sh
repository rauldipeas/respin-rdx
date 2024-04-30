#!/bin/bash
set -e

if [ -f /usr/bin/yabridgectl ];then
    echo yabridge instalado!
    else
    rm -f yabridge*.tar.gz>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/robbert-vdh/yabridge/releases|grep browser_download_url|head -n2|tail -n1|cut -d '"' -f4)"
    tar fxz yabridge*.tar.gz
    rm yabridge*.tar.gz
    sudo mv yabridge/yabridgectl /usr/bin/yabridgectl
    sudo mv yabridge/libyabridge* /usr/lib/
    sudo mv yabridge/yabridge* /usr/bin/
    rm -r yabridge
    ### Configuração
    mkdir -p "$HOME"/.wine/drive_c/Program\ Files/Common\ Files/VST3
    mkdir -p "$HOME"/.wine/drive_c/Program\ Files/VSTPlugins
    yabridgectl add "$HOME"/.wine/drive_c/Program\ Files/Common\ Files/VST3
    yabridgectl add "$HOME"/.wine/drive_c/Program\ Files/VSTPlugins
    yabridgectl sync --prune --verbose
fi