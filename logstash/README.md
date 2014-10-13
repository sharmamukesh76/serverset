Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

Virtual machine contains following:
* CentOS
* [LogStash](http://logstash.net/)
* [elastisearch](http://www.elasticsearch.org/overview/elasticsearch/) with [kopf plugin](https://github.com/lmenezes/elasticsearch-kopf)
* [Nagios XI](http://www.nagios.com/products/nagiosxi)

To create the virtual machine execute following from this directory:

```bash
vagrant up
```

Vagrant will output the IP and port that can be used to access the machine (PUTTY?). By default the address is 127.0.0.1:2222.

STDIN to STDOUT
---------------

Output STDIN to elastisearch and STDOUT:

```bash
cd /opt/logstash
bin/logstash -f conf/logstash-simple.conf
curl 'http://localhost:9200/_search?pretty'
```

To see elastisearch data using kopf open [http://127.0.0.1:9200/_plugin/kopf](http://127.0.0.1:9200/_plugin/kopf).

To delete elastisearch logstash data:

```bash
curl -XDELETE 'http://localhost:9200/logstash-*'
```

Apache logs to STDOUT
---------------------

Output contents of a log file using filters to elastisearch and STDOUT: 

```bash
cd /opt/logstash
bin/logstash -f conf/logstash-apache.conf
```

SysLog to ElasticSearch and STDOUT
----------------------------------

Output syslog from port 5000 to elasticsearch and STDOUT:

```bash
cd /opt/logstash
bin/logstash -f conf/logstash-syslog.conf
# From a separate session
telnet localhost 5000
# Copy and paste following text to the telnet session:
# Dec 23 12:11:43 louis postfix/smtpd[31499]: connect from unknown[95.75.93.154]
# Dec 23 14:42:56 louis named[16000]: client 199.48.164.7#64817: query (cache) 'amsterdamboothuren.com/MX/IN' denied
# Dec 23 14:30:01 louis CRON[619]: (www-data) CMD (php /usr/share/cacti/site/poller.php >/dev/null 2>/var/log/cacti/poller-error.log)
# Dec 22 18:28:06 louis rsyslogd: [origin software="rsyslogd" swVersion="4.2.0" x-pid="2253" x-info="http://www.rsyslog.com"] rsyslogd was HUPed, type 'lightweight'.
```

To see the dashboard with data from elasticsearch using Kibana open [http://127.0.0.1:8080/kibana](http://127.0.0.1:8080/kibana).

STDIN to NSCA and STDOUT
------------------------

To try NSCA:

```bash
cd /opt/nsca
sudo ./bin/send_nsca ${NAGIOS_HOST} -c config/send_nsca.cfg < messages/ok
```

Output STDIN to NSCA and STDOUT:

```bash
cd /opt/logstash
bin/logstash -f conf/logstash-log4j.conf
```

Add entries to /tmp/log4j.log or paste them to STDIN.

To see the results in Nagios XI, open [http://localhost/nagiosxi/](http://localhost/nagiosxi/).

To see the results in ElasticSearch, run following.

```bash
curl 'http://localhost:9200/_search?pretty'
```

To see the dashboard with data from elasticsearch using Kibana open [http://127.0.0.1:8080/kibana](http://127.0.0.1:8080/kibana).

More info:

* [Using-and-Configuring-NSCA-With-Nagios-XI.pdf](http://assets.nagios.com/downloads/nagiosxi/docs/Using-and-Configuring-NSCA-With-Nagios-XI.pdf)
* [NSCA_Setup.pdf](http://nagios.sourceforge.net/download/contrib/documentation/misc/NSCA_Setup.pdf)