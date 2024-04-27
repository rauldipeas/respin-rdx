#!/bin/bash
set -e

# Desempenho
## CFS Zen tweaks
rm -f cfs-zen-tweaks*.deb>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/igo95862/cfs-zen-tweaks/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
apt install -y ./cfs-zen-tweaks*.deb
systemctl enable set-cfs-tweaks.service
#sudo systemctl start set-cfs-tweaks.service
rm cfs-zen-tweaks*.deb
## ZSwap
#RAM="$(grep MemTotal /proc/meminfo|cut -d ' ' -f9)"
#sudo swapoff /swap.img
#sudo fallocate -l "$RAM" /swap.img
#sudo dd if=/dev/zero of=/swap.img bs=1024 count="$RAM" status=progress
#sudo chmod 600 /swap.img
#sudo mkswap /swap.img
#sudo swapon /swap.img
#sudo sed -i 's/quiet splash/quiet splash zswap.enabled=1 zswap.compressor=lz4/g' /etc/default/grub
#sudo update-grub
#echo lz4|sudo tee -a /etc/initramfs-tools/modules>/dev/null
#echo lz4_compress|sudo tee -a /etc/initramfs-tools/modules>/dev/null
#sudo update-initramfs -u -k all

# Instaladores de programas
## Pacstall
rm -f pacstall*.deb>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/pacstall/pacstall/releases|grep browser_download_url|grep .deb|head -n1|cut -d '"' -f4)"
apt install -y ./pacstall*.deb
rm pacstall*.deb

# Drivers
## JACK
echo 'jackd2 jackd/tweak_rt_limits string true'|debconf-set-selections
cat <<EOF |tee /etc/apt/preferences.d/qjackctl.pref>/dev/null
Package: qjackctl
Pin: release a=*
Pin-Priority: -10
EOF
apt install -y jackd2
rm /etc/apt/preferences.d/qjackctl.pref
## udev-rtirq
rm -f udev-rtirq>/dev/null
git clone -q https://github.com/jhernberg/udev-rtirq
cd udev-rtirq
make install
cd ..
rm -rf udev-rtirq

# rtcqs
#sudo apt install -y python3-tk
#pipx install rtcqs
#mkdir -p "$HOME"/.local/share/{applications,icons}
#wget -qO "$HOME"/.local/share/applications/rtcqs.desktop https://github.com/autostatic/rtcqs/raw/main/rtcqs.desktop
#sed -i "s@Exec=rtcqs_gui@Exec=$HOME/.local/bin/rtcqs_gui@g" "$HOME"/.local/share/applications/rtcqs.desktop
#wget -qO "$HOME"/.local/share/icons/rtcqs.svg https://github.com/autostatic/rtcqs/raw/main/rtcqs_logo.svg
## Configuração
usermod -aG audio "$USER"
cat <<EOF |tee /etc/sysctl.d/swappiness.conf>/dev/null
vm.swappiness = 10
EOF
cat <<EOF |tee /etc/default/grub.d/cmdline-linux-default.cfg>/dev/null
GRUB_CMDLINE_LINUX_DEFAULT="cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs"
EOF
update-grub
wget -qO --show-progress /etc/udev/rules.d/99-cpu-dma-latency.rules https://raw.githubusercontent.com/Ardour/ardour/master/tools/udev/99-cpu-dma-latency.rules

