Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

To create a virtual machine with CentOS and Stash execute following from this directory:

```bash
vagrant up
```

Access the Stash instance by going to your web browser and entering the address: [http://localhost:7990/](http://localhost:7990/).

To stop the virtual machine execute:

```bash
vagrant halt
```

For more information please consult:

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)

Production environment
----------------------

Execute stash.sh:

```bash
sudo su -
cp stash /etc/init.d/stash
./general.sh
./stash.sh
```

Access the Stash instance by going to your web browser and entering the address: [http://192.168.0.40:7990/](http://192.168.0.40:7990/).


General information
-------------------

Recommended installation for production purposes is to use the external database.

When started for the first time, Stash requires licence key to be entered.

Please follow the on-screen instructions.

Stash is installed as a service with start, stop, restart and status commands.

In case the database was not setup during the initial installation, it can be migrated later on using the following steps:

Administration &gt; Database &gt; Migrate database. Follow the on-screen instructions.

For more information please consult:

* [Installing Stash on Linux](https://confluence.atlassian.com/display/STASH/Installing+Stash+on+Linux+and+Mac)
* [Connecting Stash to MySQL](https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+MySQL)