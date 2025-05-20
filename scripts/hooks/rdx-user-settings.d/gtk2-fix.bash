#!/bin/bash
set -e
if grep -q GTK2_RC_FILES "$@";then
    echo 'Already fixed'
    else
    sudo sd 'Exec=' "Exec=bash -c 'GTK2_RC_FILES=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc '" "$@"
    echo 'Fixed now'
fi