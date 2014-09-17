#!/bin/sh

LOGSTASH=logstash-1.4.2
ELASTIC_SEARCH=elasticsearch-1.1.1
KIBANA=kibana-3.1.0

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