#!/bin/bash
set -e
chown -R "$(ls /home)"\
    /opt/am\
    /opt/appimagepool\
    /opt/bat\
    /opt/casterr\
    /opt/chat-gpt\
    /opt/cryptomator\
    /opt/fd\
    /opt/freetube\
    /opt/got\
    /opt/lunatask\
    /opt/mission-center\
    /opt/muffon\
    /opt/nyrna\
    /opt/onlyoffice\
    /opt/rclone\
    /opt/rclone-browser\
    /opt/squirrel-disk\
    /opt/stretchly\
    /opt/topgrade\
    /opt/walc
rm /etc/rc.local