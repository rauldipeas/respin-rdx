#!/bin/bash
set -e
mkdir -p /opt/rdx-user-settings/bash
wget -qO /opt/rdx-user-settings/bash/bashrc https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/bashrc
wget -qO /opt/rdx-user-settings/bash/bash-preexec.sh https://github.com/rcaloras/bash-preexec/raw/master/bash-preexec.sh
wget -qO /opt/rdx-user-settings/bash/atuin.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/atuin.bash
wget -qO /opt/rdx-user-settings/bash/liquidprompt.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/liquidprompt.bash
wget -qO /opt/rdx-user-settings/bash/local-bin.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/local-bin.bash
wget -qO /opt/rdx-user-settings/dconf-settings.ini https://github.com/rauldipeas/respin-rdx/raw/main/settings/dconf-settings.ini
wget -qO /opt/rdx-user-settings/onlyoffice-desktopeditors.conf https://github.com/rauldipeas/respin-rdx/raw/main/settings/onlyoffice-desktopeditors.conf
wget -qO /opt/rdx-user-settings/adaptive.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/adaptive.xml
mkdir -p /usr/local/share/gtksourceview-4/styles/
cp /opt/rdx-user-settings/adaptive.xml /usr/local/share/gtksourceview-4/styles/adaptive.xml
wget -qO /opt/rdx-user-settings/topgrade-config.toml https://github.com/topgrade-rs/topgrade/raw/main/config.example.toml
sed -i 's|# no_self_update|no_self_update|' /opt/rdx-user-settings/topgrade-config.toml
sed -i 's|\[deno\]|#\[deno\]|' /opt/rdx-user-settings/topgrade-config.toml
cat <<EOF |tee -a /usr/share/applications/org.tribler.Tribler.desktop
StartupWMClass=tribler
EOF
cat <<EOF |tee /usr/local/share/applications/respinrdx.featurebase.app.desktop>/dev/null
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=preferences-desktop-feedback
Name=User feedback
Name[pt_BR]=Feedback do usuário
Comment=Share your thoughts and help to improve the Respin RDX
Comment[pt_BR]=Compartilhe suas ideias e ajude a melhorar o Respin RDX
Categories=Internet;
Exec=xdg-open https://respinrdx.featurebase.app
EOF
cat <<EOF |tee /usr/local/bin/browser-installer
#!/bin/bash
set -e
ICON_DIR="/usr/share/icons/Papirus/128x128/apps"
install() {
    case \$1 in
        brave-browser) am -i --icons brave-browser ;;
        chromium) am -i --icons chromium ;;
        org.gnome.Epiphany) sudo nala install -y --no-install-recommends epiphany-browser ;;
        firefox) am -i --icons firefox ;;
        org.kde.falkon) sudo nala install -y --no-install-recommends falkon ;;
        google-chrome) am -i --icons google-chrome ;;
        librewolf) am -i --icons librewolf ;;
        mercury) am -i --icons mercury ;;
        mullvad-browser) am -i mullvad-browser ;;
        ungoogled-chromium) am -i --icons ungoogled-chromium ;;
        opera) am -i --icons opera ;;
        palemoon) am -i --icons palemoon ;;
        tor-browser) am -i --icons tor-browser ;;
        vivaldi-stable) am -i --icons vivaldi-stable ;;
        waterfox) am -i --icons waterfox ;;
        zen-browser) am -i --icons zen-browser ;;
        *) echo "Invalid" ;;
    esac
}
pin() {
    gsettings set org.gnome.shell favorite-apps "\$(gsettings get org.gnome.shell favorite-apps|sed s/browser-installer/\$(fd \$1 /usr/share /usr/local/share|grep .desktop\$|sed s/.*\$1/\$1/|sed s/.desktop//)/)"
}
browser=\$(yad --list --title="Browser installer" --text="Choose the browser to install:" \\
    --column="Icon:IMG" --column="Browser" --column="package" \\
    "\$ICON_DIR/brave.svg" "Brave" "brave-browser" \\
    "\$ICON_DIR/chromium.svg" "Chromium" "chromium" \\
    "\$ICON_DIR/org.gnome.Epiphany.svg" "GNOME Web" "org.gnome.Epiphany" \\
    "\$ICON_DIR/firefox.svg" "Firefox" "firefox" \\
    "\$ICON_DIR/falkon.svg" "Falkon" "org.kde.falkon" \\
    "\$ICON_DIR/google-chrome.svg" "Google Chrome" "google-chrome" \\
    "\$ICON_DIR/librewolf.svg" "Librewolf" "librewolf" \\
    "\$ICON_DIR/mercury.svg" "Mercury" "mercury" \\
    "\$ICON_DIR/mullvad-browser.svg" "Mullvad" "mullvad-browser" \\
    "\$ICON_DIR/com.github.Eloston.UngoogledChromium.svg" "Ungoogled Chromium" "ungoogled-chromium" \\
    "\$ICON_DIR/opera.svg" "Opera" "opera" \\
    "\$ICON_DIR/palemoon.svg" "Palemoon" "palemoon" \\
    "\$ICON_DIR/tor-browser.svg" "Tor Browser" "tor-browser" \\
    "\$ICON_DIR/vivaldi.svg" "Vivaldi" "vivaldi-stable" \\
    "\$ICON_DIR/waterfox.svg" "Waterfox" "waterfox" \\
    "\$ICON_DIR/zen.svg" "Zen Browser" "zen-browser" \\
    --window-icon="\$ICON_DIR/web-browser.svg" \\
    --width=600 --height=490 --button="Instalar":0 --button="Cancelar":1)
