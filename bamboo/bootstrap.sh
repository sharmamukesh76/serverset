#!/bin/sh

BAMBOO_VERSION=5.5.1

# General
sudo su -
/usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo

# JDK 7
yum -y install java-1.7.0-openjdk-devel
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64" > /etc/profile.d/java.sh

# Bamboo
mkdir -p /opt/bamboo
chown bamboo: /opt/bamboo
cd /opt/bamboo/
wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
tar -xvf atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
ln -s atlassian-bamboo-${BAMBOO_VERSION} atlassian-bamboo
mkdir -p /data/bamboo
echo "bamboo.home=/data/bamboo" >> atlassian-bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
# echo "-Datlassian.plugins.enable.wait=300" >> atlassian-bamboo/bin/setenv.sh
cd atlassian-bamboo
bin/start-bamboo.sh