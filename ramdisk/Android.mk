LOCAL_PATH:= $(call my-dir)

#######################################
# ueventd.u8xxx.rc

include $(CLEAR_VARS)
LOCAL_MODULE	:= ueventd.$(BOARD_VARIANT).rc
LOCAL_MODULE_TAGS	:= optional
LOCAL_MODULE_CLASS	:= ETC
LOCAL_SRC_FILES	:= ueventd.msm7k.rc
LOCAL_MODULE_PATH	:= $(TARGET_ROOT_OUT)
include $(BUILD_PREBUILT)

#######################################
