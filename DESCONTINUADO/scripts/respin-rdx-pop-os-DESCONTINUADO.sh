#!/bin/bash
set -e
cd

# Atualização do sistema
sudo apt update
sudo apt upgrade -y

# Instaladores de programas
## apt-rollback
sudo apt install -y apt-rollback
## nala
sudo apt install -y nala
## Pacstall
rm -rf pacstall*.deb>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/pacstall/pacstall/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
sudo apt install -y ./pacstall*.deb
rm pacstall*.deb
## pipx
sudo apt install -y pipx
## Synaptic
sudo apt install -y synaptic

# Drivers
## ALSA Firmware
rm -rf kxstudio-repos*.deb>/dev/null
wget -cq --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
sudo apt install -y ./kxstudio-repos*.deb
sudo apt install -y alsa-firmware
rm kxstudio-repos*.deb
## JACK
echo 'jackd2 jackd/tweak_rt_limits string true'|sudo debconf-set-selections
cat <<EOF |sudo tee /etc/apt/preferences.d/qjackctl.pref>/dev/null
Package: qjackctl
Pin: release a=*
Pin-Priority: -10
EOF
sudo apt install -y jackd2
sudo rm /etc/apt/preferences.d/qjackctl.pref
## udev-rtirq
rm -rf udev-rtirq>/dev/null
git clone -q https://github.com/jhernberg/udev-rtirq
cd udev-rtirq
sudo make install
cd ..
rm -rf udev-rtirq

# rtcqs
sudo apt install -y python3-tk
pipx install --force rtcqs
mkdir -p "$HOME"/.local/share/{applications,icons}
wget -qO "$HOME"/.local/share/applications/rtcqs.desktop https://github.com/autostatic/rtcqs/raw/main/rtcqs.desktop
sed -i "s@Exec=rtcqs_gui@Exec=$HOME/.local/bin/rtcqs_gui@g" "$HOME"/.local/share/applications/rtcqs.desktop
wget -qO "$HOME"/.local/share/icons/rtcqs.svg https://github.com/autostatic/rtcqs/raw/main/rtcqs_logo.svg
## Configuração
sudo usermod -aG audio "$USER"
cat <<EOF |sudo tee /etc/rc.local>/dev/null
#!/bin/bash
set -e
sysctl --system
EOF
sudo chmod +x /etc/rc.local
sudo kernelstub -a "cpufreq.default_governor=performance mitigations=off preempt=full threadirqs"
sudo wget -qO /etc/udev/rules.d/99-cpu-dma-latency.rules https://raw.githubusercontent.com/Ardour/ardour/master/tools/udev/99-cpu-dma-latency.rules
### PipeWire
mkdir -p "$HOME"/.config/pipewire
cp /usr/share/pipewire/pipewire.conf "$HOME"/.config/pipewire/

# Multimídia
## WINE TkG
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y q4wine wine wine32:i386 winetricks
rm -rf wine*staging-tkg-amd64.tar.xz>/dev/null
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
rm -rf wine-gecko-*-x86.tar.xz>/dev/null
rm -rf wine-gecko-*-x86_64.tar.xz>/dev/null
rm -rf wine-mono-*-x86.tar.xz>/dev/null
WINE_GECKO_VER="$(wget -qO- https://dl.winehq.org/wine/wine-gecko/|grep folder|cut -d '"' -f6|sort -d|grep -v wine|tail -n1)"
wget -qO- https://dl.winehq.org/wine/wine-gecko/"$WINE_GECKO_VER"|grep x86|grep tar|grep -wv pdb|grep -wv rc|cut -d '"' -f6>wine-gecko.links
sed -i 's@wine-gecko@https://dl.winehq.org/wine/wine-gecko/wine-gecko@g' wine-gecko.links
sed -i 's@wine/wine-gecko/@'wine/wine-gecko/"$WINE_GECKO_VER"'@g' wine-gecko.links
wget -q --show-progress "$(cat<wine-gecko.links|head -n1)"
wget -q --show-progress "$(cat<wine-gecko.links|tail -n1)"
rm -rf wine-gecko.links>/dev/null
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
rm -r wine-gecko-*-x86.tar.xz
rm -r wine-gecko-*-x86_64.tar.xz
rm -r wine-mono-*-x86.tar.xz
cat <<EOF |sudo tee /etc/environment.d/99wine.conf>/dev/null
if [ -d "/opt/wine-tkg/bin" ] ; then
    PATH="/opt/wine-tkg/bin:\$PATH"
fi
export WINE_ENABLE_PIPE_SYNC_FOR_APP=1
export WINEESYNC=1
export WINEFSYNC=1
EOF
### Configuração
winetricks -f -q dxvk
## yabridge
rm -rf yabridge*.tar.gz>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/robbert-vdh/yabridge/releases|grep browser_download_url|head -n2|tail -n1|cut -d '"' -f4)"
tar fxz yabridge*.tar.gz
rm -r yabridge*.tar.gz
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
## REAPER
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
rm -rf sws-*-Linux-x86_64-*.tar.xz>/dev/null
wget https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
tar fx sws-*-Linux-x86_64-*.tar.xz -C "$HOME"/.config/REAPER
rm sws-*-Linux-x86_64-*.tar.xz
wget -O "$HOME"/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"
## MediaInfo GUI
sudo apt install -y mediainfo-gui
## WinFF
sudo apt install -y winff