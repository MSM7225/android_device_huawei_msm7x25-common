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
    persist.sys.use_16bpp_alpha=1 \
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
    
# zRAM
PRODUCT_PACKAGES += \
    hwprops \
    rzscontrol

# Dalvik VM
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=32m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.dexopt-flags=v=a,o=v,m=y,u=y

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
    wifi.interface=wlan0 \
    mobiledata.interfaces=rmnet0,rmnet1,rmnet2
    
# Wifi interface
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.supplicant_scan_interval=15
    
# Wi-Fi related
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/prebuilt/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/huawei/msm7x25-common/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

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

# Init files
PRODUCT_COPY_FILES += \
    device/huawei/msm7x25-common/ramdisk/init.rc:root/init.rc

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
