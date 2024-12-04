#!/bin/bash
set -e
pipx install gnome-extensions-cli --system-site-packages
apt install -y git
#arcmenu
#"$HOME"/.local/bin/gext install arcmenu@arcmenu.com
apt install -y libgettextpo-dev gettext
git clone --single-branch --branch gnome-42/43/44 https://gitlab.com/arcmenu/ArcMenu
cd ArcMenu
make install
cd ..
rm -r ArcMenu
#blur my shell
#"$HOME"/.local/bin/gext install blur-my-shell@aunetx
git clone https://github.com/aunetx/blur-my-shell
cd blur-my-shell
make install
cd ..
rm -r blur-my-shell
#debian-updates-indicator
#"$HOME"/.local/bin/gext install debian-updates-indicator@glerro.pm.me
apt install -y meson
git clone https://gitlab.gnome.org/glerro/gnome-shell-extension-debian-updates-indicator
cd gnome-shell-extension-debian-updates-indicator
meson setup --prefix="$HOME"/.local _build
meson install -C _build
cd ..
rm -r gnome-shell-extension-debian-updates-indicator
apt autoremove --purge -y meson
#emoji copy
#"$HOME"/.local/bin/gext install emoji-copy@felipeftn
apt install -y zip
git clone https://github.com/FelipeFTN/Emoji-Copy
cd Emoji-Copy
make install
cd ..
rm -r Emoji-Copy
apt autoremove --purge zip
#extensions-sync
#"$HOME"/.local/bin/gext install extensions-sync@elhan.io
apt install -y yarnpkg
git clone https://github.com/oae/gnome-shell-extensions-sync
cd gnome-shell-extensions-sync
yarn install
yarn build
ln -s "$PWD"/dist "$HOME"/.local/share/gnome-shell/extensions/extensions-sync@elhan.io
cd ..
rm -r gnome-shell-extensions-sync
#apt autoremove --purge -y yarnpkg
#forge
#"$HOME"/.local/bin/gext install forge@jmmaranan.com
git clone https://github.com/forge-ext/forge
cd forge
make install
cd ..
rm -r forge
#notification banner reloaded
#"$HOME"/.local/bin/gext install notification-banner-reloaded@marcinjakubowski.github.com
git clone https://github.com/marcinjakubowski/notification-position-reloaded "$HOME"/.local/share/gnome-shell/extensions/notification-banner-reloaded@marcinjakubowski.github.com
#pano
#"$HOME"/.local/bin/gext install pano@elhan.io
#apt install -y yarn
git clone https://github.com/oae/gnome-shell-pano.git
cd gnome-shell-pano
yarn install
yarn build
ln -s "$PWD"/dist "$HOME"/.local/share/gnome-shell/extensions/pano@elhan.io
cd ..
rm -r gnome-shell-pane
apt autoremove --purge -y yarnpkg
#quick settings audio panel
#"$HOME"/.local/bin/gext install quick-settings-audio-panel@rayzeq.github.io
git clone https://github.com/Rayzeq/quick-settings-audio-panel "$HOME"/.local/share/gnome-shell/extensions/quick-settings-audio-panel@rayzeq.github.io
#status area horizontal spacing
#"$HOME"/.local/bin/gext install status-area-horizontal-spacing@mathematical.coffee.gmail.com
git clone https://gitlab.com/p91paul/status-area-horizontal-spacing-gnome-shell-extension
mv status-area-horizontal-spacing-gnome-shell-extension/status-area-horizontal-spacing@mathematical.coffee.gmail.com "$HOME"/.local/share/gnome-shell/extensions/status-area-horizontal-spacing@mathematical.coffee.gmail.com
rm -r status-area-horizontal-spacing-gnome-shell-extension
#tray-icons-reloaded
#"$HOME"/.local/bin/gext install trayIconsReloaded@selfmade.pl
git clone https://github.com/martinpl/tray-icons-reloaded "$HOME"/.local/share/gnome-shell/extensions/trayIconsReloaded@selfmade.pl
#user themes
#"$HOME"/.local/bin/gext install user-theme@gnome-shell-extensions.gcampax.github.com
#workspace indicator
#"$HOME"/.local/bin/gext install horizontal-workspace-indicator@tty2.io
git clone https://github.com/tty2/horizontal-workspace-indicator "$HOME"/.local/share/gnome-shell/extensions/horizontal-workspace-indicator@tty2.io
#wtmb
#"$HOME"/.local/bin/gext install window-thumbnails@G-dH.github.com
git clone https://github.com/G-dH/window-thumbnails
cd window-thumbnails
git checkout gnome-42-44
make install
cd ..
rm -r window-thumbnails
#x11 gestures
#"$HOME"/.local/bin/gext install x11gestures@joseexposito.github.io
apt autoremove --purge -y git
mkdir -p /opt/rdx-user-settings/gnome-shell
mv /root/.local/share/gnome-shell/extensions /opt/rdx-user-settings/gnome-shell/