#!/bin/bash
set -e
am -i chat-gpt
cat <<EOF |tee -a /usr/local/share/applications/chat-gpt-AM.desktop
StartupWMClass=chat-gpt
EOF