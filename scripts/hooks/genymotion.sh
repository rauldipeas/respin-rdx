#!/bin/bash
set -e
wget -q --show-progress -O /tmp/genymotion.bin "$(wget -qO- https://www.genymotion.com/download|grep linux_x64.bin|head -n 1|cut -d '"' -f4)"
chmod +x /tmp/genymotion.bin
/tmp/genymotion.bin -y
rm /tmp/genymotion.bin
sed -i 's|Icon=|#Icon=|' /usr/local/share/applications/genymobile-genymotion.desktop
cat <<EOF |tee -a /usr/local/share/applications/genymobile-genymotion.desktop
Icon=genymotion
StartupWMClass=genymotion
EOF