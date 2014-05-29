#!/bin/sh

MYSQL_VERSION=mysql-community-release-el6-5

wget http://dev.mysql.com/get/${MYSQL_VERSION}.noarch.rpm
yum -y localinstall ${MYSQL_VERSION}.noarch.rpm
yum -y install mysql-community-server
service mysqld start