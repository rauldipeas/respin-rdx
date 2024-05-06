#!/bin/bash
set -e

if  grep ii <(dpkg --list python3-tk 2>/dev/null);then
    echo python3-tk instalado!
    else
    sudo apt install -y python3-tk
fi
if [ -f $HOME/.local/bin/rtcqs_gui ] && [ -f $HOME/.local/share/applications/rtcqs.desktop ] && [ -f $HOME/.local/share/icons/rtcqs.svg ];then
    echo rtcqs instalado!
    else
    pipx install rtcqs
    mkdir -p "$HOME"/.local/share/{applications,icons}
    wget -qO "$HOME"/.local/share/applications/rtcqs.desktop https://github.com/autostatic/rtcqs/raw/main/rtcqs.desktop
    sed -i "s@Exec=rtcqs_gui@Exec=$HOME/.local/bin/rtcqs_gui@g" "$HOME"/.local/share/applications/rtcqs.desktop
    wget -qO "$HOME"/.local/share/icons/rtcqs.svg https://github.com/autostatic/rtcqs/raw/main/rtcqs_logo.svg
fi
## Configuração
if grep audio <(groups "$USER");then
    echo "$USER" adicionado ao grupo audio!
    else
    sudo usermod -aG audio "$USER"
fi
if [ -f /etc/sysctl.d/swappiness.conf ];then
    echo swappiness configurado!
    else
    cat <<EOF |sudo tee /etc/sysctl.d/swappiness.conf>/dev/null
vm.swappiness = 10
EOF
fi
if [ -f /etc/default/grub.d/rtcqs.cfg ];then
    echo grub configurado!
    else
    if [ -f /etc/default/grub.d/zswap.cfg ];then
        sudo rm /etc/default/grub.d/zswap.cfg
        cat <<EOF |sudo tee /etc/default/grub.d/rtcqs.cfg>/dev/null
GRUB_CMDLINE_LINUX_DEFAULT="cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs zswap.enabled=1 zswap.compressor=lz4"
EOF
        sudo update-grub
        else
        cat <<EOF |sudo tee /etc/default/grub.d/rtcqs.cfg>/dev/null
GRUB_CMDLINE_LINUX_DEFAULT="cpufreq.default_governor=performance mitigations=off preempt=full quiet splash threadirqs"
EOF
        sudo update-grub
    fi
fi
if [ -f /etc/udev/rules.d/99-cpu-dma-latency.rules ];then
    echo cpu-dma-latency configurado!
    else
    sudo wget -qO /etc/udev/rules.d/99-cpu-dma-latency.rules https://raw.githubusercontent.com/Ardour/ardour/master/tools/udev/99-cpu-dma-latency.rules
fi