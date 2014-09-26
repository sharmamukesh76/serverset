#!/bin/sh

# Docker
sudo sh -c "echo deb https://get.docker.io/ubuntu docker main >/etc/apt/sources.list.d/docker.list"
curl -s https://get.docker.io/gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install lxc-docker
