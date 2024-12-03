#!/bin/bash
set -e
cat <<EOF |tee /etc/apt/apt.conf.d/100launchers-fix
DPkg::Post-Invoke {
"launchers-fix"
};
EOF
cat <<EOF |tee /usr/local/bin/launchers-fix
#!/bin/bash
set -e
if test -f /usr/share/applications/FreeFileSync.desktop;then
    sed -i 's|Icon=FreeFileSync|Icon=freefilesync|' /usr/share/applications/FreeFileSync.desktop
fi
if test -f /usr/share/applications/iriunwebcam.desktop;then
    sed -i "s|Exec=|Exec=bash -c 'GTK2_RC_FILES=/usr/share/themes/Orchis-Dark-Compact/gtk-2.0/gtkrc '|" /usr/share/applications/iriunwebcam.desktop
fi
if test -f /usr/share/applications/RealTimeSync.desktop;then
    sed -i 's|Icon=RealTimeSync|Icon=realtimesync|' /usr/share/applications/RealTimeSync.desktop
fi
EOF
chmod +x /usr/local/bin/launchers-fix