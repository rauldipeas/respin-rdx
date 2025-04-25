#!/bin/bash
set -e
wget -q --show-progress -O /tmp/genymotion.run "$(wget -qO- https://www.genymotion.com/download|grep linux_x64.run|head -n 1|cut -d '"' -f4)"
chmod +x /tmp/genymotion.run
/tmp/genymotion.run -y
rm /tmp/genymotion.run
sed -i 's|Icon=|#Icon=|' /usr/local/share/applications/genymobile-genymotion.desktop
cat <<EOF |tee -a /usr/local/share/applications/genymobile-genymotion.desktop
Icon=genymotion
StartupWMClass=genymotion
EOF