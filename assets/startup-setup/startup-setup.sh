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
if

# cleanup
if [[ -f /home/linuxbrew/.linuxbrew/bin/brew && -f /home/linuxbrew/.linuxbrew/bin/topgrade && -f /opt/pipx/bin/rtcqs ]];then
    rm "$HOME"/.config/autostart/startup-setup.*
    notify-send -a 'Respin RDX' -i 'xfce4-fsguard-plugin-warning' -u critical 'Por favor, reinicie a sessão' 'A configuração incial do Respin RDX está concluída'
    else
    notify-send -a 'Respin RDX' -i 'xfce4-fsguard-plugin-warning' -u critical 'Por favor, reinicie a sessão' 'Houve um problema com a configuração inicial do Respin RDX, por favor, certifique-se de estar conectado a internet e reinicie a sessão'
fi
sleep 10