#!/bin/bash
cd /opt
wget -O splunk.tar.gz https://download.splunk.com/products/splunk/releases/8.0.1/linux/splunk-8.0.1-6db836e2fb9e-Linux-x86_64.tgz
tar -xvf splunk.tar.gz
rm splunk.tar.gz
echo -e '[default]\nhttpport = 8000\n\n[settings]\nenableSplunkWebSSL = 1' > /opt/splunk/etc/system/local/web.conf
echo -e '[diskUsage]\nminFreeSpace = 500' >> /opt/splunk/etc/system/local/server.conf
echo -e '[main]\nmaxTotalDataSizeMB = 5000' >> /opt/splunk/etc/system/local/indexes.conf
/opt/splunk/bin/splunk --accept-license enable boot-start
/opt/splunk/bin/splunk start

