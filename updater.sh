#!/tmp/busybox sh
#
# Updater Script for Droid Charge
# (c) 2011 by Teamhacksung
#

set -x
export PATH=/:/sbin:/system/xbin:/system/bin:/tmp:$PATH
SD_DEV=/dev/block/mmcblk1p1

# check if we're running on a bml or mtd device
if /tmp/busybox test -e /dev/block/bml7 ; then
# we're running on a bml device

    # make sure sdcard is mounted
    if ! /tmp/busybox grep -q /mnt/sdcard /proc/mounts ; then
        /tmp/busybox mkdir -p /mnt/sdcard
        /tmp/busybox umount -l $SD_DEV
        if ! /tmp/busybox mount -t vfat $SD_DEV /mnt/sdcard ; then
            /tmp/busybox echo "Cannot mount sdcard."
            exit 1
        fi
    fi

    # remove old log
    rm -rf /mnt/sdcard/cyanogenmod_bml.log

    # everything is logged into /sdcard/cyanogenmod.log
    exec >> /mnt/sdcard/cyanogenmod_bml.log 2>&1

    # the phone seems to run fine without /efs (there's just DivX DRM
    # and a text file containing the bluetooth MAC address), but we
    # might as well back it up anyway. The actual EFS partition is
    # BML13, which we need to keep as-is.

    # make sure efs is mounted
    if ! /tmp/busybox grep -q /efs /proc/mounts ; then
        /tmp/busybox mkdir -p /efs
        /tmp/busybox umount -l /dev/block/stl3
        if ! /tmp/busybox mount -t rfs /dev/block/stl3 /efs ; then
            /tmp/busybox echo "Cannot mount efs."
            exit 2
        fi
    fi

    # create a backup of efs
    if /tmp/busybox test -e /mnt/sdcard/backup/efs ; then
        /tmp/busybox mv /mnt/sdcard/backup/efs /mnt/sdcard/backup/efs-$$
    fi
    /tmp/busybox rm -rf /mnt/sdcard/backup/efs
    
    /tmp/busybox mkdir -p /mnt/sdcard/backup/efs
    /tmp/busybox cp -R /efs/ /mnt/sdcard/backup

    # dump actual efs partition
    /tmp/busybox dd if=/dev/block/bml13 of=/mnt/sdcard/backup/efs/nv_data.bin bs=256K

    # write the package path to sdcard cyanogenmod.cfg
    if /tmp/busybox test -n "$UPDATE_PACKAGE" ; then
        PACKAGE_LOCATION=${UPDATE_PACKAGE#/mnt}
        /tmp/busybox echo "$PACKAGE_LOCATION" > /mnt/sdcard/cyanogenmod.cfg
    fi

    # Scorch any ROM Manager settings to require the user to reflash recovery
    /tmp/busybox rm -f /mnt/sdcard/clockworkmod/.settings

    # write new kernel to boot partition
    /tmp/flash_image boot /tmp/boot.img
    if [ "$?" != "0" ] ; then
        exit 3
    fi

    # write new kernel to recovery partition
    /tmp/flash_image recovery /tmp/boot.img
    if [ "$?" != "0" ] ; then
        exit 3
    fi

    /tmp/busybox sync

    /sbin/reboot now
    exit 0

elif /tmp/busybox test -e /dev/block/mtdblock0 ; then
# we're running on a mtd device

    # make sure sdcard is mounted
    /tmp/busybox mkdir -p /sdcard

    if ! /tmp/busybox grep -q /sdcard /proc/mounts ; then
        /tmp/busybox umount -l $SD_DEV
        if ! /tmp/busybox mount -t vfat $SD_DEV /sdcard ; then
            /tmp/busybox echo "Cannot mount sdcard."
            exit 4
        fi
    fi

    # remove old log
    rm -rf /sdcard/cyanogenmod_mtd.log

    # everything is logged into /sdcard/cyanogenmod.log
    exec >> /sdcard/cyanogenmod_mtd.log 2>&1

    # if a cyanogenmod.cfg exists, then this is a first time install
    # let's format the volumes and restore efs
    if ! /tmp/busybox test -e /sdcard/cyanogenmod.cfg ; then
        exit 0
    fi
	
    # remove the cyanogenmod.cfg to prevent this from looping
    /tmp/busybox rm -f /sdcard/cyanogenmod.cfg

    # unmount, format and mount system
    /tmp/busybox umount -l /system
    /tmp/erase_image system
    /tmp/busybox mount -t yaffs2 /dev/block/mtdblock2 /system

    # unmount and format cache
    /tmp/busybox umount /cache
    /tmp/make_ext4fs -b 4096 -g 32768 -i 8192 -I 256 -a /cache /dev/block/mmcblk0p3

    # unmount and format data
    /tmp/busybox umount /data
    /tmp/make_ext4fs -b 4096 -g 32768 -i 8192 -I 256 -a /data /dev/block/mmcblk0p1

    # unmount and format datadata
    /tmp/busybox umount -l /datadata
    /tmp/erase_image datadata

    # remount data
    if ! /tmp/busybox mount -t ext4 /dev/block/mmcblk0p1 /data ; then
        /tmp/busybox echo "Cannot mount data."
        exit 4
    fi

    # restore efs backup
    if /tmp/busybox test -e /sdcard/backup/efs ; then
        /tmp/busybox mkdir -p /data/efs
        /tmp/busybox cp -R /sdcard/backup/efs /data
    else
        /tmp/busybox echo "Cannot restore efs."
        exit 7
    fi

    # dump modem
    /tmp/bml_over_mtd dump radio 1954 reservoir 2004 /data/modem.bin

    # flash boot image to boot
    /tmp/bml_over_mtd.sh boot 84 reservoir 2004 /tmp/boot.img

    # flash boot image to recovery
    /tmp/bml_over_mtd.sh recovery 114 reservoir 2004 /tmp/boot.img

    # unmount and format data
    /tmp/busybox umount /data

    exit 0
fi

