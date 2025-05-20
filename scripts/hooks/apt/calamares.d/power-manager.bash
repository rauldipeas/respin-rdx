#!/usr/bin/bash
set -e
if find /sys/class/power_supply|grep BAT;then
	sudo apt install -y tlp
fi