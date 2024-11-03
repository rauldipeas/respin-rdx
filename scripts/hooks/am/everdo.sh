#!/bin/bash
set -e
am -i everdo
echo y|am icons everdo
sed -i 's|StartupWMClass=Everdo|StartupWMClass=everdo|' /usr/local/share/applications/everdo-AM.desktop