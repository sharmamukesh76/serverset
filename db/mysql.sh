#!/bin/sh

/usr/sbin/useradd --create-home --home-dir /usr/local/mysql --shell /bin/bash mysql
yum -y update

# MySQL
yum -y install mysql-server mysql
chkconfig mysqld on
service mysqld start

lokkit --port=3306:tcp --update

# DBs
mysql -e "CREATE user 'root';"
mysql -e "CREATE user 'alm';"
mysql -e "CREATE DATABASE jira CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'alm'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'alm'@'%' IDENTIFIED BY 'mdp@2014';"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'alm'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'alm'@'localhost' IDENTIFIED BY 'mdp@2014';"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'root'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'root'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON jira.* TO 'root'@'localhost' IDENTIFIED BY 'mdp@2014';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE stash CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'root'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'root'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'alm'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON stash.* TO 'alm'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE bamboo CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'root'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'root'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'root'@'CIPRD04.dmdp';"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'alm'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'alm'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON bamboo.* TO 'alm'@'CIPRD04.dmdp';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE user 'sonarqube';"
mysql -e "CREATE DATABASE sonarqube CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'localhost' IDENTIFIED BY 'sonarqube';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'sonarqube'@'CIPRD04.dmdp' IDENTIFIED BY 'sonarqube';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'alm'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'alm'@'localhost';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'alm'@'localhost' IDENTIFIED BY 'sonarqube';"
mysql -e "GRANT ALL PRIVILEGES ON sonarqube.* TO 'alm'@'CIPRD04.dmdp' IDENTIFIED BY 'sonarqube';"
mysql -e "FLUSH PRIVILEGES;"