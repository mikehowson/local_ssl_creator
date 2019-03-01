# local_ssl_creator

A bash script to create and install self signed certs for local https development. (Only tested on a mac)

The script will generate the cert and key required, install the cert
into keychain and set it to trusted and then add the new host to the
hosts file ready for dev.

To execute in terminal:-

```
./create_cert.sh
```

this will produce a server.crt and a server.key
