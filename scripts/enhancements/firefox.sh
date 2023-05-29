#!/bin/bash
set -e

# Firefox
apt autoremove --purge -y *firefox* snapd
wget -q --show-progress -O firefox-latest-linux64-pt-br.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=pt-BR"
tar fjx firefox-latest-linux64-pt-br.tar.bz2
mkdir -p /opt/firefox
chmod 777 -R /opt/firefox
mv firefox/* /opt/firefox/
mkdir -p /usr/local/bin /usr/local/share/applications /usr/local/share/pixmaps
ln -fs /opt/firefox/firefox /usr/local/bin/firefox
ln -fs /opt/firefox/browser/chrome/icons/default/default128.png /usr/local/share/pixmaps/firefox.png
cat <<EOF |tee /opt/firefox/defaults/pref/csd.js>/dev/null
pref("browser.tabs.inTitlebar", 1);
EOF
cat <<EOF |tee /usr/local/share/applications/firefox.desktop>/dev/null
[Desktop Entry]
Version=1.0
Name=Firefox
Comment=Navegue na internet
GenericName=Navegador de internet
Keywords=Internet;WWW;Browser;Web;Explorer
Exec=MOZ_USE_XINPUT2=1 firefox %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;
StartupNotify=true

Actions=new-window;new-private-window;

[Desktop Action new-window]
Name=Abrir uma nova janela
Exec=firefox -new-window

[Desktop Action new-private-window]
Name=Abrir uma nova janela no modo privado
Exec=firefox -private-window
EOF
#if [ -f /usr/share/xsessions/plasma.desktop ]; then
#    cat <<EOF |tee /opt/firefox/defaults/pref/apturl.js
#pref("network.protocol-handler.app.apt","/usr/local/bin/qapt-apturl-installer.sh");
#pref("network.protocol-handler.warn-external.apt",false);
#pref("network.protocol-handler.app.apt+http","/usr/local/bin/qapt-apturl-installer.sh");
#pref("network.protocol-handler.warn-external.apt+http",false);
#pref("network.protocol-handler.external.apt",true);
#pref("network.protocol-handler.external.apt+http",true);
#EOF
#fi