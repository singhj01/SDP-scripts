#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install -y curl git openssl libssl-dev libjson0 libjson0-dev libpcap-dev texinfo libtool autoconf make iptables
git clone https://github.com/waverleylabs/fwknop.git

cd fwknop
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure -disable-client --prefix=/usr --sysconfdir=/etc
make
make install
