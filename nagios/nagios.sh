#!/bin/sh

# NagiosXI
cd /opt
sudo wget http://assets.nagios.com/downloads/nagiosxi/xi-latest.tar.gz
sudo tar xzf xi-latest.tar.gz
cd nagiosxi
echo "Y" | sudo ./fullinstall
