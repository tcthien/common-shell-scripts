## common-shell-scripts

* my.cnf: 
  ** MySQL Server configuration which allow MySQL Server to be connected from remote
```
#Comment out bind-address to enable accessing from remote
#bind-address   = 127.0.0.1
```
  ** After update my.cnf, execute following commands:
```
sudo service mysql restart

mysql –u root -p
GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
```


* cassandra.yaml: 
  ** Cassandra configuration which enables Cassandra to be connected from remote & password authenticator
```
# Enable remote access
rpc_address: 0.0.0.0
broadcast_rpc_address: localhost

# Enable password authenticator
authenticator: PasswordAuthenticator
```
  ** After update cassandra.yaml, execute following commands:
```
cqlsh localhost -u cassandra -p cassandra

create user root with password 'root' superuser;
```