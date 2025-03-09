#!/bin/bash
set -e
am -i --icons mission-center
sed -i 's|Icon=missioncenter|Icon=io.missioncenter.MissionCenter|' /usr/local/share/applications/mission-center-AM.desktop
cat <<EOF |tee -a /usr/local/share/applications/mission-center-AM.desktop
StartupWMClass=missioncenter
EOF