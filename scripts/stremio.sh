#!/bin/bash
set -e

## Stremio
if [ -f /usr/bin/stremio ];then
    echo stremio instalado!
    else
    if grep ii <(dpkg --list libssl1.1);then
        echo libssl1.1 instalado
        else
        rm -f libssl1.1*.deb>/dev/null
        wget -cq --show-progress http://security.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.22_amd64.deb
        sudo apt install ./libssl1.1*.deb
        rm libssl1.1*.deb
    fi
    if  \
        grep ii <(dpkg --list nodejs) &&\
        grep ii <(dpkg --list libmpv2) &&\
        grep ii <(dpkg --list qml-module-qt-labs-platform) &&\
        grep ii <(dpkg --list qml-module-qtquick-controls) &&\
        grep ii <(dpkg --list qml-module-qtquick-dialogs) &&\
        grep ii <(dpkg --list qml-module-qtwebchannel) &&\
        grep ii <(dpkg --list qml-module-qtwebengine) &&\
        grep ii <(dpkg --list qml-module-qt-labs-folderlistmodel) &&\
        grep ii <(dpkg --list qml-module-qt-labs-settings) &&\
        grep ii <(dpkg --list librubberband2) &&\
        grep ii <(dpkg --list libfdk-aac2);then
        echo dependências instaladas!
        else
        sudo apt install -y \
            nodejs\
            libmpv2\
            qml-module-qt-labs-platform\
            qml-module-qtquick-controls\
            qml-module-qtquick-dialogs\
            qml-module-qtwebchannel\
            qml-module-qtwebengine\
            qml-module-qt-labs-folderlistmodel\
            qml-module-qt-labs-settings\
            librubberband2\
            libfdk-aac2
    fi
    if [ -f /usr/lib/x86_64-linux-gnu/libmpv.so.1 ];then
        echo libmpv1 instalado!
        else
        sudo ln -fs\
            /usr/lib/x86_64-linux-gnu/libmpv.so.2\
            /usr/lib/x86_64-linux-gnu/libmpv.so.1
    fi
    if [ -d /opt/stremio ];then
        echo stremio instalado!
        else
        rm -rf stremio*.deb stremio/>/dev/null
        wget -cq --show-progress https://dl.strem.io/shell-linux/v4.4.168/stremio_4.4.168-1_amd64.deb
        dpkg-deb -R stremio*.deb stremio
        sudo mv stremio/opt/stremio /opt/
        sudo ln -fs\
            /opt/stremio/stremio\
            /usr/bin/stremio
        sudo ln -fs\
            /opt/stremio/smartcode-stremio.desktop\
            /usr/share/applications/smartcode-stremio.desktop
        sudo ln -fs\
            /opt/stremio/icons/smartcode-stremio_128.png\
            /usr/share/pixmaps/smartcode-stremio.png
        rm -r stremio*.deb stremio/
    fi
fi