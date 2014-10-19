CoreOS
======

**Vagrant**

```bash
vagrant up
vagrant ssh
```

**Docker**

```bash
docker run -d -p 9000:9000 vfarcic/technologyconversationsbdd
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

TODO
----

* confd
* nginx or lighttpd