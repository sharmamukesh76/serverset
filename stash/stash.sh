#!/bin/sh

STASH_VERSION=3.0.1

# Git
mkdir -p /opt/git
cd /opt/git
wget https://git-core.googlecode.com/files/git-1.9.0.tar.gz
tar -xzvf git-1.9.0.tar.gz
cd git-1.9.0
make prefix=/usr/local all
make prefix=/usr/local install

# Stash
/usr/sbin/useradd --create-home --home-dir /usr/local/stash --shell /bin/bash stash
mkdir -p /opt/stash
chown stash: /opt/stash
cd /opt/stash/
wget http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-${STASH_VERSION}.tar.gz
tar -xvf atlassian-stash-${STASH_VERSION}.tar.gz
chown -R stash:stash atlassian-stash*
ln -s atlassian-stash-${STASH_VERSION} atlassian-stash
mkdir -p /data/stash
chown -R stash:stash /data/stash
sed -i "7i STASH_HOME=\"/data/stash\"" atlassian-stash/bin/setenv.sh
cd atlassian-stash
bin/start-stash.sh