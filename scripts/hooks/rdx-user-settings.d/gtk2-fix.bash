#!/bin/bash
set -e
sudo sd 'Exec=' 'Exec=GTK2_RC_FILE=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc ' "$@"