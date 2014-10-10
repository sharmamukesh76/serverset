#!/bin/sh

LOGSTASH=logstash-1.4.2
ELASTIC_SEARCH=elasticsearch-1.1.1
KIBANA=kibana-3.1.0
NSCA=nsca-2.7.2
NAGIOS_HOST=localhost

# LogStash
cd /opt/
sudo curl -O https://download.elasticsearch.org/logstash/logstash/${LOGSTASH}.tar.gz
sudo tar -zxvf $LOGSTASH.tar.gz
sudo rm -f ${LOGSTASH}.tar.gz
sudo ln -s $LOGSTASH logstash
cd logstash
sudo mkdir conf
sudo cp /vagrant/logstash-simple.conf conf/.
sudo cp /vagrant/logstash-apache.conf conf/.
sudo cp /vagrant/logstash-syslog.conf conf/.
sudo cp /vagrant/logstash-nagios.conf conf/.
sudo cp /vagrant/logstash-log4j.conf conf/.
sudo cp -f /vagrant/grok-patterns patterns/.
sudo cp /vagrant/access_log /tmp/.

# NSCA
cd /opt
sudo wget http://prdownloads.sourceforge.net/sourceforge/nagios/${NSCA}.tar.gz
sudo tar -xzf ${NSCA}.tar.gz
sudo ln -s ${NSCA} nsca
cd nsca
sudo ./configure
sudo make all
sudo mkdir bin
sudo cp src/nsca bin/.
sudo cp src/send_nsca bin/.
sudo mkdir config
sudo cp sample-config/nsca.cfg config/.
sudo cp sample-config/send_nsca.cfg config/.
sudo chown -R nagios:nagios bin
sudo chown -R nagios:nagios config
sudo mkdir messages
sudo chmod 777 messages
echo -e "${NAGIOS_HOST}       TestMessage2    0       This is NOT an error message

" >messages/ok
echo -e "${NAGIOS_HOST}       TestMessage2    1       This is critical message

" >messages/warning
echo -e "${NAGIOS_HOST}       TestMessage2    2       This is error message

" >messages/critical

# elasticsearch
cd /opt/
curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/${ELASTIC_SEARCH}.tar.gz
sudo tar -zxvf $ELASTIC_SEARCH.tar.gz
sudo rm -f ${ELASTIC_SEARCH}.tar.gz
sudo ln -s $ELASTIC_SEARCH elasticsearch
cd elasticsearch
sudo bin/plugin -install lmenezes/elasticsearch-kopf
sudo mkdir -p /opt/elasticsearch/logs
sudo nohup ./bin/elasticsearch > logs/elasticsearch.log 2>&1 &

# Kibana
cd ${CATALINA_HOME}/webapps
sudo curl -O https://download.elasticsearch.org/kibana/kibana/${KIBANA}.tar.gz
sudo tar -zxvf ${KIBANA}.tar.gz
sudo rm -f ${KIBANA}.tar.gz
sudo ln -s ${KIBANA} kibana