# Multimídia
## Cadence
rm -f kxstudio-repos*.deb>/dev/null
wget -q --show-progress http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/"$(wget -qO- http://ppa.launchpad.net/kxstudio-debian/kxstudio/ubuntu/pool/main/k/kxstudio-repos/|grep all.deb|tail -n1|cut -d '"' -f8)"
apt install -y ./kxstudio-repos*.deb
rm kxstudio-repos*.deb
add-apt-repository -ny multiverse
add-apt-repository -y universe
apt install -y alsa-firmware cadence
cat <<EOF |tee /etc/apt/preferences.d/meterbridge.pref>/dev/null
Package: meterbridge
Pin: release a=*
Pin-Priority: -10
EOF
apt install -y jackd2
rm /etc/apt/preferences.d/meterbridge.pref
systemctl --user mask pipewire.service pipewire.socket
#systemctl --user stop pipewire.service pipewire.socket
systemctl --user disable pipewire.service pipewire.socket
sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/pulseaudio.desktop
sed -i 's/Systemd=true/Systemd=false/g' /etc/xdg/autostart/pulseaudio.desktop
sed -i 's/start-pulseaudio-x11/systemctl --user start pulseaudio.service/g' /etc/xdg/autostart/pulseaudio.desktop
#systemctl --user start pulseaudio.service pulseaudio.socket
#pactl info|grep "Nome do servidor"
## WINE TkG
dpkg --add-architecture i386
apt update
apt install -y q4wine wine wine32:i386 winetricks
rm -f wine*staging-tkg-amd64.tar.xz>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/Kron4ek/Wine-Builds/releases|grep browser_download_url|grep staging-tkg-amd64.tar.xz|head -n1|cut -d '"' -f4)"
tar fx wine*staging-tkg-amd64.tar.xz
rm wine*staging-tkg-amd64.tar.xz
mv wine*staging-tkg-amd64 /opt/wine-tkg
find . -name "*lutris-ge*" -print0|xargs -0 rm -rf>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases|grep browser_download_url|grep wine-lutris-ge|grep .tar.xz|head -n1|cut -d '"' -f4)"
tar fx wine-lutris-ge*.tar.xz
cp lutris*/lib/wine/i386-windows/winemenubuilder.exe /opt/wine-tkg/lib/wine/i386-windows/winemenubuilder.exe
cp lutris*/lib64/wine/x86_64-windows/winemenubuilder.exe /opt/wine-tkg/lib/wine/x86_64-windows/winemenubuilder.exe
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
mkdir -p /opt/wine-tkg/share/wine/{gecko,mono}
tar fx wine-gecko-*-x86.tar.xz -C /opt/wine-tkg/share/wine/gecko/
tar fx wine-gecko-*-x86_64.tar.xz -C /opt/wine-tkg/share/wine/gecko/
tar fx wine-mono-*-x86.tar.xz -C /opt/wine-tkg/share/wine/mono/
rm wine-gecko-*-x86.tar.xz
rm wine-gecko-*-x86_64.tar.xz
rm wine-mono-*-x86.tar.xz
cat <<EOF |tee /etc/environment.d/99wine.conf>/dev/null
if [ -d "/opt/wine-tkg/bin" ] ; then
    PATH="/opt/wine-tkg/bin:\$PATH"
fi
export WINE_ENABLE_PIPE_SYNC_FOR_APP=1
export WINEESYNC=1
export WINEFSYNC=1
EOF
### Configuração
#winetricks -f -q dxvk
## yabridge
rm -f yabridge*.tar.gz>/dev/null
wget -q --show-progress "$(wget -qO- https://api.github.com/repos/robbert-vdh/yabridge/releases|grep browser_download_url|head -n2|tail -n1|cut -d '"' -f4)"
tar fxz yabridge*.tar.gz
rm -r yabridge*.tar.gz
mv yabridge/yabridgectl /usr/bin/yabridgectl
mv yabridge/libyabridge* /usr/lib/
mv yabridge/yabridge* /usr/bin/
rm -r yabridge
### Configuração
#mkdir -p "$HOME"/.wine/drive_c/Program\ Files/Common\ Files/VST3
#mkdir -p "$HOME"/.wine/drive_c/Program\ Files/VSTPlugins
#yabridgectl add "$HOME"/.wine/drive_c/Program\ Files/Common\ Files/VST3
#yabridgectl add "$HOME"/.wine/drive_c/Program\ Files/VSTPlugins
#yabridgectl sync --prune --verbose
## REAPER
cd /tmp
rm -rf /tmp/*reaper* /tmp/*libSwell*>/dev/null
wget -q --show-progress http://reaper.fm/"$(wget -qO- http://reaper.fm/download.php|grep _linux_x86_64.tar.xz|cut -d '"' -f2)"
tar fx reaper*_linux_x86_64.tar.xz -C /tmp
sed -i 's/rmdir --/rm -rf --/g' /tmp/reaper*/install-reaper.sh
/tmp/reaper*/install-reaper.sh --install /opt --integrate-desktop --quiet --integrate-sys-desktop
wget -qO libSwell.colortheme https://stash.reaper.fm/41334/libSwell.colortheme
mv libSwell.colortheme /opt/REAPER/libSwell.colortheme
rm -rf /tmp/*reaper* /tmp/*libSwell*
cd
cat <<EOF |tee -a /usr/share/applications/cockos-reaper.desktop>/dev/null
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
#mkdir -p "$HOME"/.config/REAPER/{LangPack,UserPlugins}
#wget -O "$HOME"/.config/REAPER/LangPack/pt-BR.ReaperLangPack https://stash.reaper.fm"$(wget -qO- https://stash.reaper.fm/tag/Language-Packs|grep pt-BR|head -n1|cut -d '"' -f2|sed 's/\/v//g')"
#rm sws-*-Linux-x86_64-*.tar.xz>/dev/null
#wget https://sws-extension.org/download/pre-release/"$(wget -qO- http://sws-extension.org/download/pre-release/|grep Linux-x86_64|head -n1|cut -d '"' -f4)"
#tar fx sws-*-Linux-x86_64-*.tar.xz -C "$HOME"/.config/REAPER
#rm sws-*-Linux-x86_64-*.tar.xz
#wget -O "$HOME"/.config/REAPER/UserPlugins/reaper_reapack-x86_64.so "$(wget -qO- https://api.github.com/repos/cfillion/reapack/releases|grep browser_download_url|grep download/v|grep x86_64.so|head -n1|cut -d '"' -f4)"