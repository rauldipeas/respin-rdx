if ! [ -f "$HOME"/.rdx-user-settings ];then
    mkdir -p "$HOME"/.config/onlyoffice
    mkdir -p "$HOME"/.config/systemd/user
    mkdir -p "$HOME"/.local/share/applications
    #bash
    mkdir -p "$HOME"/.bashrc.d
    cp /etc/skel/.bashrc "$HOME"/.bashrc.d/rc.bash
    cp /opt/rdx-user-settings/bash/bashrc "$HOME"/.bashrc
    cp /opt/rdx-user-settings/bash/*.bash "$HOME"/.bashrc.d/
    cp /opt/rdx-user-settings/bash/*.sh "$HOME"/.bashrc.d/
    cp /usr/share/liquidprompt/liquidpromptrc-dist "$HOME"/.config/liquidpromptrc
    sed -i 's|debian.theme|powerline.theme|' "$HOME"/.config/liquidpromptrc
    #dconf
    if [ "$(xrandr --query|grep -c ' connected')" -eq 1 ]; then
        dconf load / < /opt/rdx-user-settings/dconf-settings.ini
        else
        sed 's|{"0":|{"1":|' /opt/rdx-user-settings/dconf-settings.ini|dconf load /
    fi
    #gnome-shell-extensions
    cp -r /opt/rdx-user-settings/gnome-shell "$HOME"/.local/share/
    #onlyoffice
    cp /opt/rdx-user-settings/onlyoffice-desktopeditors.conf "$HOME"/.config/onlyoffice/DesktopEditors.conf
    #pipewire/pulseaudio
    systemctl stop --user --now pipewire.service
    systemctl stop --user --now pipewire.socket
    systemctl mask --user pipewire.service
    systemctl mask --user pipewire.socket
    #walc
    ln -fs /dev/null "$HOME"/.local/share/applications/WALC.desktop
    #topgrade
    cp /opt/rdx-user-settings/topgrade-config.toml "$HOME"/.config/topgrade.toml
    mkdir -p "$HOME"/.local/bin
    #xdg-mime
    xdg-mime default gnome-software-local-file-packagekit.desktop application/vnd.debian.binary-package
    xdg-mime default nemo.desktop inode/directory
    #xfce
    cp -r /opt/rdx-user-settings/xfce/volumeicon "$HOME"/.config/volumeicon
    cp -r /opt/rdx-user-settings/xfce/xfce4 "$HOME"/.config/xfce4
    touch "$HOME"/.rdx-user-settings
fi