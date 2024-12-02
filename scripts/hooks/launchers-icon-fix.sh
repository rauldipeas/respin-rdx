#!/bin/bash
set -e
cat <<EOF |tee /etc/apt/apt.conf.d/100launchers-icon-fix
DPkg::Post-Invoke {
"launchers-icon-fix"
};
EOF
cat <<EOF |tee /usr/local/bin/launchers-icon-fix
#!/bin/bash
set -e
if test -f /usr/share/applications/FreeFileSync.desktop;then
    sed -i 's|Icon=FreeFileSync|Icon=freefilesync|' /usr/share/applications/FreeFileSync.desktop
fi
EOF
chmod +x /usr/local/bin/launchers-icon-fix