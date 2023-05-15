#!/bin/bash
set -e

# Thunderbird
apt autoremove --purge -y *thunderbird*
wget -q --show-progress -O thunderbird-latest-linux64-pt-br.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=pt-BR"
tar fjx thunderbird-latest-linux64-pt-br.tar.bz2
mkdir -p /opt/thunderbird
chmod 777 -R /opt/thunderbird
mv thunderbird/* /opt/thunderbird/
mkdir -p /usr/local/bin /usr/local/share/applications /usr/local/share/pixmaps
ln -fs /opt/thunderbird/thunderbird /usr/local/bin/thunderbird
ln -fs /opt/thunderbird/chrome/icons/default/default128.png /usr/local/share/pixmaps/thunderbird.png
cat <<EOF |tee /usr/local/share/applications/thunderbird.desktop>/dev/null
[Desktop Entry]
Encoding=UTF-8
Name=Thunderbird
Comment=Envie e receba e-mails com o Thunderbird
GenericName=Cliente de e-mail
Keywords=Email;E-mail;Newsgroup;Feed;RSS
Exec=thunderbird %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=thunderbird
Categories=Application;Network;Email;
MimeType=x-scheme-handler/mailto;application/x-xpinstall;
StartupNotify=true
Actions=Compose;Contacts

[Desktop Action Compose]
Name=Compor uma nova mensagem
Exec=thunderbird -compose

[Desktop Action Contacts]
Name=Contatos
Exec=thunderbird -addressbook
EOF

# Birdtray
wget -q --show-progress https://ppa.launchpadcontent.net/linuxuprising/ppa/ubuntu/pool/main/b/birdtray/$(wget -qO- https://ppa.launchpadcontent.net/linuxuprising/ppa/ubuntu/pool/main/b/birdtray/|grep jammy|grep amd64.deb|cut -d '"' -f8|tail -n1)
dpkg-deb -x birdtray*.deb birdtray
cp birdtray/usr/bin/birdtray /opt/thunderbird/
ln -fs /opt/thunderbird/birdtray /usr/local/bin/birdtray
cp birdtray/usr/share/applications/com.ulduzsoft.Birdtray.desktop /usr/local/share/applications/
cp -r birdtray/usr/share/icons /usr/loca/share/
cp -r birdtray/usr/share/ulduzsoft /usr/local/share/