#!/bin/sh

LOGSTASH=logstash-1.4.2
ELASTIC_SEARCH=elasticsearch-1.1.1
KIBANA=kibana-3.1.0

# PostGreSQL
cd /tmp
curl -O  http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
#yum -y install postgresql postgresql-server.x86_64 postgresql-libs python-psycopg2
sudo sudo rpm -ivh pgdg*
sudo yum -y install postgresql94-server
sudo service postgresql-9.4 initdb
sudo chkconfig postgresql-9.4 on
sudo service postgresql-9.4 start
sudo -u postgres psql -c "CREATE USER graphite WITH PASSWORD 'welcome';"
sudo -u postgres psql -c "CREATE DATABASE graphite WITH OWNER graphite;"

# LogStash
cd /opt/
curl -O https://download.elasticsearch.org/logstash/logstash/${LOGSTASH}.tar.gz
tar -zxvf $LOGSTASH.tar.gz
rm -f ${LOGSTASH}.tar.gz
ln -s $LOGSTASH logstash
cd logstash
mkdir conf
cp /vagrant/logstash-simple.conf conf/.
cp /vagrant/logstash-apache.conf conf/.
cp /vagrant/logstash-syslog.conf conf/.
cp /vagrant/access_log /tmp/.

# elasticsearch
cd /opt/
curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/${ELASTIC_SEARCH}.tar.gz
tar -zxvf $ELASTIC_SEARCH.tar.gz
rm -f ${ELASTIC_SEARCH}.tar.gz
ln -s $ELASTIC_SEARCH elasticsearch
cd elasticsearch
bin/plugin -install lmenezes/elasticsearch-kopf
mkdir -p /opt/elasticsearch/logs
nohup ./bin/elasticsearch > logs/elasticsearch.log 2>&1 &

# Kibana
cd ${CATALINA_HOME}/webapps
curl -O https://download.elasticsearch.org/kibana/kibana/${KIBANA}.tar.gz
tar -zxvf ${KIBANA}.tar.gz
rm -f ${KIBANA}.tar.gz
ln -s ${KIBANA} kibana

## Graphite
#cd /tmp
#curl -o epel.rpm -L http://download.fedoraproject.org/pub/epel/6/$(arch)/epel-release-6-8.noarch.rpm
#sudo rpm -ivh epel.rpm
#sudo yum -y install pycairo Django14 python-ldap python-memcached python-sqlite2 bitmap bitmap-fonts-compat
#sudo yum -y install python-devel python-crypto pyOpenSSL gcc python-zope-filesystem python-zope-interface git gcc-c++
#sudo yum -y install zlib-static MySQL-python python-txamqp python-setuptools python-psycopg2 mod_wsgi
### TODO: Continue from bitmap-miscfixed-fonts-0.3-15.el6.noarch
#
#
#rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#yum -y install graphite-web python-carbon python-whisper
#sudo sed -i "s/#SECRET_KEY = 'UNSAFE_DEFAULT'/SECRET_KEY = 'I_HAVE_NO_SECRETS'/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#USE_REMOTE_USER_AUTHENTICATION = True/USE_REMOTE_USER_AUTHENTICATION = True/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#DATABASES = {/DATABASES = {/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#    'default': {/    'default': {/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#        'NAME': '\/opt\/graphite\/storage\/graphite.db',/        'NAME': 'graphite',/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#        'ENGINE': 'django.db.backends.sqlite3',/        'ENGINE': 'django.db.backends.postgresql_psycopg2',/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#        'USER': '',/        'USER': 'graphite',/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#        'PASSWORD': '',/        'PASSWORD': 'welcome',/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#        'HOST': '',/        'HOST': '127.0.0.1',/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#        'PORT': ''/        'PORT': ''/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#    }/    }/g" /etc/graphite-web/local_settings.py
#sudo sed -i "s/#}/}/g" /etc/graphite-web/local_settings.py
### TODO: Continue from https://www.digitalocean.com/community/tutorials/how-to-install-and-use-graphite-on-an-ubuntu-14-04-server
