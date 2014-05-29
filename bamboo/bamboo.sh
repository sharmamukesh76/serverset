#!/bin/sh

BAMBOO_VERSION=5.5.1
MYSQL_CONNECTOR_VERSION=5.1.30

# Bamboo
/usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo
mkdir -p /opt/bamboo
chown bamboo: /opt/bamboo
cd /opt/bamboo/
wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
tar -xvf atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
ln -s atlassian-bamboo-${BAMBOO_VERSION} atlassian-bamboo
chown -R bamboo:bamboo atlassian-bamboo
mkdir -p /data/bamboo
echo "bamboo.home=/data/bamboo" >> atlassian-bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
chown -R bamboo:bamboo /data/bamboo
# echo "-Datlassian.plugins.enable.wait=300" >> atlassian-bamboo/bin/setenv.sh

# MySQL Connector
MYSQL_CONNECTOR_NAME=mysql-connector-java-${MYSQL_CONNECTOR_VERSION}
mkdir -p /opt/bamboo/atlassian-bamboo/WEB-INF/lib
chown bamboo:bamboo /opt/bamboo/atlassian-bamboo/WEB-INF/lib
cd /opt/bamboo/atlassian-bamboo/WEB-INF/lib
wget http://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_CONNECTOR_NAME}.tar.gz
tar -xzvf ${MYSQL_CONNECTOR_NAME}.tar.gz
cp ${MYSQL_CONNECTOR_NAME}/${MYSQL_CONNECTOR_NAME}-bin.jar .
chown bamboo:bamboo ${MYSQL_CONNECTOR_NAME}-bin.jar

# Start Bamboo
cd /opt/bamboo/atlassian-bamboo
bin/start-bamboo.sh