#!/bin/bash
set -e
chown -R "$(ls /home)"\
    /opt/am\
    /opt/appimagepool\
    /opt/bat\
    /opt/casterr\
    /opt/chat-gpt\
    /opt/everdo\
    /opt/fd\
    /opt/freetube\
    /opt/got\
    /opt/mission-center\
    /opt/muffon\
    /opt/nyrna\
    /opt/onlyoffice\
    /opt/rustdesk\
    /opt/squirrel-disk\
    /opt/stretchly\
    /opt/topgrade\
    /opt/walc
rm /etc/rc.local