#!/bin/bash
set -e
am -i casterr
sed -i 's|StartupWMClass=Casterr|StartupWMClass=casterr|' /usr/local/share/applications/casterr-AM.desktop