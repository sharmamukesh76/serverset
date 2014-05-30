#!/bin/sh

MYSQL_VERSION=mysql-community-release-el6-5

/usr/sbin/useradd --create-home --home-dir /usr/local/mysql --shell /bin/bash mysql

# MySQL
wget http://dev.mysql.com/get/${MYSQL_VERSION}.noarch.rpm
yum -y localinstall ${MYSQL_VERSION}.noarch.rpm
yum -y install mysql-community-server
service mysqld start

# DBs
mysql -e "CREATE DATABASE stash CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'admin'@'stash' IDENTIFIED BY 'welcome'; FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE bamboo CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'admin'@'bamboo' IDENTIFIED BY 'welcome'; FLUSH PRIVILEGES;"