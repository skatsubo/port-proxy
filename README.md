# port-proxy
Port forwarding and proxying through bastion host 

Service agnostic solutions (at TCP layer):
- iptables port forwarding
- netcat, socat
- SSH tunneling
- HAProxy

Service specific solutions (app layer)
- proxysql https://github.com/sysown/proxysql

Below are examples of port forwarding `:13306` to a remote public MySQL DB `ensembldb.ensembl.org:3306`.


## iptables port forwarding
See `enable-iptables.sh` (not tested).


## netcat, socat
`socat` looks like more robust option compared to `netcat` if running as a service.  
See `run-socat.sh`.


## SSH tunneling
Using `autossh` for handling failures. See `enable-autossh.sh`.


## HAProxy
Option 1. Running as a system service: 
- `apt-get install -y haproxy`
- edit its config in `/etc` using `haproxy/haproxy.cfg` as an example
- apply changes `systemctl status haproxy`, `systemctl restart haproxy`.


Option 2. Running with docker-compose.  
Edit `haproxy.cfg` and `docker-compose.yml`, then start it:
``` 
cd haproxy
docker-compose up -d
```


Option 3. Running with docker.  
Edit `haproxy.cfg`. Run:
``` 
cd haproxy
docker run -d --rm --name haproxy -p 13306:13306 \
  -v $(pwd)/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy:2.2
```


# How to test
```
nc -vv 127.0.0.1 13306
mysql -h 127.0.0.1 -P 13306 -u anonymous
```

