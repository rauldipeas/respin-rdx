#!/bin/bash
set -e

# GNOME lite Rolling
apt autoremove --purge -y\
    gedit*\
    gnome-startup-applications*\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core*\
    yaru*
sed -i 's/jammy/devel/g' /etc/apt/sources.list
dpkg --add-architecture i386
apt update
export DEBIAN_FRONTEND=noninteractive
apt dist-upgrade -y -o Dpkg::Options::="--force-confold" --force-yes
apt install -y\
    apturl\
    dmz-cursor-theme\
    file-roller\
    gamemode\
    gdebi\
    gir1.2-gmenu-3.0\
    gnome-backgrounds\
    gnome-calculator\
    gnome-control-center\
    gnome-characters\
    gnome-disk-utility\
    gnome-session\
    gnome-shell-extension-manager\
    gnome-system-monitor\
    gnome-text-editor\
    gthumb\
    nautilus\
    totem\
    wireplumber\
    xdg-user-dirs-gtk
wget -q --show-progress https://cdn.akamai.steamstatic.com/client/installer/steam.deb
apt install -y ./steam.deb
git clone https://github.com/tkashkin/Adwaita-for-Steam
mkdir -p /etc/skel/.local/share/Steam/skins
mv Adwaita-for-Steam/Adwaita /etc/skel/.local/share/Steam/skins/
wget -q --show-progress "$(wget -qO- --header="X-Auth-Token: $GITHUB_TOKEN" https://api.github.com/repos/flightlessmango/MangoHud/releases|grep browser_download_url|grep tar.gz|head -n1|cut -d '"' -f4)"
tar fxz MangoHud*.tar.gz
cd MangoHud
./mangohud-setup.sh install
#pacstall -I -P steamtinkerlaunch-git
apt autoremove --purge -y yelp*
cat <<EOF |tee /usr/local/bin/firefox-gnome-setup
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh|bash
EOF
chmod +x /usr/local/bin/firefox-gnome-setup