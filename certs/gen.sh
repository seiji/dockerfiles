#!/bin/sh -e

CN="workspace"
DAYS=3650
PASS="pass"

WORKDIR=/etc/ssl

cd $WORKDIR
echo 01 > serial && touch index.txt
mkdir -p $WORKDIR/newcerts
mkdir -p $WORKDIR/private

openssl req -new -x509 \
  -keyout private/cakey.pem \
  -out cacert.pem \
  -days ${DAYS} \
  -subj /C=JP/CN=${CN}/ \
  -nodes

openssl genrsa \
  -out client.key 2048
openssl req -new \
  -key client.key \
  -out client.csr \
  -subj /C=JP/CN=${CN}/ \
  -sha256

openssl ca \
  -policy policy_anything \
  -out client.crt \
  -in client.csr \
  -days ${DAYS} \
  -batch

openssl pkcs12 -export \
  -in client.crt \
  -inkey client.key \
  -certfile cacert.pem \
  -out ${CN}.p12 \
  -name ${CN} \
  -passout pass:${PASS}

cp -p ${CN}.p12 /certs/
cp -p cacert.pem /certs/

