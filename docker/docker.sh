#!/bin/sh

sudo rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo yum -y update
sudo yum -y install docker-io
sudo service docker start
sudo chkconfig docker on
sudo docker run -d -p 9000:9000 --name bdd_assistant vfarcic/technologyconversationsbdd