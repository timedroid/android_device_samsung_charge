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

#
# This is the product configuration for a generic GSM passion,
# not specialized for any geography.
#
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/samsung/charge/charge-vendor.mk)

# Init files
PRODUCT_COPY_FILES += \
  device/samsung/charge/init.smdkc110.rc:root/init.smdkc110.rc \
  device/samsung/charge/ueventd.rc:root/ueventd.rc \
  device/samsung/charge/lpm.rc:root/lpm.rc

# kernel modules for ramdisk
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/samsung/charge/modules,root/lib/modules)

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,device/samsung/charge/modules,recovery/root/lib/modules)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=90 \
    ro.wifi.channels=11 \
    ro.opengles.version=131072

#verizon cdma stuff
PRODUCT_PROPERTY_OVERRIDES += \
	ro.telephony.default_network=4 \
	ro.com.android.wifi-watchlist=GoogleGuest \
	ro.error.receiver.system.apps=com.google.android.feedback \
	ro.setupwizard.enterprise_mode=1 \
	ro.com.google.clientidbase=android-verizon \
	ro.com.google.clientidbase.yt=android-verizon \
	ro.com.google.clientidbase.am=android-verizon \
	ro.com.google.clientidbase.vs=android-verizon \
	ro.com.google.clientidbase.gmm=android-verizon \
	ro.com.google.locationfeatures=1 \
	ro.ril.def.agps.mode=2 \
	ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
	ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
	ro.cdma.home.operator.numeric=310004 \
	ro.cdma.home.operator.alpha=Verizon \
	ro.cdma.homesystem=64,65,76,77,78,79,80,81,82,83 \
	ro.cdma.data_retry_config=default_randomization=2000,0,0,120000,180000,540000,960000 \
	net.dns1=8.8.8.8 \
	net.dns2=8.8.4.4 \
	ro.config.vc_call_vol_steps=15 \
	ro.cdma.otaspnumschema=SELC,1,80,99 \
	ro.telephony.call_ring.multiple=false \
	ro.telephony.call_ring.delay=3000 \
	ro.telephony.call_ring.absent=true \
	net.cdma.pppd.authtype=require-chap \
	net.cdma.pppd.user=user[SPACE]VerizonWireless \
	net.cdma.datalinkinterface=/dev/ttyCDMA0 \
	net.interfaces.defaultroute=cdma \
	net.cdma.ppp.interface=ppp0 \
	net.connectivity.type=CDMA1 \
	net.interfaces.defaultroute=cdma \
	ro.telephony.ril_class=samsung \
	ro.ril.samsung_cdma=true

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.startheapsize=8m \
    dalvik.vm.heapsize=48m

# For mobiledatainterfaces
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=eth0,ppp0,pdpbr0,svnet0,hrpd0

DEVICE_PACKAGE_OVERLAYS += device/samsung/charge/overlay

# other stuffs
PRODUCT_COPY_FILES += \
    device/samsung/charge/prebuilt/xbin/bmlwrite:system/xbin/bmlwrite

# asound.conf
PRODUCT_COPY_FILES += \
    device/samsung/charge/prebuilt/etc/asound.conf:system/etc/asound.conf

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
    device/samsung/charge/prebuilt/etc/permissions/android.hardware.telephony.ehrpd.xml:system/etc/permissions/android.hardware.telephony.ehrpd.xml \
    device/samsung/charge/prebuilt/etc/permissions/android.hardware.telephony.lte.xml:system/etc/permissions/android.hardware.telephony.lte.xml

# update utilities
PRODUCT_PACKAGES += \
  make_ext4fs \
  bootmenu_busybox \
  bmlwrite

# audio libs
PRODUCT_PACKAGES += \
	audio.primary.s5pc110 \
	audio_policy.s5pc110 \
	audio.a2dp.default

# other libs
PRODUCT_PACKAGES += \
	hwcomposer.s5pc110 \
	camera.s5pc110 \
	libs3cjpeg \
	libstagefrighthw

# These are the OpenMAX IL configuration files
PRODUCT_COPY_FILES += \
	device/samsung/charge/sec_mm/sec_omx/sec_omx_core/secomxregistry:system/etc/secomxregistry \
	device/samsung/charge/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml

# These are the OpenMAX IL modules
PRODUCT_PACKAGES += \
	libSEC_OMX_Core.s5pc110 \
	libOMX.SEC.AVC.Decoder.s5pc110 \
	libOMX.SEC.M4V.Decoder.s5pc110 \
	libOMX.SEC.M4V.Encoder.s5pc110 \
	libOMX.SEC.AVC.Encoder.s5pc110

# apn config
PRODUCT_COPY_FILES += \
    device/samsung/charge/prebuilt/etc/apns-conf.xml:system/etc/apns-conf.xml \
    device/samsung/charge/prebuilt/etc/cdma-carriers-conf.xml:system/etc/cdma-carriers-conf.xml

# Keylayout / Keychars
PRODUCT_COPY_FILES += \
     device/samsung/charge/prebuilt/usr/keylayout/s3c-keypad.kl:system/usr/keylayout/s3c-keypad.kl \
     device/samsung/charge/prebuilt/usr/keylayout/sec_jack.kl:system/usr/keylayout/sec_jack.kl \
     device/samsung/charge/prebuilt/usr/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
     device/samsung/charge/prebuilt/usr/keylayout/Broadcom_Bluetooth_HID.kl:system/usr/keylayout/Broadcom_Bluetooth_HID.kl \
     device/samsung/charge/prebuilt/usr/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl

# Generated kcm keymaps
PRODUCT_PACKAGES += \
       s3c-keypad.kcm

# vold
PRODUCT_COPY_FILES += \
     device/samsung/charge/prebuilt/etc/vold.fstab:system/etc/vold.fstab

# touchscreen
PRODUCT_COPY_FILES += \
     device/samsung/charge/prebuilt/usr/idc/qt602240_ts_input.idc:system/usr/idc/qt602240_ts_input.idc

# Kernel
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/samsung/charge/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# copy the filesystem converter
PRODUCT_COPY_FILES += \
  device/samsung/charge/updater.sh:updater.sh

$(call inherit-product, build/target/product/full.mk)

PRODUCT_NAME := full_charge
PRODUCT_DEVICE := charge
PRODUCT_MODEL := charge
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := Samsung
PRODUCT_POLICY := android.policy_phone

PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.execution-mode=int:jit

