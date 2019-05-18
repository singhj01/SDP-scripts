#!/usr/bin/env bash

echo $1
yes Y | sudo scp -i controller@$1:/controller/1.key /gateway/
yes Y | sudo scp -i controller@$1:/controller/1.crt /gateway/
yes Y | sudo scp -i controller@$1:/controller/ca.crt /gateway/
yes Y | sudo scp -i controller@$1:/controller/1.spa_keys /gateway/



yes Y  | sudo cp access.conf /etc/fwknop/
yes Y  | sudo cp fwknopd.conf /etc/fwknop/
yes Y  | sudo cp gate_sdp_ctrl_client.conf /etc/fwknop/
yes Y  | sudo cp gate.fwknoprc /etc/fwknop/

fwknopd -f 

while true; do
    echo 'Dont close please'
done
