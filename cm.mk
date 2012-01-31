# Release name
PRODUCT_RELEASE_NAME := Charge

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/samsung/chargemtd/full_chargemtd.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := chargemtd
PRODUCT_NAME := cm_chargemtd
PRODUCT_BRAND := Samsung
PRODUCT_MODEL := Droid Charge

#Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=SCH-I510 BUILD_ID=GINGERBREAD BUILD_FINGERPRINT="verizon/SCH-I510/SCH-I510:2.3.6/GINGERBREAD/EP4:user/release-keys" PRIVATE_BUILD_DESC="SCH-I510-user 2.3.6 GINGERBREAD EP4 release-keys"
