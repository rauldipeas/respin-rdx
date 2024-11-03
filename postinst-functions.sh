#!/bin/bash
set -e
amaddclass() {
    local file="/usr/local/share/applications/$1-AM.desktop"
    local class="$2"
    echo "StartupWMClass=$class"|sudo tee -a "$file">/dev/null
}

aminst() {
    am -i "$@"
    am icons --all
}

changeicon() {
    local file="/usr/share/applications/$1.desktop"
    local newicon="$2"
    sudo sd "^Icon=.*" "Icon=$newicon" "$file"
}

nalainst() {
    sudo nala install -y "$@"
}