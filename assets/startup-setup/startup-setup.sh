#!/bin/bash
set -e

# pipx/rtcqs
if [ -f /opt/pipx/bin/rtcqs ];then
    echo 'rtcqs instalado'
    else
    echo 'Instalando o rtcqs...'
    export PIPX_HOME='/opt/pipx'
    export PIPX_BIN_DIR='/opt/pipx/bin'
    pipx install rtcqs
    if [ -f /opt/pipx/bin/rtcqs ];then
        echo 'Instalação do rtcqs concluída com sucesso!'
        else
        echo 'Houve um problema com a instalação do rtcqs'
    fi
fi

# pipx/spotdl
if [ -f /usr/bin/4kvideodownloader ];then
    if [ -f /opt/pipx/bin/spotdl ];then
        echo 'SpotDL instalado'
        else
        echo 'Instalando o SpotDL...'
        export PIPX_HOME='/opt/pipx'
        export PIPX_BIN_DIR='/opt/pipx/bin'
        pipx install spotdl
        mkdir -p "$HOME"/.local/share/applications
        cat <<EOF |tee "$HOME"/.local/share/applications/spotdl.desktop
[Desktop Entry]
Type=Application
Name=SpotDL
Icon=wihotspot
NoDisplay=false
Exec=spotdl web
Terminal=false
X-GNOME-UsesNotifications=true
EOF
        if [ -f /opt/pipx/bin/spotdl && -f "$HOME"/.local/share/applications/spotdl.desktop ];then
            echo 'Instalação do SpotDL concluída com sucesso!'
            else
            echo 'Houve um problema com a instalação do SpotDL'
        fi
    fi
fi

# LinuxBrew/Topgrade
if [ -f /home/linuxbrew/.linuxbrew/bin/topgrade ];then
	echo 'Topgrade instalado'
	else
	if [ -f /home/linuxbrew/.linuxbrew/bin/brew ];then
	    echo 'LinuxBrew instalado'
	    else
	    echo 'Instalando o LinuxBrew...'
	    NONINTERACTIVE=1 /bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	    if [ -f /home/linuxbrew/.linuxbrew/bin/brew ];then
		    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            echo 'Instalado o Topgrade...'
		    brew install topgrade
		    if [ -f /home/linuxbrew/.linuxbrew/bin/topgrade ];then
	        	echo 'Instalação do Topgrade concluída com sucesso!'
	        	else
	        	echo 'Houve um problema com a instalação do Topgrade'
	        fi
	    	else
	    	echo 'Houve um problema com a instalação do LinuxBrew'
	    fi
	fi
fi

# cleanup
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew && -f /home/linuxbrew/.linuxbrew/bin/topgrade && -f /opt/pipx/bin/rtcqs ]];then
    rm "$HOME"/.config/autostart/startup-setup.*
    notify-send -a 'Respin RDX' -i 'xfce4-fsguard-plugin-warning' -u critical 'Por favor, reinicie a sessão' 'A configuração incial do Respin RDX está concluída'
    else
    notify-send -a 'Respin RDX' -i 'xfce4-fsguard-plugin-warning' -u critical 'Por favor, reinicie a sessão' 'Houve um problema com a configuração inicial do Respin RDX, por favor, certifique-se de estar conectado a internet e reinicie a sessão'
fi
sleep 10