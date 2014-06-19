Installation
============

Development environment
-----------------------

[Vagrant](http://www.vagrantup.com/) is used to create local virtual machine using Oracle [VirtualBox](https://www.virtualbox.org/).

To create a virtual machine with CentOS and Sonar execute following from this directory:

```bash
vagrant up
```

Access the Stash instance by going to your web browser and entering the address: [http://localhost:9000/](http://localhost:9000/).

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
./general.sh
./sonar.sh
```

Access the Sonar instance by going to your web browser and entering the address: [http://192.168.0.43:9000/](http://192.168.0.43:9000/).


General information
-------------------

Sonar can be started and stopped using:

```bash
/opt/sonarqube/bin/linux-x86-64/sonar.sh start
/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
```

Default System administrator credentials are admin/admin.

To integrate with Sonar, download the plugin from [https://marketplace.atlassian.com/plugins/com.marvelution.bamboo.plugins.sonar.tasks](https://marketplace.atlassian.com/plugins/com.marvelution.bamboo.plugins.sonar.tasks)
and add it to the Bamboo instance (Administration &gt; Manage add-ons &gt; Upload add-on).

For more information please consult:

* [SonarQube: Installation](http://docs.codehaus.org/display/SONAR/Installing)