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

Please consult [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) for more information.

Production environment
----------------------

Execute bamboo.sh:

```bash
sudo su -
./general.sh
./bamboo.sh
```

Access the Bamboo instance by going to your web browser and entering the address: [http://localhost:8085/](http://localhost:8085/).

When started for the first time, Bamboo requires licence key to be entered.
Please follow the on-screen instructions.

Recommended installation for production purposes is to use the "Custom installation".
Please see the [Running the Setup Wizard](https://confluence.atlassian.com/display/BAMBOO/Running+the+Setup+Wizard) guide for detailed instructions.

During the setup, make sure that the connection with the Stash is established.

TODO Continue with installation steps


Add-ons
=======

Following add-ons should be installed:
XXX

Please see the [Bamboo Add-ons](https://confluence.atlassian.com/display/BAMBOO/Add-ons) page for more detailed instructions.
