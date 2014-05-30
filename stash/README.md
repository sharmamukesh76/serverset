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

Recommended installation for development purposes is to use the internal database.

When started for the first time, Stash requires licence key to be entered.

Please follow the on-screen instructions.

To stop the virtual machine execute:

```bash
vagrant halt
```

For more information please consult:

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Installing Bamboo on Linux](https://confluence.atlassian.com/display/STASH/Installing+Stash+on+Linux+and+Mac)
* [Connecting Stash to MySQL](https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+MySQL)

Production environment
----------------------

Execute stash.sh:

```bash
sudo su -
./general.sh
./stash.sh
```

Access the Stash instance by going to your web browser and entering the address: [http://localhost:7990/](http://localhost:7990/).

Recommended installation for production purposes is to use the external database.

When started for the first time, Stash requires licence key to be entered.

Please follow the on-screen instructions.

**TODO Continue with installation steps**

For more information please consult:

* [Installing Bamboo on Linux](https://confluence.atlassian.com/display/STASH/Installing+Stash+on+Linux+and+Mac)
* [Connecting Stash to MySQL](https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+MySQL)
