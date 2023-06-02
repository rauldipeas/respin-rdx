#!bin/bash
set -e

# Keybase
wget -qO- https://keybase.io/docs/server_security/code_signing_key.asc|gpg --dearmor -o /etc/apt/trusted.gpg.d/keybase-keyring.gpg
echo 'deb http://prerelease.keybase.io/deb stable main'|tee /etc/apt/sources.list.d/keybase.list>/dev/null
apt update
apt install -y inotify-tools keybase
mkdir -p /etc/skel/Sync /etc/xdg/autostart
cat <<EOF |tee /usr/local/bin/keybase-rsync>/dev/null
#!/bin/bash
set -e
if [ "\$(pgrep -l keybase|cut -d ' ' -f2|head -n1)" == keybase ];then
    if [ -d /keybase/private/"\$(fd . /keybase/private/|cut -d '/' -f4)" ];then
        rsync -rvz --delete "\$HOME"/Sync /keybase/private/"\$(fd . /keybase/private/|cut -d '/' -f4)"
        while inotifywait -r -e modify,create,delete,move "\$HOME"/Sync; do
            rsync -rvz --delete "\$HOME"/Sync /keybase/private/"\$(fd . /keybase/private/|cut -d '/' -f4)"
        done
    fi
fi
EOF
chmod +x /usr/local/bin/keybase-rsync
cat <<EOF |tee /etc/xdg/autostart/keybase-rsync.desktop
[Desktop Entry]
Name=Keybase Rsync
Type=Application
Exec=keybase-rsync
Icon=keybase-update
EOF