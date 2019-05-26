#!/usr/bin/env bash

sudo apt-get update
git clone https://github.com/WaverleyLabs/fwknop.git
sudo apt-get install texinfo libtool autoconf make telnet openssl libssl-dev libjson0 libjson0-dev libpcap-dev
cd fwkop
libtoolize --force
aclocal
autoheader
automake --force-missing --add-missing
autoconf
./configure --disable-server --prefix=/usr
make
make install



