#!/bin/bash
set -e

# Ubuntu extra repo
add-apt-repository -ny multiverse
add-apt-repository -ny universe

# Raul Dipeas apt repository
bash -x <(wget -qO- https://raw.githubusercontent.com/rauldipeas/apt-repository/main/apt-repository.sh)

# System update
apt update
export DEBIAN_FRONTEND=noninteractive
if [ -f /usr/share/xsessions/xubuntu.desktop ]; then
    apt autoremove --purge -y chromium-browser
fi
apt dist-upgrade -y -o Dpkg::Options::="--force-confdef" --force-yes

# deb-get
#apt install -y deb-get

# Pacstall
apt install -y pacstall

# Respin RDX scripts
mkdir -p /usr/local/bin
cat <<EOF |tee /usr/local/bin/get-respin-rdx
#!/bin/bash
set -e
bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/get-respin-rdx.sh) "\$1"
EOF
chmod +x /usr/local/bin/get-respin-rdx
#cat <<EOF |tee /usr/local/bin/upgrade-respin-rdx
##!/bin/bash
#set -e
#bash <(wget -qO- https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/upgrade-respin-rdx.sh)
#EOF
#chmod +x /usr/local/bin/upgrade-respin-rdx

# topgrade
apt install -y aptitude
mkdir -p /etc/skel/.config
wget -q --show-progress -O /etc/skel/.config/topgrade.toml https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/topgrade/topgrade.toml
cat <<EOF |tee /usr/local/bin/pkcon-update
#!/bin/bash
set -e
if [ -f /usr/bin/pkcon ];then
        if [ -f /usr/bin/aptitude ];then
                if [ "$(aptitude search '~U')" ];then
                        sudo pkcon update -y
                        else
                        echo 'Atualização concluída com sucesso!'
                fi
                else
                echo 'aptitude não encontrado'
        fi
        else
        echo 'pkcon não encontrado'
fi
EOF
chmod +x /usr/local/bin/pkcon-update

# Incialização
mkdir -p /usr/local/bin
cat <<EOF |tee /usr/local/bin/startup-setup
kitty -- bash "\$HOME"/.config/autostart/startup-setup.sh
EOF
chmod +x /usr/local/bin/startup-setup
mkdir -p /etc/skel/.config/autostart
cat <<EOF |tee /etc/skel/.config/autostart/startup-setup.desktop
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Exec=startup-setup
Name=Inicialização
EOF
wget -q --show-progress -O /etc/skel/.config/autostart/startup-setup.sh https://raw.githubusercontent.com/rauldipeas/respin-rdx/main/assets/startup-setup.sh
cat <<EOF |tee /etc/X11/Xsession.d/99linuxbrew
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ];then
        eval "\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
EOF