#!/bin/bash
set -e

# Thunderbird
apt autoremove --purge -y *thunderbird*
wget -qO thunderbird-latest-linux64-pt-br.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=pt-BR"
tar xjf thunderbird-latest-linux64-pt-br.tar.bz2
mkdir -p /opt/thunderbird
chmod 777 -R /opt/thunderbird
mv thunderbird/* /opt/thunderbird/
rm -r thunderbird thunderbird-latest-linux64-pt-br.tar.bz2
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