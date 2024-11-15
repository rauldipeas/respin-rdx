#!/bin/bash
set -e
ICON_DIR="/usr/share/icons/Papirus/128x128/apps"
install() {
    case $1 in
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
        yandex-browser) am -i --icons yandex-browser ;;
        zen-browser) am -i --icons zen-browser ;;
        *) echo "Invalid" ;;
    esac
}
pin() {
    gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps|sed s/browser-installer/$(fd $1 /usr/share /usr/local/share|grep .desktop$|sed s/.*$1/$1/|sed s/.desktop//)/)"
}
browser=$(yad --list --title="Browser installer" --text="Choose the browser to install:" \
    --column="Icon:IMG" --column="Browser" --column="package" \
    "$ICON_DIR/brave.svg" "Brave" "brave-browser" \
    "$ICON_DIR/chromium.svg" "Chromium" "chromium" \
    "$ICON_DIR/org.gnome.Epiphany.svg" "GNOME Web" "org.gnome.Epiphany" \
    "$ICON_DIR/firefox.svg" "Firefox" "firefox" \
    "$ICON_DIR/falkon.svg" "Falkon" "org.kde.falkon" \
    "$ICON_DIR/google-chrome.svg" "Google Chrome" "google-chrome" \
    "$ICON_DIR/librewolf.svg" "Librewolf" "librewolf" \
    "$ICON_DIR/web-browser.svg" "Mercury" "mercury" \
    "$ICON_DIR/mullvad-browser.svg" "Mullvad" "mullvad-browser" \
    "$ICON_DIR/com.github.Eloston.UngoogledChromium.svg" "Ungoogled Chromium" "ungoogled-chromium" \
    "$ICON_DIR/opera.svg" "Opera" "opera" \
    "$ICON_DIR/palemoon.svg" "Palemoon" "palemoon" \
    "$ICON_DIR/tor-browser.svg" "Tor Browser" "tor-browser" \
    "$ICON_DIR/vivaldi.svg" "Vivaldi" "vivaldi-stable" \
    "$ICON_DIR/waterfox.svg" "Waterfox" "waterfox" \
    "$ICON_DIR/yandex-browser.svg" "Yandex Browser" "yandex-browser" \
    "$ICON_DIR/web-browser.svg" "Zen Browser" "zen-browser" \
    --window-icon="$ICON_DIR/web-browser.svg" \
    --width=600 \
    --height=490 \
    --button="Instalar":0 \
    --button="Cancelar":1)
if [[ $? -ne 0 || -z "$browser" ]]; then
    yad --error --text="Nothing selected..."
    exit 1
fi
browser=$(echo "$browser" | awk -F'|' '{print $3}')
yad --question --text="Install $browser?" --window-icon="$ICON_DIR/web-browser.svg"
if [[ $? -eq 0 ]]; then
    install "$browser" && yad --info --text="$browser installed!" ||
    yad --error --text="Error."
else
    yad --info --text="Canceled."
fi
pin "$browser"