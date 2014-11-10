CoreOS
======

Vagrant
-------

```bash
vagrant up
vagrant ssh
```

Docker
------

```bash
docker run -d -p 9001:9000 --name bdd-assistant vfarcic/technologyconversationsbdd
wget http://localhost:9001
```

Cluster
-------

**TODO**

etcd (TODO Remove)
------------------

```bash
etcd &
etcdctl set /message Hello
# curl -L -X PUT http://127.0.0.1:4001/v2/keys/message -d value="Hello"
etcdctl get /message
# curl -L http://127.0.0.1:4001/v2/keys/message
etcdctl rm /message
# curl -L -X DELETE http://127.0.0.1:4001/v2/keys/message
ip address show | grep docker
etcdctl mkdir /foo-service
etcdctl set /foo-service/container1 localhost:1111
# curl -L -X PUT http://127.0.0.1:4001/v2/keys/foo-service/container1 -d value="localhost:1111"
etcdctl ls /foo-service
# curl -L http://127.0.0.1:4001/v2/keys/foo-service
etcdctl watch /foo-service --recursive
# curl -L http://127.0.0.1:4001/v2/keys/foo-service?wait=true\&recursive=true
etcdctl set /foo-service/container2 localhost:2222
# curl -L -X PUT http://127.0.0.1:4001/v2/keys/foo-service/container2 -d value="localhost:2222"
```

systemd
-------

```bash
etcd &

sudo echo "[Unit]
Description=BDDAssistant
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker stop %P
ExecStartPre=-/usr/bin/docker rm %P

ExecStartPre=-/usr/bin/docker pull vfarcic/technologyconversationsbdd
ExecStart=/usr/bin/docker run --name %P -p %i:9000 vfarcic/technologyconversationsbdd
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/instance %P
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/url %H:%i
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/%P/url %H:%i
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/%P/status running

ExecStop=-/usr/bin/docker stop %P
ExecStopPost=/usr/bin/etcdctl set /bdd-assistant/%P/status stopped

[Install]
WantedBy=multi-user.target" >bdd_assistant.service

sudo cp bdd_assistant.service /etc/systemd/system/bdd_assistant_blue@9001.service
sudo cp bdd_assistant.service /etc/systemd/system/bdd_assistant_green@9002.service
sudo rm -f bdd_assistant.service
sudo systemctl enable /etc/systemd/system/bdd_assistant_blue@9001.service
sudo systemctl enable /etc/systemd/system/bdd_assistant_green@9002.service
sudo systemctl daemon-reload
```

Runner
------

```bash
sudo mkdir -p /opt/deploy
echo 'if [[ "$(etcdctl get /bdd-assistant/instance)" = "bdd_assistant_blue" ]]; then
    sudo systemctl start bdd_assistant_green@9002.service
    sudo systemctl stop bdd_assistant_blue@9001.service
else
    sudo systemctl start bdd_assistant_blue@9001.service
    sudo systemctl stop bdd_assistant_green@9002.service
fi' >deploy_bdd_assistant.sh
sudo chmod 744 deploy_bdd_assistant.sh
sudo mv deploy_bdd_assistant.sh /opt/deploy/.
/opt/deploy/deploy_bdd_assistant.sh
docker ps -a
etcdctl get /bdd-assistant/instance
```

TODO
----

* confd
* nginx or lighttpd