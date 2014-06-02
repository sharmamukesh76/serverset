#!/bin/sh

yum -y install dos2unix
yum -y install java-1.7.0-openjdk-devel
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64" > /etc/profile.d/java.sh
