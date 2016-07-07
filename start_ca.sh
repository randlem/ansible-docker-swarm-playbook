#!/usr/bin/env bash

cadir=${1:-./ca}
bits=${2:-4096}
config=${3:-openssl.cnf}
priv=ca-priv-key.pem
pub=ca.pem

if [ ! -d $cadir ]; then
	echo "Creating $cadir"
	mkdir $1
fi

if [ ! -f $config ]; then
	echo "Config file $config is missing. Halting."
	exit -1
fi

echo "Using $cadir as the CA root directory"

if [ ! -f $cadir/$priv ]; then
	echo "Creating private key"
	openssl genrsa -out $cadir/$priv $bits
fi

if [ ! -f $cadir/$pub ]; then
	echo "Creating public key"
	openssl req -config $config -new -key $cadir/$priv -x509 -days 1825 -out $cadir/$pub
fi