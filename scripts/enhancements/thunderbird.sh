#!/bin/bash
set -e

# Thunderbird
apt autoremove --purge -y *thunderbird*
wget -cq --show-progress -O thunderbird-latest-linux64-pt-br.tar.bz2 "$(wget -qO- https://www.thunderbird.net/pt-BR/|grep linux64|cut -d '"' -f2|head -n1)"
tar fjx thunderbird-latest-linux64-pt-br.tar.bz2
mkdir -p /opt/thunderbird
chmod 777 /opt/thunderbird
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
Exec=thunderbird-kdocker %u
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=thunderbird
Categories=Application;Network;Email;
MimeType=x-scheme-handler/mailto;application/x-xpinstall;
StartupNotify=true
Actions=Compose

[Desktop Action Compose]
Name=Compor uma nova mensagem
Exec=thunderbird -compose
EOF

# KDocker
if [ -f /Ubuntu ];then
	cat <<EOF |tee /opt/thunderbird/thunderbird-kdocker>/dev/null
#!/bin/bash
set -e
if [ "\$(pgrep -l thunderbird-bin|cut -d ' ' -f2)" == thunderbird-bin ]; then
	thunderbird
else
	kdocker -i /usr/share/icons/Papirus/16x16/panel/thunderbird-panel.svg -d15 -mq thunderbird
fi
EOF
	chmod +x /opt/thunderbird/thunderbird-kdocker
	ln -fs /opt/thunderbird/thunderbird-kdocker /usr/local/bin/thunderbird-kdocker
	elif [ -f /UCL ];then
		cat <<EOF |tee /opt/thunderbird/thunderbird-kdocker>/dev/null
#!/bin/bash
set -e
if [ "\$(pgrep -l thunderbird-bin|cut -d ' ' -f2)" == thunderbird-bin ]; then
	thunderbird
else
	kdocker -i /usr/share/icons/Papirus/24x24/panel/thunderbird-panel.svg -d15 -mq thunderbird
fi
EOF
	chmod +x /opt/thunderbird/thunderbird-kdocker
	ln -fs /opt/thunderbird/thunderbird-kdocker /usr/local/bin/thunderbird-kdocker
	elif [ -f /UGL ];then
		cat <<EOF |tee /opt/thunderbird/thunderbird-kdocker>/dev/null
#!/bin/bash
set -e
if [ "\$(pgrep -l thunderbird-bin|cut -d ' ' -f2)" == thunderbird-bin ]; then
	thunderbird
else
	kdocker -i /usr/share/icons/Papirus/16x16/panel/thunderbird-panel.svg -d15 -mq thunderbird
fi
EOF
	chmod +x /opt/thunderbird/thunderbird-kdocker
	ln -fs /opt/thunderbird/thunderbird-kdocker /usr/local/bin/thunderbird-kdocker
	else
	cat <<EOF |tee /opt/thunderbird/thunderbird-kdocker>/dev/null
#!/bin/bash
set -e
if [ "\$(pgrep -l thunderbird-bin|cut -d ' ' -f2)" == thunderbird-bin ]; then
	thunderbird
else
	kdocker -i /usr/share/icons/Papirus/22x22/panel/thunderbird-panel.svg -d15 -mq thunderbird
fi
EOF
	chmod +x /opt/thunderbird/thunderbird-kdocker
	ln -fs /opt/thunderbird/thunderbird-kdocker /usr/local/bin/thunderbird-kdocker
fi