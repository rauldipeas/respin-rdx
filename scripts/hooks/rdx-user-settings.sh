#!/bin/bash
set -e
mkdir -p /opt/rdx-user-settings/bash
wget -qO /opt/rdx-user-settings/bash/bashrc https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/bashrc
wget -qO /opt/rdx-user-settings/bash/bash-preexec.sh https://github.com/rcaloras/bash-preexec/raw/master/bash-preexec.sh
wget -qO /opt/rdx-user-settings/bash/atuin.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/atuin.bash
wget -qO /opt/rdx-user-settings/bash/liquidprompt.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/liquidprompt.bash
wget -qO /opt/rdx-user-settings/bash/local-bin.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/local-bin.bash
#wget -qO /opt/rdx-user-settings/bash/powerline.bash https://github.com/rauldipeas/respin-rdx/raw/main/settings/bash/powerline.bash
wget -qO /opt/rdx-user-settings/dconf-settings.ini https://github.com/rauldipeas/respin-rdx/raw/main/settings/dconf-settings.ini
wget -qO /opt/rdx-user-settings/onlyoffice-desktopeditors.conf https://github.com/rauldipeas/respin-rdx/raw/main/settings/onlyoffice-desktopeditors.conf
wget -qO /opt/rdx-user-settings/adaptive.xml https://github.com/rauldipeas/respin-rdx/raw/main/settings/adaptive.xml
mkdir -p /usr/local/share/gtksourceview-4/styles/
cp /opt/rdx-user-settings/adaptive.xml /usr/local/share/gtksourceview-4/styles/adaptive.xml
wget -qO /opt/rdx-user-settings/topgrade-config.toml https://github.com/topgrade-rs/topgrade/raw/main/config.example.toml
sed -i 's|# no_self_update|no_self_update|' /opt/rdx-user-settings/topgrade-config.toml
sed -i 's|\[deno\]|#\[deno\]|' /opt/rdx-user-settings/topgrade-config.toml
wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/tribler.desktop|tee -a /usr/share/applications/org.tribler.Tribler.desktop>/dev/null
wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/yad.desktop|tee -a /usr/share/applications/yad-icon-browser.desktop>/dev/null
wget -qO /usr/local/share/applications/respinrdx.featurebase.app.desktop https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/featurebase.desktop
wget -qO /usr/local/share/applications/browser-installer.desktop https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/browser-installer.desktop
wget -qO /usr/local/bin/browser-installer https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/browser-installer.bash
chmod +x /usr/local/bin/browser-installer
wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/rdx-user-settings.bash|tee /etc/profile.d/rdx-user-settings.sh /etc/X11/Xsession.d/90-rdx-user-settings>/dev/null
wget -qO /etc/polkit-1/localauthority/50-local.d/50-udisks.pkla https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/udisks.pkla
wget -qO- https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/qt-qpa-platformtheme.bash|tee /etc/environment.d/90-qt-qpa-platformtheme.conf /etc/profile.d/qt-qpa-platformtheme.sh /etc/X11/Xsession.d/90-qt-qpa-platformtheme>/dev/null
wget -qO /etc/rc.local https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/rc.bash
chmod +x /etc/rc.local
wget -qO /usr/local/bin/reset-user-settings https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/reset-user-settings.bash
chmod +x /usr/local/bin/reset-user-settings
wget -qO /usr/local/bin/gtk2-fix https://github.com/rauldipeas/respin-rdx/raw/main/scripts/hooks/rdx-user-settings.d/gtk2-fix.bash
chmod +x /usr/local/bin/gtk2-fix