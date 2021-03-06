/*
* Copyright (C) 2010 The Android Open Source Project
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

#include <linux/input.h>
#include <sys/stat.h>
#include <errno.h>
#include <string.h>

#include "recovery_ui.h"
#include "common.h"

int device_toggle_display(volatile char* key_pressed, int key_code) {
    // hold power and press volume-up
    return key_pressed[116] && key_code == 115;
}

int device_handle_key(int key_code, int visible) {
    if (visible) {
        switch (key_code) {
            case 108:
            case 114:
                return HIGHLIGHT_DOWN;

            case 103:
            case 115:
                return HIGHLIGHT_UP;

            case 232:
            case 116:
            case 102:
            case 139:
                return SELECT_ITEM;
           
            case 158:
            case 217:
            case 62:
                return GO_BACK;
        }
    }

    return NO_ACTION;
}
