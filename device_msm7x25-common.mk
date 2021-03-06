# Copyright (C) 2010 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

BOARD_VARIANT := $(shell echo $(PRODUCT_VERSION_DEVICE_SPECIFIC) | tr '[A-Z]' '[a-z]' | cut -c 2-)

# Inherit products
$(call inherit-product, vendor/huawei/msm7x25-common/vendor.mk)

# Add device package overlay
DEVICE_PACKAGE_OVERLAYS := device/huawei/msm7x25-common/overlay

# LDPI assets
PRODUCT_AAPT_CONFIG := mdpi ldpi
PRODUCT_AAPT_PREF_CONFIG := ldpi

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libril-qc-1.so \
    ro.config_datause_iface=rmnet0 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=12 \
    ro.ril.hsdpa.category=8 \
    ro.ril.hsupa.category=6 \
    ro.telephony.default_network=0 \
    ro.telephony.call_ring.delay=0 \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.ril.v3=icccardstatus,datacall,signalstrength,facilitylock

# Graphics 
PRODUCT_PACKAGES += \
    copybit.msm7k \
    gralloc.msm7k
    
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.prefer_16bpp=1 \
    persist.sys.use_dithering=0 \
    persist.sys.purgeable_assets=1 \
    persist.sys.strictmode.visual=false \
    ro.config.disable_hw_accel=true \
    ro.opengles.version=65536 \
    windowsmgr.max_events_per_sec=170
    
# Graphics density
ifneq (,$(filter u8500,$(CM_BUILD)))
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=120
endif

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio_policy.msm7k \
    audio.primary.msm7k
    
# Audio Config
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/etc/AudioFilter.csv:system/etc/AudioFilter.csv
    
# Radio FM (test)
#PRODUCT_PACKAGES += \
#    Effem \
#    libfmradio.bcm4329 \
#    hcitool \
#    hciconfig

# Video decoding
#PRODUCT_PACKAGES += \
#    libstagefrighthw \
#    libopencorehw \
#    libmm-omxcore \
#    libOmxCore

# Camera
PRODUCT_PACKAGES += \
    camera.msm7k

# Camcorder Hack
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/app/Camcorder.apk:system/app/Camcorder.apk \
    device/huawei/msm7x25-common/prebuilt/lib/libandroid-illusion.so:system/lib/libandroid-illusion.so
    
# Media
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml
    
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-player=true \
    media.stagefright.enable-meta=false \
    media.stagefright.enable-scan=false \
    media.stagefright.enable-http=true \
    media.stagefright.enable-aac=true \
    media.stagefright.enable-qcp=true \
    ro.media.dec.jpeg.memcap=20000000 \
    debug.camcorder.disablemeta=1
    
# Packages
PRODUCT_PACKAGES += \
    Gallery2D \
    OptiTrebuchet
    
# Replace Gallery2D with QuickPic
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/app/QuickPic.apk:system/app/Gallery2D.apk \
    device/huawei/msm7x25-common/prebuilt/lib/libqpicjni136.so:system/lib/libqpicjni136.so
    
# Replace Trebuchet with Nova Launcher
#PRODUCT_COPY_FILES += \
#    device/huawei/msm7x25-common/prebuilt/app/NovaLauncher.apk:system/app/Trebuchet.apk \
#    device/huawei/msm7x25-common/prebuilt/lib/libgif.so:system/lib/libgif.so

# GPS
PRODUCT_PACKAGES += \
    gps.msm7k
    
# Bluetooth Config
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/etc/bluetooth/audio.conf:system/etc/bluetooth/audio.conf
    
# Lights
PRODUCT_PACKAGES += \
    lights.msm7k

PRODUCT_PROPERTY_OVERRIDES += \
    view.fading_edge_length=8 \
    view.minimum_fling_velocity=25 \
    view.scroll_friction=0.008 \
    view.touch_slop=15 \
    ro.max.fling_velocity=4000
    
# Hardware Management
PRODUCT_PACKAGES += \
    MSM7x25Parts
    
# MSM7x25Parts
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/ramdisk/init.msm7x25.parts.rc:root/init.msm7x25.parts.rc \
    device/huawei/msm7x25-common/prebuilt/bin/handle_msm7x25parts:system/bin/handle_msm7x25parts
    
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.fm-attn=0 \
    persist.sys.headset-attn=0 \
    persist.sys.speaker-attn=6 \
    persist.sys.read_ahead_kb=0 \
    persist.sys.processlimit=2
    
