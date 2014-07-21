#!/bin/sh

STASH_VERSION=3.0.1
MYSQL_CONNECTOR_VERSION=5.1.30

yum -y update
yum -y install curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-devel gcc dos2unix httpd

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
lokkit --port=7990:tcp --update
lokkit --port=7999:tcp --update
lokkit --port=80:tcp --update

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
rm -f ${MYSQL_CONNECTOR_NAME}.tar.gz
rm -rf ${MYSQL_CONNECTOR_NAME}

#HTTP Configuration
service httpd restart
/usr/sbin/setsebool httpd_can_network_connect true
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.orig
echo '<VirtualHost *:80>
  ServerName stash.mdp.es
  ProxyPass / http://stash.mdp.es:7990/ retry=0
  ProxyPassReverse / http://stash.mdp.es:7990/
  ErrorLog logs/stash.log
</VirtualHost>' >> /etc/httpd/conf/httpd.conf
service httpd restart

# Start Stash
service stash start