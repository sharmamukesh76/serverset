CoreOS
======

**Vagrant**

```bash
vagrant up
vagrant ssh
```

**Docker**

```bash
docker run -d -p 9000:9000 --name bdd-assistant vfarcic/technologyconversationsbdd
wget http://localhost:9000
```

**cluster**

**etcd**

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

**systemd**

```bash
etcd &

sudo echo "[Unit]
Description=BDDAssistant
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill bdd-assistant
ExecStartPre=-/usr/bin/docker rm bdd-assistant
ExecStart=/usr/bin/docker run --name bdd-assistant -p 9000:9000 vfarcic/technologyconversationsbdd
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/status running
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/url %H:%i
#ExecStop=/usr/bin/docker stop bdd-assistant
#ExecStopPost=/usr/bin/etcdctl rm /bdd-assistant/status
#ExecStopPost=/usr/bin/etcdctl rm /bdd-assistant/url

[Install]
WantedBy=multi-user.target" >/etc/systemd/system/bdd-assistant:9000.service

sudo systemctl enable /etc/systemd/system/bdd-assistant:9000.service
sudo systemctl start bdd-assistant:9000.service
systemctl status bdd-assistant:9000.service
sudo systemctl start bdd-assistant:9000.service
```

TODO
----

* confd
* nginx or lighttpd