CoreOS
======

Vagrant
-------

```bash
vagrant up
vagrant ssh
```

Cluster (TODO)
--------------

confd
-----

```bash
wget -O confd https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64
sudo mv confd /opt/bin/.
sudo chmod +x /opt/bin/confd
sudo mkdir -p /etc/confd/{conf.d,templates}

[template]
src = "myconfig.conf.tmpl"
dest = "/tmp/myconfig.conf"
keys = [
    "/myapp/database/url",
    "/myapp/database/user",
]
```

etcd
----

```bash
etcd &
```

nginx
-----

```bash
sudo mkdir -p /etc/nginx/{sites-enabled,certs-enabled}
sudo mkdir -p /var/log/nginx
echo "server {
  listen 80 default_server;
  listen [::]:80 default_server;
  server_name _;
  location / {
    proxy_pass http://172.17.42.1:9001/;
  }
}" >bdd_assistant
sudo mv bdd_assistant /etc/nginx/sites-enabled/bdd_assistant

echo "[Unit]
Description=nginx
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker stop nginx
ExecStartPre=-/usr/bin/docker rm nginx

ExecStartPre=-/usr/bin/docker pull dockerfile/nginx
ExecStart=/usr/bin/docker run --name nginx -p 80:80 -v /etc/nginx/sites-enabled:/etc/nginx/sites-enabled -v /etc/nginx/certs-enabled:/etc/nginx/certs-enabled -v /var/log/nginx:/var/log/nginx dockerfile/nginx

ExecStop=-/usr/bin/docker stop nginx

[Install]
WantedBy=multi-user.target" >nginx.service
sudo mv nginx.service /etc/systemd/system/nginx.service

sudo systemctl enable /etc/systemd/system/nginx.service
sudo systemctl start nginx.service
```

BDD Assistant
-------------

```bash
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
ExecStartPost=/usr/bin/etcdctl set /bdd-assistant/%P/port %i
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
etcdctl set /bdd-assistant/instance none
echo 'if [[ "$(etcdctl get /bdd-assistant/instance)" = "bdd_assistant_blue" ]]; then
    sudo systemctl start bdd_assistant_green@9002.service
    sudo systemctl stop bdd_assistant_blue@9001.service
else
    sudo systemctl start bdd_assistant_blue@9001.service
    sudo systemctl stop bdd_assistant_green@9002.service
fi' >deploy_bdd_assistant.sh
sudo chmod 744 deploy_bdd_assistant.sh
sudo mv deploy_bdd_assistant.sh /opt/bin/.
deploy_bdd_assistant.sh
docker ps -a
etcdctl get /bdd-assistant/instance
```

TODO
----

* nginx
* confd