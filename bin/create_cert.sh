read -p "Enter host name to use for local development e.g. localhost.dev (must have a .extension of some kind):" hostname

openssl genrsa -des3 -passout pass:x -out server.pass.key 2048

openssl rsa -passin pass:x -in server.pass.key -out server.key

openssl req -new -key server.key -out server.csr -subj "/C=GB/ST=London/L=London/O=Acme Inc/CN=$hostname"

echo "
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $hostname" >v3.ext

openssl x509 -req -sha256 -extfile v3.ext -days 365 -in server.csr -signkey server.key -out server.crt


read -p "Certs created, install into keychain? (y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo
  echo "Enter sudo password if prompted";
  sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain server.crt
fi

echo
read -p "Add host to hosts file? (y/n)" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo
  echo "Enter sudo password if prompted";
  echo "127.0.0.1 $hostname" | sudo tee -a /private/etc/hosts
  more /private/etc/hosts
fi


echo
echo "Certs created ready for use in your server, for example:-"
echo " puma -b 'ssl://$hostname:3000?key=server.key&cert=server.crt'"
echo
