#!/bin/bash

#user specified version to download
install_version=$1

download_url_bin=https://www.makemkv.com/download/old/makemkv-bin-
download_url_oss=https://www.makemkv.com/download/old/makemkv-oss-

if [ -z "$1" ];
then
#grab the contents of the latest download page
download_page_text=`wget -qO- www.makemkv.com/download | sed -e 's/<[^>]*>//g'`

#parse the results to find the latest version number
#search for string 'MakeMKV x.xx.x for Windows' and extract the version number
search_string=`echo ${download_page_text} | grep -o "MakeMKV [0-9]\{1\}\.\?[0-9]\{2\}.\?[0-9]\{1\} for Windows"`

#grab the latest version from the search string
latest_version=`set -- $search_string; echo $2`
latest_version_print="${latest_version} is the latest version!"
echo ${latest_version_print}
install_version=${latest_version}
download_url_bin=https://www.makemkv.com/download/makemkv-bin-
download_url_oss=https://www.makemkv.com/download/makemkv-oss-
fi

#if user specifies 1.15.4 the installer should fall back to 
#1.15.3 for the makemkv-oss version because of bugs, bugs, bugs
#https://makemkv.com/forum/viewtopic.php?f=3&t=23933
bin_version=${install_version}
oss_version=${install_version}

if [ ${install_version} = 1.15.4 ];
then
echo '\nFalling back to 1.15.3 for makemkv-oss because of a compiler issue with 1.15.4'
sleep 3s
oss_version=1.15.3
download_url_oss=https://www.makemkv.com/download/old/makemkv-oss-
fi

makemkv_bin_tarball=makemkv-bin-${bin_version}.tar.gz
makemkv_oss_tarball=makemkv-oss-${oss_version}.tar.gz

makemkv_bin_url=${download_url_bin}${bin_version}.tar.gz
makemkv_oss_url=${download_url_oss}${oss_version}.tar.gz

makemkv_bin_makefile_location=./makemkv-bin/makemkv-bin-${bin_version}
makemkv_oss_makefile_location=./makemkv-oss/makemkv-oss-${oss_version}

#install dependencies
echo '\n\nInstalling dependencies'
sleep 3s
apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev qtbase5-dev zlib1g-dev

#delete both MakeMKV folders
rm -rf makemkv-bin
rm -rf makemkv-oss

#create temp folders for each source download
mkdir ./makemkv-bin
mkdir ./makemkv-oss

#download MakeMKV-bin and MakeMKV-oss zips
echo '\n\nDownloading and unpacking source'
sleep 3s
wget -O ./makemkv-bin/${makemkv_bin_tarball} ${makemkv_bin_url}

wget -O ./makemkv-oss/${makemkv_oss_tarball} ${makemkv_oss_url}

#extract both zips to their own directories
tar xzf ./makemkv-bin/${makemkv_bin_tarball} -C ./makemkv-bin
tar xzf ./makemkv-oss/${makemkv_oss_tarball} -C ./makemkv-oss

#make and install MakeMKV-bin
echo '\n\nStarting install'
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

echo '\n\nThe installer has finished and all files have been cleaned up. :)'
