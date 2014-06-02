#!/bin/sh

STASH_VERSION=3.0.1
MYSQL_CONNECTOR_VERSION=5.1.30

# Git
mkdir -p /opt/git
cd /opt/git
wget https://git-core.googlecode.com/files/git-1.9.0.tar.gz
tar -xzvf git-1.9.0.tar.gz
cd git-1.9.0
make prefix=/usr/local all
make prefix=/usr/local install

# Stash installation
/usr/sbin/useradd --create-home --home-dir /usr/local/stash --shell /bin/bash stash
mkdir -p /opt/stash
chown stash: /opt/stash
cd /opt/stash/
wget http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-${STASH_VERSION}.tar.gz
tar -xvf atlassian-stash-${STASH_VERSION}.tar.gz
chown -R stash:stash atlassian-stash*
ln -s atlassian-stash-${STASH_VERSION} atlassian-stash
mkdir -p /data/stash
chown -R stash:stash /opt/stash/atlassian-stash/
chown -R stash:stash /data/stash
sed -i "7i STASH_HOME=\"/data/stash\"" atlassian-stash/bin/setenv.sh

# Stash service
yum -y install redhat-lsb
dos2unix /etc/init.d/stash
chmod \+x /etc/init.d/stash
/sbin/chkconfig --add stash

# MySQL Connector
MYSQL_CONNECTOR_NAME=mysql-connector-java-${MYSQL_CONNECTOR_VERSION}
cd /opt/stash/atlassian-stash/lib
wget http://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_CONNECTOR_NAME}.tar.gz
tar -xzvf ${MYSQL_CONNECTOR_NAME}.tar.gz
cp ${MYSQL_CONNECTOR_NAME}/${MYSQL_CONNECTOR_NAME}-bin.jar .
chown stash:stash ${MYSQL_CONNECTOR_NAME}-bin.jar

# Start Stash
cd /opt/stash/atlassian-stash
bin/start-stash.sh