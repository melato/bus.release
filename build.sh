#!/bin/sh

. ./nextbus.env

update_map_key()
{
  sed 's/android:apiKey=.*/android:apiKey="'$MAP_KEY'"/' \
  	projects/bus.android/res/layout/map.xml > target/android/res/layout/map.xml
}

copy_source() {
	mkdir -p target/android/src
	rsync -a -v --exclude=.git projects/bus.android/ target/android
	for project in gpx geometry bus
	do
		rsync -a -v projects/$project/src/main/java/ target/android/src
	done
}

compile() {
	cd target/android
	android update project --path `pwd` --subprojects --target 'Google Inc.:Google APIs:19' --subprojects -l ../melato.android.lib
	ant release
}

rm -rf target/android
copy_source
update_map_key
compile
