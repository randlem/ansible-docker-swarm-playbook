#!/usr/bin/env bash

if [ -z $1 ]; then
	echo "Must supply the key name as the first parameter"
	exit -1
fi

cadir=${2:-./ca}
bits=${3:-4096}
config=${4:-openssl.cnf}

priv=$1-priv-key.pem
csr=$1.csr
cert=$1-cert.pem

openssl genrsa -out $cadir/$priv $bits
openssl req -subj "/CN=$1" -new -key $cadir/$priv -out $cadir/$csr
openssl x509 -req -days 1825 -in $cadir/$csr -CA $cadir/ca.pem -CAkey $cadir/ca-priv-key.pem -CAcreateserial -out $cadir/$cert -extfile $config