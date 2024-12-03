#!/bin/bash
set -e
sudo sd 'Exec=' "Exec=bash -c 'GTK2_RC_FILES=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc '" "$@"