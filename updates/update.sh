#!/bin/bash
set -e

# Alpha 0.2
sudo nala install -y -t bookworm-backports\
    linux-headers-rt-amd64\
    linux-image-rt-amd64 #;sudo nala autoremove --purge linux*generic*
sudo nala install -y\
    rtirq-init
am -i cryptomator #;sudo nala autoremove --purge veracrypt

# 09/03/2025 | 19:38
am icons mission-center
sudo sed -i 's|Icon=mission-center|Icon=io.missioncenter.MissionCenter|' /usr/local/share/applications/mission-center-AM.desktop
cat <<EOF |sudo tee -a /usr/local/share/applications/mission-center-AM.desktop
StartupWMClass=missioncenter
EOF

# 10/04/2025 | 23:36
sudo apt install -y -t bookworm-backports nala
sudo nala install -y -t bookworm-backports\
    libgl1-mesa-dri \
    libglx-mesa0 \
    mesa-vulkan-drivers \
    mesa-va-drivers \
    mesa-utils \
    libegl-mesa0 \
    libgbm1 \
    libglapi-mesa

# 27/04/2025 | 16:23
# XFCE
echo 'deb http://ppa.launchpad.net/xubuntu-dev/extras/ubuntu noble main'|sudo tee /etc/apt/sources.list.d/xubuntu-dev-extras.list
wget -qO- 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x53337a2d3790f409a00fe5bc4ed101bbe463faab'|sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/xubuntu-dev-extras.gpg
sudo apt update
sudo nala install -y --no-install-recommends xfce4
sudo nala install -y \
    mugshot \
    network-manager-gnome \
    pavucontrol \
    volumeicon-alsa \
    xfce4-docklike-plugin \
    xfce4-power-manager
wget -qO- "$(wget -qO- https://api.github.com/repos/leukipp/cortile/releases/latest|jq -r '.assets[] | select(.name | contains ("linux_amd64.tar.gz")) | .browser_download_url')"|tar -xz
rm LICENSE README.md
mv cortile /usr/local/bin
sudo mkdir -p /opt/rdx-user-settings/xfce/{volumeicon,xfce4/panel,xfce4/xfconf/xfce-perchannel-xml}
sudo wget -qO /opt/rdx-user-settings/xfce/volumeicon/volumeicon https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/volumeicon/volumeicon
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/panel/docklike-4.rc https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/panel/docklike-4.rc
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/panel/whiskermenu-1.rc https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/panel/whiskermenu-1.rc
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/xfconf/xfce-perchannel-xml/thunar.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/xfconf/xfce-perchannel-xml/thunar.xml
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml
sudo wget -qO /opt/rdx-user-settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/xfce/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
cp -r /opt/rdx-user-settings/xfce/volumeicon "$HOME"/.config/volumeicon
cp -r /opt/rdx-user-settings/xfce/xfce4 "$HOME"/.config/xfce4