#!/bin/bash

ANDROID_STUDIO_VERSION=1.2.1.1
ANDROID_STUDIO_BUILD=141.1903250
ANDROID_STUDIO_FILE=android-studio-ide-$ANDROID_STUDIO_BUILD-linux.zip

ANDROID_SDK_VERSION=r24.2
ANDROID_SDK_FILE=android-sdk_$ANDROID_SDK_VERSION-linux.tgz

echo " install a better terminal emulator"
sudo apt-get -y install lxterminal 

# https://stackoverflow.com/questions/28847151/unable-to-install-android-studio-in-ubuntu
echo " Fix 'Unable to run mksdcard SDK tool' issue"
sudo apt-get -y install lib32stdc++6

echo " install java7"
sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
sudo apt-get update
# accept the license agreement
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java7-installer

# make a place to install development tools
mkdir -p ~/dev/tools
cd ~/dev/tools

# download and unpack android-studio
wget https://dl.google.com/dl/android/studio/ide-zips/$ANDROID_STUDIO_VERSION/$ANDROID_STUDIO_FILE 
unzip $ANDROID_STUDIO_FILE
rm $ANDROID_STUDIO_FILE

# create a launcher for android-studio
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Android-Studio
Comment=
Exec=/home/vagrant/dev/tools/android-studio/bin/studio.sh
Icon=/home/vagrant/dev/tools/android-studio/bin/studio.png
Path=/home/vagrant/dev/tools/android-studio
Terminal=false
StartupNotify=false
GenericName=" >> /home/vagrant/Desktop/Android-Studio.desktop

# download android sdk
wget http://dl.google.com/android/$ANDROID_SDK_FILE
tar -zxf $ANDROID_SDK_FILE
rm $ANDROID_SDK_FILE

# install android sdk extras to get google libs
ANDROID=/home/vagrant/dev/tools/android-sdk-linux/tools/android
echo y | $ANDROID update sdk --no-ui --filter extra

