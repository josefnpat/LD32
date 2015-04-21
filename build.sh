#!/bin/bash

SRC="src"
NAME="dinobros"
VERSION=0.9.1

`sh ./gengit.sh $SRC`
GIT=`sh ./git.sh $SRC`
GIT_COUNT=`sh ./git_count.sh $SRC`

# Cleanup
rm builds/*
mkdir -p builds

# *.love
INFO=v${GIT_COUNT}-\[${GIT}\]
BIN_NAME=${NAME}_${INFO}
LOVE="builds/${BIN_NAME}.love"

cd $SRC

zip -r ../$LOVE *
cd ..

# Temp Space
mkdir tmp

# Windows 32 bit
cat dev/build_data/love-$VERSION\-win32/love.exe $LOVE > tmp/${BIN_NAME}.exe
cp dev/build_data/love-$VERSION\-win32/*.dll tmp/
cd tmp
zip -r ../builds/${NAME}_win32_${INFO}.zip *
cd ..
rm tmp/* -rf #tmp cleanup

# Windows 64 bit
cat dev/build_data/love-$VERSION\-win64/love.exe $LOVE > tmp/${BIN_NAME}.exe
cp dev/build_data/love-$VERSION\-win64/*.dll tmp/
cd tmp
zip -r ../builds/${NAME}_win64_${INFO}.zip *
cd ..
rm tmp/* -rf #tmp cleanup

# OS X
cp dev/build_data/love.app tmp/${BIN_NAME}.app -Rv
cp dev/build_data/macosx-64-Info.plist tmp/${BIN_NAME}.app/Contents/Info.plist
sed -i "s/%%GIT%%/${GIT}/" tmp/${BIN_NAME}.app/Contents/Info.plist
cp $LOVE tmp/${BIN_NAME}.app/Contents/Resources/${BIN_NAME}.love
cp dev/build_data/icons/Game.icns tmp/${BIN_NAME}.app/Contents/Resources/
cd tmp
zip -ry ../builds/${NAME}_macosx_${INFO}.zip ${BIN_NAME}.app
cd ..
rm tmp/* -rf #tmp cleanup

# LINUX
mkdir tmp/${NAME}
cp dev/build_data/${NAME}-run.sh tmp/${NAME}/
cp ${LOVE} tmp/${NAME}/
cp dev/build_data/icons/Game.png tmp/${NAME}/icon.png
cd tmp
tar czvf ../builds/${NAME}_linux_${INFO}.tgz ${NAME}
cd ..
rm tmp/* -rf #tmp cleanup

# ARCH LINUX

# set up aur
mkdir tmp/${NAME}
cp dev/build_data/aur/${NAME}/* tmp/${NAME}/ -Rv

# make aur zip data
mkdir tmp/${NAME}_zip
cp $LOVE tmp/${NAME}_zip/${NAME}_${GIT_COUNT}.love
cp dev/build_data/aur/README tmp/${NAME}_zip/README
cd tmp/${NAME}_zip/
zip -r ../${NAME}/${NAME}_${GIT_COUNT}.love.zip *
cd ../..

# create aur
ZIP_SHA=`sha1sum tmp/${NAME}/${NAME}_${GIT_COUNT}.love.zip | awk '{ print $1 }'`
sed -i "s/%%ZIP_SHA%%/${ZIP_SHA}/" tmp/${NAME}/PKGBUILD
cd tmp/
tar czvf ../builds/${NAME}_aur_${INFO}.tar.gz ${NAME}
cd ..

rm tmp/* -rf #tmp cleanup

# DEBIAN/UBUNTU

# Cleanup
rm tmp -rf
