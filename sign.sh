#!/bin/sh

. ./nextbus.env

rm -f target/*.apk
cp target/android/bin/HomeActivity-release-unsigned.apk target/AthensNextBus-unaligned.apk
jarsigner -verbose -keystore $KEYSTORE_FILE target/AthensNextBus-unaligned.apk melato || exit 1
$ANDROID_SDK_DIR/tools/zipalign -v 4 target/AthensNextBus-unaligned.apk target/AthensNextBus.apk
