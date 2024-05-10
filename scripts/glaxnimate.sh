#!/bin/bash
set -e

## Glaxnimate (snap)
if grep glaxnimate <(snap list 2>/dev/null);then
    echo glaxnimate instalado!
    else
    sudo snap install glaxnimate
fi

#rm -f glaxnimate*.deb>/dev/null
#wget -q --show-progress -O glaxnimate-amd64.deb "https://gitlab.com/api/v4/projects/19921167/jobs/artifacts/release/raw/build/glaxnimate.deb?job=linux%3Adeb"
#sudo apt install -y ./glaxnimate*.deb
#rm glaxnimate*.deb