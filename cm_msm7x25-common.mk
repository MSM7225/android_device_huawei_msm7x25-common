# Copyright (C) 2011 The Android Open Source Project
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

# Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# BootAnimation
TARGET_BOOTANIMATION_NAME := vertical-240x320

# Inherit device configuration
$(call inherit-product, device/huawei/msm7x25-common/full_msm7x25-common.mk)

# Inherit some common cyanogenmod stuff.
$(call inherit-product, vendor/cm/config/common_mini_phone.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# Device identifier. This must come after all inclusions
#PRODUCT_BRAND := Huawei
PRODUCT_MANUFACTURER := Huawei
PRODUCT_CHARACTERISTICS := phone

# CyanogenMod Properties
BOARD_NO_LIVEWALLPAPERS := true
BOARD_NO_CAMERAEFFECTS := true
BOARD_NO_HWCODECS := true
BOARD_HAVE_LOWRAM := true
BOARD_USE_INSECURESU := true
