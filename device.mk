#
# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.
DEVICE_PACKAGE_OVERLAYS := device/samsung/chargemtd/overlay

# Init/misc files
PRODUCT_COPY_FILES := \
    device/samsung/chargemtd/init.smdkc110.rc:root/init.smdkc110.rc \
    device/samsung/chargemtd/ueventd.rc:root/ueventd.rc \
    device/samsung/chargemtd/lpm.rc:root/lpm.rc \
    device/samsung/chargemtd/gps.conf:system/etc/gps.conf
# egl
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg

# asound.conf
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/prebuilt/etc/asound.conf:system/etc/asound.conf

# touchscreen
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/prebuilt/usr/idc/qt602240_ts_input.idc:system/usr/idc/qt602240_ts_input.idc

# vold
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/prebuilt/etc/vold.fstab:system/etc/vold.fstab

# apn config
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml \
    device/samsung/chargemtd/prebuilt/etc/cdma-carriers-conf.xml:system/etc/cdma-carriers-conf.xml

# Keylayout / Keychars
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/prebuilt/usr/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
    device/samsung/chargemtd/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
    device/samsung/chargemtd/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/samsung/chargemtd/prebuilt/usr/keylayout/Broadcom_Bluetooth_HID.kl:system/usr/keylayout/Broadcom_Bluetooth_HID.kl \
    device/samsung/chargemtd/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl

# Generated kcm keymaps
PRODUCT_PACKAGES := \
    s3c-keypad.kcm

# update utilities
PRODUCT_PACKAGES += \
    make_ext4fs \
    setup_fs \
    bootmenu_busybox \
    bml_over_mtd

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry \
    device/samsung/chargemtd/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
    libSEC_OMX_Core.s5pc110 \
    libOMX.SEC.AVC.Decoder.s5pc110 \
    libOMX.SEC.M4V.Decoder.s5pc110 \
    libOMX.SEC.M4V.Encoder.s5pc110 \
    libOMX.SEC.AVC.Encoder.s5pc110

# audio libs
PRODUCT_PACKAGES += \
    audio.primary.s5pc110 \
    audio_policy.s5pc110 \
    audio.a2dp.default

# media/gfx libs
PRODUCT_PACKAGES += \
    hwcomposer.s5pc110 \
    camera.s5pc110 \
    libs3cjpeg \
    libstagefrighthw

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml \
    device/samsung/chargemtd/prebuilt/etc/permissions/android.hardware.telephony.ehrpd.xml:system/etc/permissions/android.hardware.telephony.ehrpd.xml \
    device/samsung/chargemtd/prebuilt/etc/permissions/android.hardware.telephony.lte.xml:system/etc/permissions/android.hardware.telephony.lte.xml

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number
PRODUCT_PROPERTY_OVERRIDES := \
    ro.opengles.version=131072

# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=90 \
    ro.wifi.channels=11 \
    dalvik.vm.startheapsize=8m \
    dalvik.vm.heapsize=48m

# enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs 
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false

# Override /proc/sys/vm/dirty_ratio on UMS
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20

# Set default USB interface
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mass_storage

# disable usb debugging notif
PRODUCT_PROPERTY_OVERRIDES += \
    persist.adb.notify=0

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/samsung/chargemtd/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# install wifi driver
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/nvram_net.txt:system/vendor/firmware/nvram_net.txt \
    device/samsung/chargemtd/nvram_mfg.txt:system/vendor/firmware/nvram_mfg.txt

# copy the filesystem converter
PRODUCT_COPY_FILES += \
    device/samsung/chargemtd/updater.sh:updater.sh

# See comment at the top of this file. This is where the other
# half of the device-specific product definition file takes care
# of the aspects that require proprietary drivers that aren't
# commonly available
$(call inherit-product-if-exists, vendor/samsung/chargemtd/charge-vendor.mk)
