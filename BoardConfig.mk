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

# config.mk
#
# Product-specific compile-time definitions.
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).

# inherit from the proprietary version
-include vendor/samsung/charge/BoardConfigVendor.mk

BOARD_UMS_LUNFILE := "/sys/devices/platform/usb_mass_storage/lun1/file"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/usb_mass_storage/lun1/file"
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true

USE_CAMERA_STUB := false
DEFAULT_FB_NUM := 0
BUILD_PV_VIDEO_ENCODERS := 1
BOARD_V4L2_DEVICE := /dev/video1
BOARD_CAMERA_DEVICE := /dev/video0
BOARD_SECOND_CAMERA_DEVICE := /dev/video2

TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := s5pc110

TARGET_PROVIDES_INIT := true
TARGET_RECOVERY_INITRC := device/samsung/charge/recovery.rc

TARGET_BOARD_PLATFORM := s5pc110
TARGET_BOARD_PLATFORM_GPU := POWERVR_SGX540_120

# ARMv7-A Cortex-A8 architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
ARCH_ARM_HAVE_TLS_REGISTER := true
ANDROID_ARM_LINKER := true

# Set Audio related defines below.
BOARD_USES_GENERIC_AUDIO := false
TARGET_PROVIDES_LIBAUDIO := true

# Releasetools
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := ./device/samsung/charge/releasetools/charge_ota_from_target_files
TARGET_RELEASETOOL_IMG_FROM_TARGET_SCRIPT := ./device/samsung/charge/releasetools/charge_img_from_target_files

# WiFi related defines
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_wext
BOARD_WLAN_DEVICE := bcm4329
WIFI_DRIVER_MODULE_PATH	:= "/lib/modules/bcm4329.ko"
WIFI_DRIVER_MODULE_ARG	:= "firmware_path=/vendor/firmware/fw_bcm4329.bin nvram_path=/vendor/firmware/nvram_net.txt"
WIFI_DRIVER_FW_PATH_AP	:= "/vendor/firmware/fw_bcm4329_apsta.bin"
WIFI_DRIVER_FW_PATH_STA	:= "/vendor/firmware/fw_bcm4329.bin"
WIFI_DRIVER_MODULE_NAME	:= "bcm4329"

#USB tethering
RNDIS_DEVICE := "/sys/devices/virtual/sec/switch/tethering"

# fix mtp
USE_SAMSUNG_USB_MTP_DEVICE := true

# Bluetooth related defines
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_HAVE_BLUETOOTH := true
BT_USE_BTL_IF := true
BT_ALT_STACK := true
BRCM_BTL_INCLUDE_A2DP := true
BRCM_BT_USE_BTL_IF := true
WITH_A2DP := true

# egl shit
BOARD_EGL_CFG := device/samsung/charge/prebuilt/lib/egl/egl.cfg
USE_OPENGL_RENDERER := true
BOARD_USE_SKIA_LCDTEXT := true
#COMMON_GLOBAL_CFLAGS += -DMISSING_EGL_EXTERNAL_IMAGE
#COMMON_GLOBAL_CFLAGS += -DMISSING_EGL_PIXEL_FORMAT_YV12
#COMMON_GLOBAL_CFLAGS += -DMISSING_GRALLOC_BUFFERS

# Device related defines

TARGET_PREBUILT_KERNEL := device/samsung/charge/kernel
BOARD_KERNEL_CMDLINE := no_console_suspend=1 console=null
BOARD_KERNEL_BASE := 0x02e00000

BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USES_BML_OVER_MTD := true

BOARD_BOOTIMAGE_PARTITION_SIZE := 7864320
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 351272960
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1256161280
BOARD_FLASH_BLOCK_SIZE := 4096

# Kernel/recovery devices
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_CUSTOM_GRAPHICS := ../../../device/samsung/charge/recovery/graphics.c
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/charge/shbootimg.mk
TARGET_RECOVERY_PRE_COMMAND := "echo 1 > /cache/.startrecovery; sync;"

TARGET_OTA_ASSERT_DEVICE := charge,SCH-I510
