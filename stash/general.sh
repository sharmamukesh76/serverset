#!/bin/sh

sudo su -
yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel gcc
yum -y install java-1.7.0-openjdk-devel
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64" > /etc/profile.d/java.sh
