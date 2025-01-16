# The following article is an explanation of how to deploy SentinelOne to a MAC using Intune and also do some configurations

First step will be to install sentinel 1, for this method we will be utilizing an azure storage account to host the .PKG file. I will admit that you can do this without a storage account and do this within Application Deployment but by utilizing this method the deployment in some ways is more efficient.

You will need an install [script](https://github.com/edtechjeff/edtechjeff/blob/main/HowTo/Intune/SentinelOneMAC/InstallSentinel.sh).

Now you will need to edit the file to reflect your instance of SentinelOne

############################################################################################################################

#!/bin/sh
siteToken="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
installerurl="https://yourstorageaccount.blob.core.windows.net/test/Sentinel-Release-24-2-2-7632_macos_v24_2_2_7632.pkg"
installer="Sentinel-Release-24-2-2-7632_macos_v24_2_2_7632.pkg"
dir="/tmp/"
tokenfile="com.sentinelone.registration-token"

if [ -d /Applications/SentinelOne/ ];
then
  echo "SentinelOne is already Installed"
  exit 0

else
#Download installer into tmp directory
curl -L -o $dir$installer $installerurl

#Create Site Token File
echo $siteToken > $dir$tokenfile

#Install Agent
/usr/sbin/installer -pkg $dir$installer -target /

#Cleanup token file
rm -f $dir$tokenfile
fi

############################################################################################################################


If you do not have it configured on the MAC correctly you will get some messages. See below as an example



If you want to avoid having this issue this is what you can do. 

Now