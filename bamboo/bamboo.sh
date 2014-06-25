#!/bin/sh

BAMBOO_VERSION=5.5.1
MYSQL_CONNECTOR_VERSION=5.1.30
MAVEN3_VERSION=3.2.1
GRADLE_VERSION=1.12
SONAR_RUNNER_VERSION=2.4
SONAR_IP=192.168.0.43
SONAR_DB_IP=192.168.0.42

yum -y update

# Bamboo installation
/usr/sbin/useradd --create-home --home-dir /usr/local/bamboo --shell /bin/bash bamboo
mkdir -p /opt/bamboo
chown bamboo: /opt/bamboo
cd /opt/bamboo/
wget http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
tar -xvf atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
rm -f atlassian-bamboo-${BAMBOO_VERSION}.tar.gz
ln -s atlassian-bamboo-${BAMBOO_VERSION} atlassian-bamboo
chown -R bamboo:bamboo atlassian-bamboo
mkdir -p /data/bamboo
echo "bamboo.home=/data/bamboo" >> atlassian-bamboo/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
chown -R bamboo:bamboo /opt/bamboo/atlassian-bamboo/
chown -R bamboo:bamboo /data/bamboo
# echo "-Datlassian.plugins.enable.wait=300" >> atlassian-bamboo/bin/setenv.sh
lokkit --port=8085:tcp --update

# Bamboo service
dos2unix /etc/init.d/bamboo
chmod \+x /etc/init.d/bamboo
/sbin/chkconfig --add bamboo

# MySQL Connector
MYSQL_CONNECTOR_NAME=mysql-connector-java-${MYSQL_CONNECTOR_VERSION}
mkdir -p /opt/bamboo/atlassian-bamboo/WEB-INF/lib
chown bamboo:bamboo /opt/bamboo/atlassian-bamboo/WEB-INF/lib
cd /opt/bamboo/atlassian-bamboo/lib
wget http://dev.mysql.com/get/Downloads/Connector-J/${MYSQL_CONNECTOR_NAME}.tar.gz
tar -xzvf ${MYSQL_CONNECTOR_NAME}.tar.gz
cp ${MYSQL_CONNECTOR_NAME}/${MYSQL_CONNECTOR_NAME}-bin.jar .
chown bamboo:bamboo ${MYSQL_CONNECTOR_NAME}-bin.jar
rm -rf ${MYSQL_CONNECTOR_NAME}
rm -rf ${MYSQL_CONNECTOR_NAME}.tar.gz

#Gradle
cd /opt
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip
unzip gradle-${GRADLE_VERSION}-all.zip
ln -s gradle-${GRADLE_VERSION} gradle
echo "export GRADLE_HOME=/opt/gradle
export PATH=\$GRADLE_HOME/bin:\$PATH" > /etc/profile.d/gradle.sh
rm -rf gradle-${GRADLE_VERSION}-all.zip

# Maven
cd /usr/local
wget http://apache.rediris.es/maven/maven-3/${MAVEN3_VERSION}/binaries/apache-maven-${MAVEN3_VERSION}-bin.tar.gz
tar -xzvf apache-maven-${MAVEN3_VERSION}-bin.tar.gz
ln -s apache-maven-${MAVEN3_VERSION} apache-maven
rm -f apache-maven-${MAVEN3_VERSION}-bin.tar.gz
echo "export M2_HOME=/usr/local/apache-maven
export M2=\$M2_HOME/bin
export PATH=\$M2:\$PATH" > /etc/profile.d/maven.sh

# Sonar runner
cd /opt
wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/${SONAR_RUNNER_VERSION}/sonar-runner-dist-${SONAR_RUNNER_VERSION}.zip
unzip sonar-runner-dist-${SONAR_RUNNER_VERSION}.zip
ln -s sonar-runner-${SONAR_RUNNER_VERSION} sonar-runner
sed -i 's/#sonar.host.url=http:\/\/localhost:9000/sonar.host.url=http:\/\/'${SONAR_IP}':9000/g' /opt/sonar-runner/conf/sonar-runner.properties
sed -i 's/#sonar.jdbc.url=jdbc:mysql:\/\/localhost:3306\/sonar?useUnicode=true\&amp\;characterEncoding=utf8/sonar.jdbc.url=jdbc:mysql:\/\/'${SONAR_DB_IP}':3306\/sonar?useUnicode=true\&amp\;characterEncoding=utf8/g' /opt/sonar-runner/conf/sonar-runner.properties
sed -i 's/#sonar.jdbc.username=sonar/sonar.jdbc.username=sonarqube/g' /opt/sonar-runner/conf/sonar-runner.properties
sed -i 's/#sonar.jdbc.password=sonar/sonar.jdbc.password=sonarqube/g' /opt/sonar-runner/conf/sonar-runner.properties
echo "export SONAR_RUNNER_HOME=/opt/sonar-runner
export PATH=\$SONAR_RUNNER_HOME/bin:\$PATH" > /etc/profile.d/sonar-runner.sh
rm sonar-runner-dist-${SONAR_RUNNER_VERSION}.zip


# Start Bamboo
service bamboo start