#!/bin/bash


version="2024.1.1.11"

cd /opt
wget https://redirector.gvt1.com/edgedl/android/studio/ide-zips/${version}/android-studio-${version}-linux.tar.gz
tar xzvf ./android-studio-${version}-linux.tar.gz
rm -rf ./android-studio-${version}-linux.tar.gz

nohup bash /opt/android-studio/bin/studio.sh&

echo 'export ANDROID_HOME=$HOME/Android/Sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
