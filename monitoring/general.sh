#!/bin/sh

sudo yum -y update
sudo yum -y install dos2unix
sudo yum -y install java-1.7.0-openjdk-devel
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64" > /etc/profile.d/java.sh
sudo yum -y install telnet
sudo yum -y install tomcat6 tomcat6-webapps tomcat6-admin-webapps
sudo echo "CATALINA_HOME=\"/var/lib/tomcat6\"; export CATALINA_HOME" >>/etc/profile
sudo chkconfig tomcat6 on
sudo service tomcat6 start