if [[ \$? -ne 0 || -z "\$browser" ]]; then
    yad --error --text="Nothing selected..."
    exit 1
fi
browser=\$(echo "\$browser" | awk -F'|' '{print \$3}')
yad --question --text="Install \$browser?" --window-icon="\$ICON_DIR/web-browser.svg"
if [[ \$? -eq 0 ]]; then
    install "\$browser" && yad --info --text="\$browser installed!" ||
    yad --error --text="Error."
else
    yad --info --text="Canceled."
fi
pin "\$browser"
EOF
chmod +x /usr/local/bin/browser-installer
cat <<EOF |tee /usr/local/share/applications/browser-installer.desktop
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon=web-browser
Name=Web browser
Name[pt_BR]=Navegador web
Comment=Choose your favorite browser
Comment[pt_BR]=Escolha seu navegador favorito
Categories=Internet;
Exec=x-terminal-emulator -e /usr/local/bin/browser-installer
EOF
cat <<EOF |tee /etc/profile.d/rdx-user-settings.sh /etc/X11/Xsession.d/90-rdx-user-settings>/dev/null
if ! [ -f "\$HOME"/.rdx-user-settings ];then
    mkdir -p "\$HOME"/.config/onlyoffice
    mkdir -p "\$HOME"/.config/systemd/user
    mkdir -p "\$HOME"/.local/share/applications
    #bash
    mkdir -p "\$HOME"/.bashrc.d
    cp /etc/skel/.bashrc "\$HOME"/.bashrc.d/rc.bash
    cp /opt/rdx-user-settings/bash/bashrc "\$HOME"/.bashrc
    cp /opt/rdx-user-settings/bash/*.bash "\$HOME"/.bashrc.d/
    cp /opt/rdx-user-settings/bash/*.sh "\$HOME"/.bashrc.d/
    cp /usr/share/liquidprompt/liquidpromptrc-dist "\$HOME"/.config/liquidpromptrc
    sed -i 's|debian.theme|powerline.theme|' "\$HOME"/.config/liquidpromptrc
    #dconf
    dconf load / < /opt/rdx-user-settings/dconf-settings.ini
    #gnome-shell-extensions
    cp -r /opt/rdx-user-settings/gnome-shell "\$HOME"/.local/share/
    #onlyoffice
    cp /opt/rdx-user-settings/onlyoffice-desktopeditors.conf "\$HOME"/.config/onlyoffice/DesktopEditors.conf
    #pipewire/pulseaudio
    systemctl stop --user --now pipewire.service
    systemctl stop --user --now pipewire.socket
    systemctl mask --user pipewire.service
    systemctl mask --user pipewire.socket
    #walc
    ln -fs /dev/null "\$HOME"/.local/share/applications/WALC.desktop
    #topgrade
    cp /opt/rdx-user-settings/topgrade-config.toml "\$HOME"/.config/topgrade.toml
    mkdir -p "\$HOME"/.local/bin
    #xdg-mime
    xdg-mime default gnome-software-local-file-packagekit.desktop application/vnd.debian.binary-package
    xdg-mime default nemo.desktop inode/directory
    touch "\$HOME"/.rdx-user-settings
fi
EOF
cat <<EOF |tee /etc/polkit-1/localauthority/50-local.d/50-udisks.pkla
[Allow local mount without password]
Identity=unix-group:sudo;unix-group:plugdev
Action=org.freedesktop.udisks*
ResultActive=yes
EOF
cat <<EOF |tee /etc/environment.d/90-qt-qpa-platformtheme.conf /etc/profile.d/qt-qpa-platformtheme.sh /etc/X11/Xsession.d/90-qt-qpa-platformtheme>/dev/null
export QT_QPA_PLATFORMTHEME=gtk2
EOF
cat <<EOF |tee /etc/rc.local>/dev/null
#!/bin/bash
set -e
chown -R "\$(ls /home)"\
    /opt/am\
    /opt/appimagepool\
    /opt/bat\
    /opt/casterr\
    /opt/chat-gpt\
    /opt/everdo\
    /opt/fd\
    /opt/freetube\
    /opt/got\
    /opt/mission-center\
    /opt/muffon\
    /opt/nyrna\
    /opt/onlyoffice\
    /opt/rustdesk\
    /opt/squirrel-disk\
    /opt/stretchly\
    /opt/topgrade\
    /opt/walc
rm /etc/rc.local
EOF
chmod +x /etc/rc.local
cat <<EOF |tee /usr/local/bin/reset-user-settings>/dev/null
rm -r "\$HOME"/.rdx-user-settings "\$HOME"/.local/share/gnome-shell
shutdown -r 0
EOF
chmod +x /usr/local/bin/reset-user-settings