# zRAM
PRODUCT_PACKAGES += \
    hwprops \
    rzscontrol
    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.zram.default=0

# Dalvik VM
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=32m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.dexopt-flags=v=a,o=v,m=y,u=y \
    dalvik.vm.dexopt-data-only=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=false \
    ro.kernel.android.checkjni=0
    
# System ADB Config
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=adb,mass_storage \
    persist.adb.notify=0 \
    persist.service.adb.enable=1 \
    persist.sys.root_access=1
    
# Usb Accessory
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory
   
# Vold
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/etc/vold.fstab:system/etc/vold.fstab
    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20    
    
# Default ADB Ramdisk Properties
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.debuggable=1 \
    ro.secure=0 \
    ro.allow.mock.location=0

# Keep Launcher in Memory
PRODUCT_PROPERTY_OVERRIDES += \
    ro.HOME_APP_ADJ=1
    
# These are the hardware-specific settings that are stored in system properties.
# Note that the only such settings should be the ones that are too low-level to
# be reachable from resources or other mechanisms.
PRODUCT_PROPERTY_OVERRIDES += \
    mobiledata.interfaces=rmnet0,rmnet1,rmnet2
    
# Wifi interface
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=15

# Hardware permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Input Devices Configs & Keylayouts
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/touchscreen-keypad.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/kp_test_input.idc:system/usr/idc/kp_test_input.idc \
    device/huawei/msm7x25-common/prebuilt/usr/idc/ts_test_input.idc:system/usr/idc/ts_test_input.idc \
    device/huawei/msm7x25-common/prebuilt/usr/idc/adp5587.idc:system/usr/idc/adp5587.idc \
    device/huawei/msm7x25-common/prebuilt/usr/idc/sensors.idc:system/usr/idc/sensors.idc \
    device/huawei/msm7x25-common/prebuilt/usr/idc/touchscreen.idc:system/usr/idc/synaptics.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/synaptics.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/touchscreen.idc:system/usr/idc/melfas-touchscreen.Ver23.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/melfas-touchscreen.Ver23.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/touchscreen.idc:system/usr/idc/melfas-touchscreen_ver23.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/melfas-touchscreen_ver23.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/touchscreen.idc:system/usr/idc/melfas-touchscreen_Ver23.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/melfas-touchscreen_Ver23.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/touchscreen.idc:system/usr/idc/melfas-touchscreen.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/melfas-touchscreen.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/touchscreen.idc:system/usr/idc/synaptics-rmi-touchscreen.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/synaptics-rmi-touchscreen.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/cypress-ts-innolux_Ver04.idc:system/usr/idc/cypress-ts-innolux_Ver04.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/cypress-ts-innolux_Ver04.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/msm_touchscreen.idc:system/usr/idc/msm_touchscreen.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/touchscreen-keypad.kl:system/usr/keylayout/msm_touchscreen.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/7k_handset.idc:system/usr/idc/7k_handset.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/7k_handset.kl:system/usr/keylayout/7k_handset.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/surf_keypad.idc:system/usr/idc/surf_keypad.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/surf_keypad.kl:system/usr/keylayout/surf_keypad.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/avago-OFN.idc:system/usr/idc/avago-OFN.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/avago-OFN.kl:system/usr/keylayout/avago-OFN.kl \
    device/huawei/msm7x25-common/prebuilt/usr/idc/ofn_ok_key.idc:system/usr/idc/ofn_ok_key.idc \
    device/huawei/msm7x25-common/prebuilt/usr/keylayout/ofn_ok_key.kl:system/usr/keylayout/ofn_ok_key.kl

# Init files
PRODUCT_PACKAGES += \
    init.$(BOARD_VARIANT).usb.rc \
    ueventd.$(BOARD_VARIANT).rc

# Tethering
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/bin/huawei_tether:system/bin/huawei_tether
    
# Enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=0 \
    ro.com.google.networklocation=0
    
# Enable repeatable keys in CWM Recovery
PRODUCT_PROPERTY_OVERRIDES += \
    ro.cwm.enable_key_repeat=true \
    ro.cwm.repeatable_keys=114,115
