#!/bin/sh

yum -y install dos2unix
yum -y install java-1.7.0-openjdk-devel
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64" > /etc/profile.d/java.sh
yum -y install telnet
yum -y install tomcat6 tomcat6-webapps tomcat6-admin-webapps
echo "CATALINA_HOME=\"/var/lib/tomcat6\"; export CATALINA_HOME" >>/etc/profile
chkconfig tomcat6 on
service tomcat6 start