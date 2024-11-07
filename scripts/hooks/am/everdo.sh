#!/bin/bash
set -e
am -i --icons everdo
sed -i 's|StartupWMClass=Everdo|StartupWMClass=everdo|' /usr/local/share/applications/everdo-AM.desktop