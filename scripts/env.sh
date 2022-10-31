#!/bin/bash
set -e
sudo apt autoremove --purge -y\
    azure-cli\
    '^dotnet-.*'\
    firefox\
    google-chrome-stable\
    google-cloud-sdk\
    '^llvm-.*'\
    powershell\
    snapd
sudo apt clean
sudo swapoff -a
sudo rm -r\
    "$AGENT_TOOLSDIRECTORY"\
    /opt/az\
    /swapfile\
    /usr/share/dotnet\
    /usr/local/share/boost