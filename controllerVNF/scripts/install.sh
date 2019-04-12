#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get install -y curl git mysql-server openssl
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt install -y nodejs
apt-get install -y npm
