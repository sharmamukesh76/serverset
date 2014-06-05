#!/bin/sh

SONAR_VERSION=4.3
DB_IP=192.168.0.42

yum -y update

# Install Sonar
/usr/sbin/useradd --create-home --home-dir /usr/local/sonarqube --shell /bin/bash sonarqube
mkdir -p /opt
cd /opt
wget http://dist.sonar.codehaus.org/sonarqube-${SONAR_VERSION}.zip
unzip sonarqube-${SONAR_VERSION}.zip
ln -s sonarqube-${SONAR_VERSION} sonarqube
sed -i 's/sonar.jdbc.username=sonar/sonar.jdbc.username=sonarqube/g' sonarqube/conf/sonar.properties
sed -i 's/sonar.jdbc.password=sonar/sonar.jdbc.password=sonarqube/g' sonarqube/conf/sonar.properties
sed -i 's/sonar.jdbc.url=jdbc:h2:tcp:\/\/localhost:9092\/sonar/# sonar.jdbc.url=jdbc:h2:tcp:\/\/localhost:9092\/sonar/g' sonarqube/conf/sonar.properties
sed -i 's/#sonar.jdbc.url=jdbc:mysql:\/\/localhost:3306\/sonar?useUnicode=true\&characterEncoding=utf8\&rewriteBatchedStatements=true/sonar.jdbc.url=jdbc:mysql:\/\/'${DB_IP}':3306\/sonarqube?useUnicode=true\&characterEncoding=utf8\&rewriteBatchedStatements=true/g' sonarqube/conf/sonar.properties
sed -i 's/#wrapper.java.additional.7=-server/wrapper.java.additional.7=-server/g' sonarqube/conf/wrapper.conf
sed -i 's/wrapper.java.command=java/wrapper.java.command=\/usr\/lib\/jvm\/java-1.7.0-openjdk.x86_64\/bin\/java/g' sonarqube/conf/wrapper.conf
rm -f sonarqube-${SONAR_VERSION}.zip
chown -R sonarqube:sonarqube /opt/sonarqube
lokkit --port=9000:tcp --update

# Start Sonar
/opt/sonarqube/bin/linux-x86-64/sonar.sh start