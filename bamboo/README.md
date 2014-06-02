Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

To create a virtual machine with CentOS and Bamboo execute following from this directory:

```bash
vagrant up
```

Access the Bamboo instance by going to your web browser and entering the address: [http://localhost:8085/](http://localhost:8085/).

When started for the first time, Bamboo requires licence key to be entered.
Please follow the on-screen instructions.

Recommended installation for development purposes is to use the "Express installation".
Please see the [Running the Setup Wizard](https://confluence.atlassian.com/display/BAMBOO/Running+the+Setup+Wizard) guide for detailed instructions.

To stop the virtual machine execute:

```bash
vagrant halt
```

Bamboo is installed as a service with start, stop and restart commands.

For more information, please consult:

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [Installing Bamboo on Linux](https://confluence.atlassian.com/display/BAMBOO/Installing+Bamboo+on+Linux)
* [Connecting Bamboo to an external database > MySQL 5.1](https://confluence.atlassian.com/display/BAMBOO/MySQL+5.1)

Production environment
----------------------

Execute bamboo.sh:

```bash
sudo su -
cp bamboo /etc/init.d/bamboo
./general.sh
./bamboo.sh
```

Access the Bamboo instance by going to your web browser and entering the address: [http://localhost:8085/](http://localhost:8085/).

When started for the first time, Bamboo requires licence key to be entered.
Please follow the on-screen instructions.

Recommended installation for production purposes is to use the "Custom installation".
Please see the [Running the Setup Wizard](https://confluence.atlassian.com/display/BAMBOO/Running+the+Setup+Wizard) guide for detailed instructions.

During the setup, make sure that the connection with the Stash is established.

**TODO Continue with installation steps**

Bamboo is installed as a service with start, stop and restart commands.

For more information, please consult:

* [Installing Bamboo on Linux](https://confluence.atlassian.com/display/BAMBOO/Installing+Bamboo+on+Linux)
* [Connecting Bamboo to an external database > MySQL 5.1](https://confluence.atlassian.com/display/BAMBOO/MySQL+5.1)