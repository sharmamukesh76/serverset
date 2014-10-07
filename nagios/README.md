Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

Virtual machine contains following:
* CentOS
* NagiosXI
* NSCA

To create the virtual machine execute following from this directory:

```bash
vagrant up
```

Vagrant will output the IP and port that can be used to access the machine (PUTTY?). By default the address is 127.0.0.1:2222.

Setup
-----

* http://assets.nagios.com/downloads/nagiosxi/docs/Using-and-Configuring-NSCA-With-Nagios-XI.pdf
* http://nagios.sourceforge.net/download/contrib/documentation/misc/NSCA_Setup.pdf

Testing
-------

```bash
cd /opt/nsca
./bin/send_nsca localhost -c config/send_nsca.cfg < messages/ok
./bin/send_nsca localhost -c config/send_nsca.cfg < messages/warning
./bin/send_nsca localhost -c config/send_nsca.cfg < messages/critical
```

TODO
----

* Include configuration into scripts

