#!/bin/bash
set -e

# Internet Archive upload
wget -q --show-progress https://archive.org/download/ia-pex/ia
chmod +x ./ia
cat <<EOF |tee ./ia.ini #>/dev/null
[s3]
access = "$IA_ACCESS"
secret = "$IA_SECRET"

[cookies]
logged-in-user = "$IA_LOGGED_IN_USER"
logged-in-sig = "$IA_LOGGED_IN_SIG"

[general]
screenname = Raul Dipeas
EOF
./ia -c ./ia.ini upload "$ISO_NAME"-respin-rdx /home/runner/work/respin-rdx/"$ISO_NAME"-respin-rdx.iso