#!/bin/bash
set -e

## OpenSSH SFTP server
if  grep ii <(dpkg --list openssh-sftp-server 2>/dev/null);then
    echo openssh-sftp-server instalado!
    else
    sudo apt install -y openssh-sftp-server
fi