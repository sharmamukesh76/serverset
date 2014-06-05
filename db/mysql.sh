#!/bin/sh

MYSQL_VERSION=mysql-community-release-el6-5

/usr/sbin/useradd --create-home --home-dir /usr/local/mysql --shell /bin/bash mysql
yum -y update

# MySQL
yum -y install mysql-server mysql
chkconfig mysqld on
service mysqld start

# DBs
mysql -e "CREATE user 'root';"
mysql -e "CREATE DATABASE stash CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'root'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'root'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE bamboo CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'root'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'root'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE user 'sonarqube';"
mysql -e "CREATE DATABASE sonarqube CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'localhost' IDENTIFIED BY 'sonarqube';"
mysql -e "FLUSH PRIVILEGES;"