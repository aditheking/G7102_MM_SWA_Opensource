#!/bin/bash

export ARCH=arm
export CROSS_COMPILE=~/working/kernel/arm-eabi-4.8/bin/arm-eabi-
OUT_DIR=output
rm -rf $OUT_DIR
mkdir $OUT_DIR

make -C $(pwd) O=$OUT_DIR msm8226-sec_ms013g_defconfig SELINUX_DEFCONFIG=selinux_defconfig
time make -C $(pwd) O=$OUT_DIR -j$1

tools/dtbTool -s 2048 -o output/arch/arm/boot/dt.img -p output/scripts/dtc/ output/arch/arm/boot/

cp -v output/arch/arm/boot/Image $(pwd)/arch/arm/boot/zImage

OUT_MODU=~/working/output/modules
rm -rf $OUT_MODU
mkdir $OUT_MODU
find ./ -name "*.ko" -exec cp -fv {} $OUT_MODU \;
