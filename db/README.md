Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

To create a virtual machine with CentOS and MySQL execute following from this directory:

```bash
vagrant up
```

Check that the service is up an running by executing (from inside the VM):

```bash
service mysqld status
```

Tables are created for stash and bamboo.
All tables have full privileges given to the user admin.

For more information please consult:

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Installing MySQL on Linux Using the MySQL Yum Repository](http://dev.mysql.com/doc/mysql-repo-excerpt/5.6/en/linux-installation-yum-repo.html)
* [Connecting Bamboo to an external database > MySQL 5.1](https://confluence.atlassian.com/display/BAMBOO/MySQL+5.1)
* [Connecting Stash to MySQL](https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+MySQL)


Production environment
----------------------

Execute mysql.sh:

```bash
sudo su -
./mysql.sh
```

Check that the service is up and running by executing:

```bash
service mysqld status
```

Tables are created for stash and bamboo.
All tables have full privileges given to the user admin.

For more information please consult:

* [Installing MySQL on Linux Using the MySQL Yum Repository](http://dev.mysql.com/doc/mysql-repo-excerpt/5.6/en/linux-installation-yum-repo.html)
* [Connecting Bamboo to an external database > MySQL 5.1](https://confluence.atlassian.com/display/BAMBOO/MySQL+5.1)
* [Connecting Stash to MySQL](https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+MySQL)