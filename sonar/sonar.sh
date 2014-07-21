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
chown -R sonarqube:sonarqube /opt/sonarqube-${SONAR_VERSION}
lokkit --port=9000:tcp --update

echo '
#!/bin/sh
#
# rc file for SonarQube
#
# chkconfig: 345 96 10
# description: SonarQube system (www.sonarsource.org)
#
### BEGIN INIT INFO
# Provides: sonar
# Required-Start: $network
# Required-Stop: $network
# Default-Start: 3 4 5
# Default-Stop: 0 1 2 6
# Short-Description: SonarQube system (www.sonarsource.org)
# Description: SonarQube system (www.sonarsource.org)
### END INIT INFO

/usr/bin/sonar $*' > /etc/init.d/sonar

export SONAR_HOME=/opt/sonarqube
ln -s $SONAR_HOME/bin/linux-x86-64/sonar.sh /usr/bin/sonar
chmod 755 /etc/init.d/sonar
/sbin/chkconfig --add sonar
/sbin/chkconfig --level 2345 sonar on

# Start Sonar
service sonar start