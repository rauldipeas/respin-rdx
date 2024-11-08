#!/bin/bash
set -e
apt install -y git imagemagick
git clone --depth=1 --single-branch https://github.com/realmazharhussain/gdm-tools
cd gdm-tools
echo y|./install.sh
sed -i 's|IconTheme=Adwaita|IconTheme=Papirus|' /usr/share/themes/Adwaita/index.theme
sed -i 's|IconTheme=Adwaita|IconTheme=Papirus-Dark|' /usr/share/themes/Adwaita-dark/index.theme
sed -i 's|Tela-circle|Papirus|'\
    /usr/share/themes/Orchis/index.theme\
    /usr/share/themes/Orchis-Compact/index.theme\
    /usr/share/themes/Orchis-Dark/index.theme\
    /usr/share/themes/Orchis-Dark-Compact/index.theme\
    /usr/share/themes/Orchis-Light/index.theme\
    /usr/share/themes/Orchis-Light-Compact/index.theme\
cat <<EOF |tee -a /usr/local/share/themes/adw-gtk3/index.theme
IconTheme=Papirus
EOF
cat <<EOF |tee -a  /usr/local/share/themes/adw-gtk3-dark/index.theme
IconTheme=Papirus-Dark
EOF
mkdir -p /usr/share/backgrounds/gdm
convert /usr/share/backgrounds/unsplash/unsplash-gnome.jpg -blur 0x80 /usr/share/backgrounds/gdm/blured_unsplash-gnome.jpg
set-gdm-theme set Orchis-Dark-Compact /usr/share/backgrounds/gdm/blured_unsplash-gnome.jpg
echo y|./uninstall.sh --purge
cd ..
rm -rf gdm-tools
apt autoremove --purge -y git imagemagick