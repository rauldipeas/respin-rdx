#!/bin/bash
set -e

# GNOME lite
apt autoremove --purge -y\
    gedit*\
    gnome-startup-applications*\
    libreoffice*\
    ubuntu-desktop*\
    ubuntu-session*\
    update-manager-core*\
    yaru*
apt install -y\
    apturl\
    dmz-cursor-theme\
    file-roller\
    gir1.2-gmenu-3.0\
    gnome-backgrounds\
    gnome-calculator\
    gnome-characters\
    gnome-disk-utility\
    gnome-session\
    gnome-shell-extension-manager\
    gnome-shell-extension-appindicator\
    gnome-system-monitor\
    gnome-text-editor\
    gthumb\
    nautilus\
    totem\
    xdg-user-dirs-gtk
apt autoremove --purge -y yelp*
cat <<EOF |tee /usr/local/bin/firefox-gnome-setup
curl -s -o- https://raw.githubusercontent.com/rafaelmardojai/firefox-gnome-theme/master/scripts/install-by-curl.sh|bash
EOF
chmod +x /usr/local/bin/firefox-gnome-setup