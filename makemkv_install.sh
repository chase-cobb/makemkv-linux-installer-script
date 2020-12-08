#!/bin/bash

#user specified version to download
user_defined_version=$1

makemkv_bin_tarball=makemkv-bin-${user_defined_version}.tar.gz
makemkv_oss_tarball=makemkv-oss-${user_defined_version}.tar.gz

makemkv_bin_url=https://www.makemkv.com/download/makemkv-bin-${user_defined_version}.tar.gz
makemkv_oss_url=https://www.makemkv.com/download/makemkv-oss-${user_defined_version}.tar.gz

makemkv_bin_makefile_location=./makemkv-bin/makemkv-bin-${user_defined_version}
makemkv_oss_makefile_location=./makemkv-oss/makemkv-oss-${user_defined_version}

#install dependencies
echo "Installing dependencies"
sleep 3s
apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev

#create temp folders for each source download
mkdir ./makemkv-bin
mkdir ./makemkv-oss

#download MakeMKV-bin and MakeMKV-oss zips
echo "Downloading and unpacking source"
sleep 3s
wget -O ./makemkv-bin/${makemkv_bin_tarball} ${makemkv_bin_url}

wget -O ./makemkv-oss/${makemkv_oss_tarball} ${makemkv_oss_url}

#extract both zips to their own directories
tar xzf ./makemkv-bin/${makemkv_bin_tarball} -C ./makemkv-bin
tar xzf ./makemkv-oss/${makemkv_oss_tarball} -C ./makemkv-oss

#make and install MakeMKV-bin
echo "Starting install"
sleep 3s
cd ${makemkv_bin_makefile_location}
./configure
make
make install
cd ../..

#make and install MakeMKV-oss
cd ${makemkv_oss_makefile_location}
./configure
make
make install
cd ../..

#delete both MakeMKV folders
rm -rf makemkv-bin
rm -rf makemkv-oss
