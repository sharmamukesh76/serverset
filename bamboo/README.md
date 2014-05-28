# Installation

## Development environment

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

To create a virtual machine with CentOS and Bamboo execute following from this directory:

```shell
vagrant up
```

Access the Bamboo instance by going to your web browser and entering the address: [http://localhost:4567/](http://localhost:4567/).

When started for the first time, Bamboo required licence key to be entered.
Please follow the on-screen instructions.

Recommended installation for development purposes is to use the "Express installation".
Please see the [Running the Setup Wizard](https://confluence.atlassian.com/display/BAMBOO/Running+the+Setup+Wizard) guide for detailed instructions.

To stop the virtual machine execute:

```shell
vagrant halt
```

Please consult [Vagrant](http://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) for more information.

## Production environment

Execute bootstrap.sh:

```shell
./bootstrap.sh
```

Access the Bamboo instance by going to your web browser and entering the address: [http://localhost:8085/](http://localhost:8085/).

When started for the first time, Bamboo required licence key to be entered.
Please follow the on-screen instructions.

Recommended installation for production purposes is to use the "Custom installation".
Please see the [Running the Setup Wizard](https://confluence.atlassian.com/display/BAMBOO/Running+the+Setup+Wizard) guide for detailed instructions.

TODO Continue with installation steps
