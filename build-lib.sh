#!/bin/sh

. ./nextbus.env

copy_libs() {
	mkdir target/melato.android.lib/libs
	cp $ANDROID_SDK_DIR/extras/android/support/v4/android-support-v4.jar target/melato.android.lib/libs
}

copy_source() {
	mkdir -p target
	rsync -a -v --exclude=.git projects/melato.android.lib target
	for dir in projects/gps projects/util projects/xml projects/progress
	do
	rsync -a -v $dir/src/main/java/ target/melato.android.lib/src
	done
}

compile() {
	cd target/melato.android.lib
	android update project --path `pwd` --target android-19 --subprojects
	ant release
}

rm -rf target/melato.android.lib
copy_source
copy_libs
compile
