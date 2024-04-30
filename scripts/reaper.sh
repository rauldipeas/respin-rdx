#!/bin/bash
set -e

if [ -f /opt/REAPER/reaper ];then
    echo reaper instalado!
    else
    cd /tmp
    rm -rf /tmp/*reaper* /tmp/*libSwell*>/dev/null
    wget -q --show-progress http://reaper.fm/"$(wget -qO- http://reaper.fm/download.php|grep _linux_x86_64.tar.xz|cut -d '"' -f2)"
    tar fx reaper*_linux_x86_64.tar.xz -C /tmp
    sed -i 's/rmdir --/rm -rf --/g' /tmp/reaper*/install-reaper.sh
    sudo /tmp/reaper*/install-reaper.sh --install /opt --integrate-desktop --quiet --integrate-sys-desktop
    wget -qO libSwell.colortheme https://stash.reaper.fm/41334/libSwell.colortheme
    sudo mv libSwell.colortheme /opt/REAPER/libSwell.colortheme
    rm -rf /tmp/*reaper* /tmp/*libSwell*
    cd
    cat <<EOF |sudo tee -a /usr/share/applications/cockos-reaper.desktop>/dev/null
# Ações complementares
Actions=NewProject;ShowAudioConfig;ReaMote;WhatsNew;License;
[Desktop Action NewProject]
Name=REAPER (create new project)
Name[pt_BR]=REAPER (criar novo projeto)
Exec=/opt/REAPER/reaper -new
Icon=cockos-reaper
[Desktop Action ShowAudioConfig]
Name=REAPER (show audio configuration on startup)
Name[pt_BR]=REAPER (mostrar configurações de áudio ao iniciar)
Exec=/opt/REAPER/reaper -audiocfg
Icon=cockos-reaper
[Desktop Action ReaMote]
Name=ReaMote
Exec=/opt/REAPER/reamote-server
Icon=folder-remote
[Desktop Action WhatsNew]
Name=What's new
Name[pt_BR]=O que há de novo?
Exec=xdg-open /opt/REAPER/whatsnew.txt
Icon=text-x-plain
[Desktop Action License]
Name=License and User Agreement
Name[pt_BR]=Licença e contrato de usuário
Exec=xdg-open /opt/REAPER/EULA.txt
Icon=text-x-plain
EOF
    ### Configuração
    mkdir -p "$HOME"/.config/REAPER/{LangPack,UserPlugins}
    wget -O "$HOME"/.config/REAPER/LangPack/pt-BR.ReaperLangPack https://stash.reaper.fm"$(wget -qO- https://stash.reaper.fm/tag/Language-Packs|grep pt-BR|head -n1|cut -d '"' -f2|sed 's/\/v//g')"
    rm -f sws-*-Linux-x86_64-*.tar.xz>/dev/null
    wget https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
    tar fx sws-*-Linux-x86_64-*.tar.xz -C "$HOME"/.config/REAPER
    rm sws-*-Linux-x86_64-*.tar.xz
    wget -O "$HOME"/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"