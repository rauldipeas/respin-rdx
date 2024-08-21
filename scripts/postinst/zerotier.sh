#!/bin/bash
set -e

## ZeroTier
if  grep ii <(dpkg --list zerotier-one 2>/dev/null);then
    echo zerotier-one instalado!
    else
    curl -s https://install.zerotier.com | sudo bash
fi