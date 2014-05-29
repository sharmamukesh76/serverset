Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

To create a virtual machine with CentOS and MySQL execute following from this directory:

```bash
vagrant up
```

Check that service is up an running by executing:

```bash
service mysqld status
```

Please consult [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) for more information.

Production environment
----------------------

Execute mysql.sh:

```bash
sudo su -
./mysql.sh
```

Check that service is up an running by executing:

```bash
service mysqld status
```
