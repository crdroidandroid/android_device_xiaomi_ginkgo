#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=ginkgo
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

export TARGET_ENABLE_CHECKELF=false

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/etc/camera/camera_config.xml)
        [ "$2" = "" ] && return 0
            # Remove vtcamera for ginkgo
            gawk -i inplace '{ p = 1 } /<CameraModuleConfig>/{ t = $0; while (getline > 0) { t = t ORS $0; if (/ginkgo_vtcamera/) p = 0; if (/<\/CameraModuleConfig>/) break } $0 = t } p' "${2}"
            ;;
		vendor/lib64/libvendor.goodix.hardware.interfaces.biometrics.fingerprint@2.1.so | vendor/lib64/libgoodixhwfingerprint.so)
        [ "$2" = "" ] && return 0
			grep -q "libhidlbase-v32.so" "${2}" || "${PATCHELF_0_17_2}" --replace-needed "libhidlbase.so" "libhidlbase-v32.so" "${2}"
        ;;
        vendor/lib64/libwvhidl.so | vendor/lib64/mediadrm/libwvdrmengine.so)
        [ "$2" = "" ] && return 0
	        "${PATCHELF}" --replace-needed "libcrypto.so" "libcrypto-v33.so" "${2}"
	        ;;
	    vendor/lib/libalRnBRT_GL_GBWRAPPER.so)
            [ "$2" = "" ] && return 0
            grep -q "libui_shim.so" "${2}" || "${PATCHELF}" --add-needed "libui_shim.so" "${2}"
            ;;
        vendor/lib64/libwvhidl.so | vendor/lib64/mediadrm/libwvdrmengine.so)
        [ "$2" = "" ] && return 0
            grep -q libcrypto_shim.so "${2}" || "${PATCHELF}" --add-needed "libcrypto_shim.so" "${2}"
	        ;;
        vendor/lib/android.hardware.camera.provider@2.4-legacy.so | vendor/lib64/android.hardware.camera.provider@2.4-legacy.so)
        [ "$2" = "" ] && return 0
            grep -q libcamera_provider_shim.so "${2}" || "${PATCHELF}" --add-needed "libcamera_provider_shim.so" "${2}"
	        ;;
        system_ext/lib64/lib-imsvideocodec.so)
            "${PATCHELF}" --add-needed "libgui_shim.so" "${2}"
            ;;
    esac

    return 0
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
