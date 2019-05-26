#!/usr/bin/env bash

yes Y | sudo scp controller:/controller/1.key /gateway/
yes Y | sudo scp controller:/controller/1.crt /gateway/
yes Y | sudo scp controller:/controller/ca.crt /gateway/
yes Y | sudo scp controller:/controller/1.spa_keys /gateway/

sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -S

yes Y  | sudo cp access.conf /etc/fwknop/
yes Y  | sudo cp fwknopd.conf /etc/fwknop/
yes Y  | sudo cp gate_sdp_ctrl_client.conf /etc/fwknop/
yes Y  | sudo cp gate.fwknoprc /etc/fwknop/

fwknopd -f 
netcat -l 4444
while true; do
    sleep 100
done
