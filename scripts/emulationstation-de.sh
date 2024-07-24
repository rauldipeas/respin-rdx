#!/bin/bash
set -e

### EmulationStation DE
if [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=debian' ];then
    echo 'Você está numa instalação do Debian...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=bookworm' ];then
        echo Bookworm
        if  grep ii <(dpkg --list libfuse2 2>/dev/null);then
            echo libfuse2 instalado!
            else
            sudo apt install -y	libfuse2
        fi
        else
        echo 'Sua versão do Debian não é suportada no momento.'
    fi
elif [ "$(grep "^ID=" <(cat /etc/*release))" = 'ID=ubuntu' ];then
    echo 'Você está numa instalação do Ubuntu...'
    if [ "$(grep "^VERSION_CODENAME=" <(cat /etc/*release))" = 'VERSION_CODENAME=noble' ];then
        echo Noble
        if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
            echo libfuse2t64 instalado!
            else
            if  grep ii <(dpkg --list libfuse2t64 2>/dev/null);then
                echo libfuse2t64 instalado!
                else
                sudo apt install -y	libfuse2t64
            fi
        fi
        else
        echo 'Sua versão do Ubuntu não é suportada no momento.'
    fi
    else
    echo 'Sua distribuição não é suportada no momento.'
fi
if [ -f "$HOME"/Applications/EmulationStation-DE-x64.AppImage ] && [ -f "$HOME"/.local/share/applications/emulationstation-de.desktop ];then
    echo emulationstation instalado!
    else
    mkdir -p "$HOME"/Applications "$HOME"/.local/share/applications
    wget -cq --show-progress -O "$HOME"/Applications/EmulationStation-DE-x64.AppImage https://gitlab.com/es-de/emulationstation-de/-/package_files/127490092/download
    chmod +x "$HOME"/Applications/EmulationStation-DE-x64.AppImage
cat <<EOF |tee "$HOME"/.local/share/applications/emulationstation-de.desktop>/dev/null
[Desktop Entry]
Version=1.0
Exec=$HOME/Applications/EmulationStation-DE-x64.AppImage
Icon=emulationstation
Terminal=false
Type=Application
StartupNotify=true
Hidden=false
Categories=Game;Emulator;
Name=EmulationStation Desktop Edition
GenericName=Emulator Frontend
Keywords=emulator;emulation;front-end;frontend;
StartupWMClass=es-de
EOF
fi

# Cemu*.AppImage
# duckstation-qt*.AppImage
    #duckstation-nogui*.AppImage
    #DuckStation*.AppImage
#Dolphin_Emulator*.AppImage
    #dolphin-emu-triforce*.AppImage
# flycast-x86*.AppImage
    #flycast-dojo*.AppImage
# pcsx2*.AppImage
# RetroArch-Linux*.AppImage
# rpcs3*.AppImage
# Vita3K*.AppImage
# xemu*.AppImage

#Alber-*.AppImage
#BasiliskII*.AppImage
#citra-qt*.AppImage
#EKA2L1*.AppImage
#Gargoyle*.AppImage
#lime-qt*.AppImage
#Mesen*.AppImage
#mGBA*.AppImage
#Play!*.AppImage
#RMG*.AppImage
#SheepShaver*.AppImage
#Snes9x*.AppImage