#!/bin/sh

NSCA=nsca-2.7.2

# NagiosXI
cd /opt
sudo wget http://assets.nagios.com/downloads/nagiosxi/xi-latest.tar.gz
sudo tar xzf xi-latest.tar.gz
cd nagiosxi
echo "Y" | sudo ./fullinstall

# NSCA (Install on the client
cd /opt
#sudo wget http://downloads.sourceforge.net/project/nagios/nsca-2.x/nsca-2.9.1/nsca-2.9.1.tar.gz
sudo wget http://prdownloads.sourceforge.net/sourceforge/nagios/nsca-2.7.2.tar.gz
sudo tar -xzf ${NSCA}.tar.gz
sudo ln -s ${NSCA} nsca
cd nsca
sudo ./configure
sudo make all
sudo mkdir bin
sudo cp src/nsca bin/.
sudo cp src/send_nsca bin/.
sudo mkdir config
sudo cp sample-config/nsca.cfg config/.
sudo cp sample-config/send_nsca.cfg config/.
sudo chown -R nagios:nagios bin
sudo chown -R nagios:nagios config
sudo mkdir messages
sudo chmod 777 messages
echo -e "localhost       TestMessage2    0       This is NOT an error message

" >messages/ok
echo -e "localhost       TestMessage2    1       This is critical message

" >messages/warning
echo -e "localhost       TestMessage2    2       This is error message

" >messages/critical
# More info:
#   http://assets.nagios.com/downloads/nagiosxi/docs/Using-and-Configuring-NSCA-With-Nagios-XI.pdf
#   http://nagios.sourceforge.net/download/contrib/documentation/misc/NSCA_Setup.pdf
# /usr/local/nagios/etc/services/localhost.cfg
# /usr/local/nagios/etc/commands.cfg
# ./bin/send_nsca localhost -c config/send_nsca.cfg < messages/ok



# ./send_nsca localhost -c ../config/send_nsca.cfg < ../tmp/