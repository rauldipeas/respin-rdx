#!/bin/bash
set -e

if [ -f /opt/wine-tkg/bin/wine ] && [ -f /etc/environment.d/99wine.conf ];then
    echo wine-tkg instalado!
    else
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
            sudo dpkg --add-architecture i386
            sudo apt update 2>/dev/null
            sudo apt install -y q4wine wine wine32:i386 winetricks
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
            sudo dpkg --add-architecture i386
            sudo apt update 2>/dev/null
            sudo apt install -y q4wine wine wine32:i386 winetricks
            else
            echo 'Sua versão do Ubuntu não é suportada no momento.'
        fi
        else
        echo 'Sua distribuição não é suportada no momento.'
    fi
    rm -f wine*staging-tkg-amd64.tar.xz>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/Kron4ek/Wine-Builds/releases|grep browser_download_url|grep staging-tkg-amd64.tar.xz|head -n1|cut -d '"' -f4)"
    tar fx wine*staging-tkg-amd64.tar.xz
    rm wine*staging-tkg-amd64.tar.xz
    sudo mv wine*staging-tkg-amd64 /opt/wine-tkg
    find . -name "*lutris-ge*" -print0|xargs -0 rm -rf>/dev/null
    wget -q --show-progress "$(wget -qO- https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases|grep browser_download_url|grep wine-lutris-ge|grep .tar.xz|head -n1|cut -d '"' -f4)"
    tar fx wine-lutris-ge*.tar.xz
    sudo cp lutris*/lib/wine/i386-windows/winemenubuilder.exe /opt/wine-tkg/lib/wine/i386-windows/winemenubuilder.exe
    sudo cp lutris*/lib64/wine/x86_64-windows/winemenubuilder.exe /opt/wine-tkg/lib/wine/x86_64-windows/winemenubuilder.exe
    find . -name "*lutris-ge*" -print0|xargs -0 rm -r
    rm -f wine-gecko-*-x86.tar.xz>/dev/null
    rm -f wine-gecko-*-x86_64.tar.xz>/dev/null
    rm -f wine-mono-*-x86.tar.xz>/dev/null
    WINE_GECKO_VER="$(wget -qO- https://dl.winehq.org/wine/wine-gecko/|grep folder|cut -d '"' -f6|sort -d|grep -v wine|tail -n1)"
    wget -qO- https://dl.winehq.org/wine/wine-gecko/"$WINE_GECKO_VER"|grep x86|grep tar|grep -wv pdb|grep -wv rc|cut -d '"' -f6>wine-gecko.links
    sed -i 's@wine-gecko@https://dl.winehq.org/wine/wine-gecko/wine-gecko@g' wine-gecko.links
    sed -i 's@wine/wine-gecko/@'wine/wine-gecko/"$WINE_GECKO_VER"'@g' wine-gecko.links
    wget -q --show-progress "$(cat<wine-gecko.links|head -n1)"
    wget -q --show-progress "$(cat<wine-gecko.links|tail -n1)"
    rm wine-gecko.links>/dev/null
    WINE_MONO_VER="$(wget -qO- https://dl.winehq.org/wine/wine-mono/|grep folder|cut -d '"' -f6|sort -g|tail -n1)"
    wget -qO- https://dl.winehq.org/wine/wine-mono/"$WINE_MONO_VER"|grep x86|grep tar|cut -d '"' -f6>wine-mono.links
    sed -i 's@wine-mono@https://dl.winehq.org/wine/wine-mono/wine-mono@g' wine-mono.links
    sed -i 's@wine/wine-mono/@'wine/wine-mono/"$WINE_MONO_VER"'@g' wine-mono.links
    wget -q --show-progress "$(cat<wine-mono.links|head -n1)"
    rm wine-mono.links
    sudo mkdir -p /opt/wine-tkg/share/wine/{gecko,mono}
    sudo tar fx wine-gecko-*-x86.tar.xz -C /opt/wine-tkg/share/wine/gecko/
    sudo tar fx wine-gecko-*-x86_64.tar.xz -C /opt/wine-tkg/share/wine/gecko/
    sudo tar fx wine-mono-*-x86.tar.xz -C /opt/wine-tkg/share/wine/mono/
    rm wine-gecko-*-x86.tar.xz
    rm wine-gecko-*-x86_64.tar.xz
    rm wine-mono-*-x86.tar.xz
    if [ $(echo $XDG_SESSION_TYPE) = x11 ];then
        if grep wine-tkg "$HOME"/.xsessionrc && grep WINEFSYNC "$HOME"/.xsessionrc;then
            echo wine-tkg habilitado!
            else
            cat <<EOF |tee "$HOME"/.xsessionrc>/dev/null
if [ -d /opt/wine-tkg/bin ];then
    PATH="/opt/wine-tkg/bin:\$PATH"
fi
export WINE_ENABLE_PIPE_SYNC_FOR_APP=1
export WINEESYNC=1
export WINEFSYNC=1
EOF
        fi
        else
        cat <<EOF |sudo tee /etc/environment.d/99wine.conf>/dev/null
if [ -d /opt/wine-tkg/bin ];then
    PATH="/opt/wine-tkg/bin:\$PATH"
fi
export WINE_ENABLE_PIPE_SYNC_FOR_APP=1
export WINEESYNC=1
export WINEFSYNC=1
EOF
    fi
fi
### Configuração
if [ -d $HOME/.wine ];then
    echo wine configurado!
    else
    winetricks -f -q dxvk mfc42
fi