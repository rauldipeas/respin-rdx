#!/bin/bash
set -e

# Environment setup
sudo apt autoremove --purge -y\
    azure-cli\
    "^dotnet-.*"\
    firefox\
    google-chrome-stable\
    "^llvm-.*"\
    powershell\
    snapd
    #google-cloud-sdk\
sudo apt clean
sudo swapoff -a
sudo rm -r\
    "$AGENT_TOOLSDIRECTORY"\
    /opt/az\
    /usr/share/dotnet