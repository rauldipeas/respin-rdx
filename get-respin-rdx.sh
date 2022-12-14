#!/bin/bash
set -e
get_zip () {
	rm -f /tmp/"$1"-respin-rdx.zip /tmp/"$1"-respin-rdx.iso
	if [ -f /usr/bin/wget ]; then
		wget -q --show-progress -O /tmp/"$1"-respin-rdx.zip https://nightly.link/rauldipeas/respin-rdx/workflows/"$1"-respin-rdx/main/"$1"-respin-rdx.zip
		else
		pkcon install wget
		wget -q --show-progress -O /tmp/"$1"-respin-rdx.zip https://nightly.link/rauldipeas/respin-rdx/workflows/"$1"-respin-rdx/main/"$1"-respin-rdx.zip
	fi
}
copy_iso_to_ventoy () {
	if [ -f /usr/bin/unzip ]; then
		unzip /tmp/"$1"-respin-rdx.zip -d /tmp/
		if [ -d /media/"$USER"/Ventoy ]; then
			if [ -f /usr/bin/gcp ]; then
				gcp -f /tmp/"$1"-respin-rdx.iso /media/"$USER"/Ventoy/
				else
				pkcon install gcp
				gcp -f /tmp/"$1"-respin-rdx.iso /media/"$USER"/Ventoy/
			fi
			else
			mv /tmp/"$1"-respin-rdx.iso "$HOME"/Downloads/
		fi
		else
		pkcon install unzip
		unzip /tmp/"$1"-respin-rdx.zip -d /tmp/
		if [ -d /media/"$USER"/Ventoy ]; then
			if [ -f /usr/bin/gcp ]; then
				gcp -f /tmp/"$1"-respin-rdx.iso /media/"$USER"/Ventoy/
				else
				pkcon install gcp
				gcp -f /tmp/"$1"-respin-rdx.iso /media/"$USER"/Ventoy/
			fi
			else
			mv /tmp/"$1"-respin-rdx.iso "$HOME"/Downloads/
		fi
	fi
}
if [ "$1" ]; then
	get_zip "$1";copy_iso_to_ventoy "$1"
	else
	get_zip ubuntu;copy_iso_to_ventoy ubuntu
	get_zip kubuntu;copy_iso_to_ventoy kubuntu
	get_zip xubuntu;copy_iso_to_ventoy xubuntu
	get_zip neon;copy_iso_to_ventoy neon
	get_zip ucl;copy_iso_to_ventoy ucl
	get_zip ugl;copy_iso_to_ventoy ugl
	get_zip ugl-rolling;copy_iso_to_ventoy ugl-rolling
	get_zip kdeck;copy_iso_to_ventoy kdeck
fi