#!/bin/bash
set -e
mkdir -p /tmp/respin-rdx/config/includes.chroot/usr/share/{backgrounds,gnome-background-properties}
cp -r assets/unsplash /tmp/respin-rdx/config/includes.chroot/usr/share/backgrounds/unsplash
cat <<EOF |tee /tmp/respin-rdx/config/includes.chroot/usr/share/gnome-background-properties/unsplash.xml>/dev/null
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
	<wallpaper deleted="false">
		<name>Unsplash 1</name>
		<filename>/usr/share/backgrounds/unsplash/ashim-d-silva-WeYamle9fDM-unsplash.jpg.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 2</name>
		<filename>/usr/share/backgrounds/unsplash/benjamin-davies-P9BY2joAcwk-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 3</name>
		<filename>/usr/share/backgrounds/unsplash/benjamin-voros-yrwpJwDNSHE-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 4</name>
		<filename>/usr/share/backgrounds/unsplash/cesar-lopez-rivadeneira-cfyTzECvjlU-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 5</name>
		<filename>/usr/share/backgrounds/unsplash/edewaa-foster-aWkpMIIC5aY-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 6</name>
		<filename>/usr/share/backgrounds/unsplash/elle-zhu-O_uV3KhQuo8-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 7</name>
		<filename>/usr/share/backgrounds/unsplash/fernando-paredes-murillo-yWbxfKurMH0-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 8</name>
		<filename>/usr/share/backgrounds/unsplash/garrett-parker-DlkF4-dbCOU-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 9</name>
		<filename>/usr/share/backgrounds/unsplash/john-towner-JgOeRuGD_Y4-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 10</name>
		<filename>/usr/share/backgrounds/unsplash/joshua-sortino-CTVGEm6V8qI-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 11</name>
		<filename>/usr/share/backgrounds/unsplash/joshua-sortino-xZqr8WtYEJ0-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 12</name>
		<filename>/usr/share/backgrounds/unsplash/keith-hardy-PP8Escz15d8-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 13</name>
		<filename>/usr/share/backgrounds/unsplash/kimon-maritz-mQiZnKwGXW0-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>My Awesome Distro</name>
		<filename>/usr/share/backgrounds/unsplash/unsplash-gnome.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 14</name>
		<filename>/usr/share/backgrounds/unsplash/martin-jernberg-qie9wa-YLK8-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 15</name>
		<filename>/usr/share/backgrounds/unsplash/nadine-shaabana-shetVz3YJ70-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 16</name>
		<filename>/usr/share/backgrounds/unsplash/patrick-fore-iOiaqY7eZsY-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 17</name>
		<filename>/usr/share/backgrounds/unsplash/peter-hammer-SXTj90G1f5c-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 18</name>
		<filename>/usr/share/backgrounds/unsplash/samuel-scrimshaw-KeUKM5N-e_g-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 19</name>
		<filename>/usr/share/backgrounds/unsplash/samuel-scrimshaw-sseiVD2XsOk-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 20</name>
		<filename>/usr/share/backgrounds/unsplash/andy-holmes-tmsxaFx1Sws-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 21</name>
		<filename>/usr/share/backgrounds/unsplash/josefina-di-battista-UwoPc2op3UQ-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unsplash 22</name>
		<filename>/usr/share/backgrounds/unsplash/wesley-pribadi-iS1NV9yN0Lg-unsplash.jpg</filename>
		<options>zoom</options>
	</wallpaper>
</wallpapers>
EOF
cp -r assets/unknown /tmp/respin-rdx/config/includes.chroot/usr/share/backgrounds/unknown
cat <<EOF |tee /tmp/respin-rdx/config/includes.chroot/usr/share/gnome-background-properties/unknown.xml>/dev/null
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
	<wallpaper deleted="false">
		<name>Unknown 1</name>
		<filename>/usr/share/backgrounds/unknown/729666.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 2</name>
		<filename>/usr/share/backgrounds/unknown/abstract-blue-wave-background-digital-art-4k-wallpaper-uhdpaper.com-486@0@f.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 3</name>
		<filename>/usr/share/backgrounds/unknown/abstract-colorful-wave-3-4k.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 4</name>
		<filename>/usr/share/backgrounds/unknown/abstract-digital-art-uhdpaper.com-4K-4.301.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 5</name>
		<filename>/usr/share/backgrounds/unknown/abstract-illustration-colorful-art-15-4k.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 6</name>
		<filename>/usr/share/backgrounds/unknown/backiee-292330-landscape.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 7</name>
		<filename>/usr/share/backgrounds/unknown/Waves-Dark-6016x6016.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 8</name>
		<filename>/usr/share/backgrounds/unknown/Waves-Dark-Alt-6016x6016.jpg</filename>
		<options>zoom</options>
	</wallpaper>
	<wallpaper deleted="false">
		<name>Unknown 9</name>
		<filename>/usr/share/backgrounds/unknown/Waves-Light-6016x6016.jpg</filename>
		<options>zoom</options>
	</wallpaper>
</wallpapers>
EOF