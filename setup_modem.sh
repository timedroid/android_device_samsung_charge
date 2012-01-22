#!/sbin/sh

mount -o remount,rw /

exec >> /tmp/bml_over_mtd.log 2>&1

if [ ! -e /efs/modem.bin ]
then
	/sbin/bml_over_mtd dump radio 1954 reservoir 2004 /efs/modem.bin
fi
ln -s /efs/modem.bin /dev/block/bml12

if [ ! -e /efs/nv_data.bin ]
then
	/sbin/bml_over_mtd dump nvdata 2002 reservoir 2004 /efs/nv_data.bin
fi
ln -s /efs/nv_data.bin /dev/nvs

mount -o remount,ro /
