OUTDIR=vendor/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk

(cat << EOF) > $MAKEFILE
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`wc -l device-proprietary-files.txt | awk {'print $1'}`
DISM=`egrep -c '(^#|^$)' device-proprietary-files.txt`
COUNT=`expr $COUNT - $DISM`
for FILE in `egrep -v '(^#|^$)' ../$DEVICE/device-proprietary-files.txt`; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ] && [ -f ../msm8960-common/proprietary-files.txt ]; then
    LINEEND=" \\"
  elif [ $COUNT = "0" ]; then
  LINEEND=""
  fi
  # Split the file from the destination (format is "file[:destination]")
  OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
  FILE=${PARSING_ARRAY[0]}
  DEST=${PARSING_ARRAY[1]}
  if [ -z "$DEST" ]; then
    echo "    $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
  else
    echo "    $OUTDIR/proprietary/$DEST:system/$DEST$LINEEND" >> $MAKEFILE
  fi
done

LINEEND=" \\"
COUNT=`wc -l ../msm8960-common/proprietary-files.txt | awk {'print $1'}`
DISM=`egrep -c '(^#|^$)' ../msm8960-common/proprietary-files.txt`
COUNT=`expr $COUNT - $DISM`
for FILE in `egrep -v '(^#|^$)' ../msm8960-common/proprietary-files.txt`; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ]; then
    LINEEND=""
  fi
  # Split the file from the destination (format is "file[:destination]")
  OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
  FILE=${PARSING_ARRAY[0]}
  DEST=${PARSING_ARRAY[1]}
  if [ -z "$DEST" ]; then
    echo "    $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
  else
    echo "    $OUTDIR/proprietary/$DEST:system/$DEST$LINEEND" >> $MAKEFILE
  fi
done

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS += vendor/$VENDOR/$DEVICE/overlay

