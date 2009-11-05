#!/bin/sh
pkg_add -r samba33
/usr/local/bin/testparm 
dl_missing () {
	echo "Downloading missing files"
	fetch http://pfsense-cacheboy.googlecode.com/files/sambalibdep.tar.gz
	tar -xvf sambalibdep.tar.gz
	rm sambalibdep.tar.gz
	}
extract_config () {
	echo "Download and ExtracTing config"
	fetch http://pfsense-cacheboy.googlecode.com/files/smbconf.tar.gz
	tar -xvf smbconf.tar.gz
	rm smbconf.tar.gz
	}
complete () {
	echo "run "smbpasswd -a root" to add user root"
	mv /usr/local/etc/rc.d/samba /usr/local/etc/rc.d/samba.sh
	/usr/local/etc/rc.d/samba.sh start
	rehash
	smbpasswd -a root
	break
	}
while :
do
echo "Shared Object missing? y/n"
read YN
case $YN in
	[yY]*)
		dl_missing
		extract_config
		complete
		;;
	[nN]*)
		extract_config
		complete
		;;
esac
done