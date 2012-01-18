#!/sbin/sh

mount -o remount,rw /

exec >> /tmp/bml_over_mtd.log 2>&1

if [ ! -e /data/modem.bin ]
then
	/sbin/bml_over_mtd dump radio 1954 reservoir 2004 /data/modem.bin
fi
ln -s /data/modem.bin /dev/block/bml12

if [ ! -e /data/efs/nv_data.bin ]
then
	/sbin/bml_over_mtd dump efs 2002 reservoir 2004 /data/efs/nv_data.bin
fi
ln -s /data/efs/nv_data.bin /dev/nvs

mount -o remount,ro /