\$(call inherit-product, vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
\$(call inherit-product, vendor/motorola/msm8960-common/msm8960-common-vendor.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/BoardConfigVendor.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

EOF

if [ -d ../../../${OUTDIR}/packages ]; then
(cat << EOF) > ../../../${OUTDIR}/packages/Android.mk
# Copyright (C) 2013 The CyanogenMod Project
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

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

LOCAL_PATH:= \$(call my-dir)

EOF

echo "ifeq (\$(TARGET_DEVICE),$DEVICE)" >> ../../../${OUTDIR}/packages/Android.mk

for APK in `ls ../../../${OUTDIR}/packages/*apk`; do
    apkname=`basename $APK`
    modulename=`echo $apkname|sed -e 's/\.apk$//gi'`
    (cat << EOF) >> ../../../${OUTDIR}/packages/Android.mk
include \$(CLEAR_VARS)
LOCAL_MODULE := $modulename
LOCAL_MODULE_TAGS := optional eng
LOCAL_SRC_FILES := $apkname
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := \$(COMMON_ANDROID_PACKAGE_SUFFIX)
include \$(BUILD_PREBUILT)
EOF

echo "endif" >> ../../../${OUTDIR}/packages/Android.mk

    echo "PRODUCT_PACKAGES += $modulename" >> ../../../$OUTDIR/$DEVICE-vendor.mk
done
fi

export DEVICE=msm8960-common
OUTDIR=vendor/$VENDOR/$DEVICE
MAKEFILE=../../../$OUTDIR/$DEVICE-vendor-blobs.mk

(cat << EOF) > $MAKEFILE
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

### copy to obj/ the prebuilts needed to build open source libraries

PRODUCT_COPY_FILES += \\
    vendor/motorola/msm8960-common/proprietary/lib/libmmjpeg.so:obj/lib/libmmjpeg.so \\
    vendor/motorola/msm8960-common/proprietary/lib/libmmstillomx.so:obj/lib/libmmstillomx.so \\
    vendor/motorola/msm8960-common/proprietary/lib/libimage-jpeg-enc-omx-comp.so:obj/lib/libimage-jpeg-enc-omx-comp.so \\
    vendor/motorola/msm8960-common/proprietary/lib/liboemcamera.so:obj/lib/liboemcamera.so

PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`wc -l ../msm8960-common/common-proprietary-files.txt | awk {'print $1'}`
DISM=`egrep -c '(^#|^$)' ../msm8960-common/common-proprietary-files.txt`
COUNT=`expr $COUNT - $DISM`
for FILE in `egrep -v '(^#|^$)' ../msm8960-common/common-proprietary-files.txt`; do
  COUNT=`expr $COUNT - 1`
  if [ $COUNT = "0" ]; then
    LINEEND=""
  fi
  # Split the file from the destination (format is "file[:destination]")
  OLDIFS=$IFS IFS=":" PARSING_ARRAY=($FILE) IFS=$OLDIFS
  FILE=${PARSING_ARRAY[0]}
  DEST=${PARSING_ARRAY[1]}
  if [ -z "$DEST" ]; then
    echo "    $OUTDIR/proprietary/$FILE:system/$FILE$LINEEND" >> $MAKEFILE
  else
    echo "    $OUTDIR/proprietary/$DEST:system/$DEST$LINEEND" >> $MAKEFILE
  fi
done

(cat << EOF) > ../../../$OUTDIR/$DEVICE-vendor.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

# Pick up overlay for features that depend on non-open-source files

\$(call inherit-product, vendor/$VENDOR/$DEVICE/$DEVICE-vendor-blobs.mk)
\$(call inherit-product, vendor/motorola/msm8960-common/vendor-adreno-blobs.mk)
\$(call inherit-product, vendor/motorola/msm8960-common/vendor-jf-blobs.mk)
\$(call inherit-product, vendor/motorola/msm8960-common/vendor-mako-blobs.mk)
EOF

(cat << EOF) > ../../../$OUTDIR/BoardConfigVendor.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh
EOF

(cat << EOF) > ../../../$OUTDIR/vendor-adreno-blobs.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

LOCAL_PATH:=vendor/motorola/msm8960-common/Adreno200-AU_LINUX_ANDROID_JB_VANILLA_04.02.02.060.053/system

# Adreno blobs from QDevNet must be added from
# https://developer.qualcomm.com/download/Adreno200-AU_LINUX_ANDROID_JB_VANILLA_04.02.02.060.053.zip
PRODUCT_COPY_FILES += \\
	\$(LOCAL_PATH)/bin/gpu_dcvsd:/system/bin/gpu_dcvsd \\
	\$(LOCAL_PATH)/etc/firmware/a225p5_pm4.fw:system/etc/firmware/a225p5_pm4.fw \\
	\$(LOCAL_PATH)/etc/firmware/a225_pfp.fw:system/etc/firmware/a225_pfp.fw \\
	\$(LOCAL_PATH)/etc/firmware/a225_pm4.fw:system/etc/firmware/a225_pm4.fw \\
	\$(LOCAL_PATH)/etc/firmware/a300_pfp.fw:system/etc/firmware/a300_pfp.fw \\
	\$(LOCAL_PATH)/etc/firmware/a300_pm4.fw:system/etc/firmware/a300_pm4.fw \\
	\$(LOCAL_PATH)/etc/firmware/leia_pfp_470.fw:system/etc/firmware/leia_pfp_470.fw \\
	\$(LOCAL_PATH)/etc/firmware/leia_pm4_470.fw:system/etc/firmware/leia_pm4_470.fw \\
	\$(LOCAL_PATH)/etc/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \\
	\$(LOCAL_PATH)/etc/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \\
	\$(LOCAL_PATH)/lib/egl/eglsubAndroid.so:system/lib/egl/eglsubAndroid.so \\
	\$(LOCAL_PATH)/lib/egl/libEGL_adreno200.so:system/lib/egl/libEGL_adreno200.so \\
	\$(LOCAL_PATH)/lib/egl/libGLESv1_CM_adreno200.so:system/lib/egl/libGLESv1_CM_adreno200.so \\
	\$(LOCAL_PATH)/lib/egl/libGLESv2_adreno200.so:system/lib/egl/libGLESv2_adreno200.so \\
	\$(LOCAL_PATH)/lib/egl/libplayback_adreno200.so:system/lib/egl/libplayback_adreno200.so \\
	\$(LOCAL_PATH)/lib/egl/libq3dtools_adreno200.so:system/lib/egl/libq3dtools_adreno200.so \\
	\$(LOCAL_PATH)/lib/libc2d2_a3xx.so:system/lib/libc2d2_a3xx.so \\
	\$(LOCAL_PATH)/lib/libgsl.so:system/lib/libgsl.so \\
	\$(LOCAL_PATH)/lib/libllvm-a3xx.so:system/lib/libllvm-a3xx.so \\
	\$(LOCAL_PATH)/lib/libllvm-arm.so:system/lib/libllvm-arm.so \\
	\$(LOCAL_PATH)/lib/libOpenCL.so:system/lib/libOpenCL.so \\
	\$(LOCAL_PATH)/lib/libOpenVG.so:system/lib/libOpenVG.so \\
	\$(LOCAL_PATH)/lib/libsc-a2xx.so:system/lib/libsc-a2xx.so \\
	\$(LOCAL_PATH)/lib/libsc-a3xx.so:system/lib/libsc-a3xx.so
EOF

(cat << EOF) > ../../../$OUTDIR/vendor-jf-blobs.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

LOCAL_PATH:=vendor/motorola/msm8960-common/jf

# Libs from jf (Samsung Galaxy S4)
PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/lib/libc2d2_z180.so:system/lib/libc2d2_z180.so \\
    \$(LOCAL_PATH)/lib/libC2D2.so:system/lib/libC2D2.so \\
    \$(LOCAL_PATH)/lib/libdivxdrm.so:system/lib/libdivxdrm.so \\
    \$(LOCAL_PATH)/lib/libExtendedExtractor.so:system/lib/libExtendedExtractor.so \\
    \$(LOCAL_PATH)/lib/libgeofence.so:system/lib/libgeofence.so \\
    \$(LOCAL_PATH)/lib/libmmosal.so:system/lib/libmmosal.so \\
    \$(LOCAL_PATH)/lib/libmmparser.so:system/lib/libmmparser.so
EOF

(cat << EOF) > ../../../$OUTDIR/vendor-mako-blobs.mk
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/$DEVICE/setup-makefiles.sh

LOCAL_PATH:=vendor/motorola/msm8960-common/mako/lib

# libacdbloader from mako 4.2.2 must be added from
# https://dl.google.com/dl/android/aosp/qcom-mako-jdq39-c89670ca.tgz
# vidc_1080p.fw from 4.3 must be added from
# https://dl.google.com/dl/android/aosp/qcom-mako-jwr66v-30ef957c.tgz
PRODUCT_COPY_FILES += \\
    \$(LOCAL_PATH)/etc/firmware/vidc_1080p.fw:system/etc/firmware/vidc_1080p.fw \\
    \$(LOCAL_PATH)/libacdbloader.so:system/lib/libacdbloader.so
EOF
