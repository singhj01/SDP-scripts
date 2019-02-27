#!/bin/bash
#login as a root
sudo -s 
#update the apt-get source.list
apt-get update
#add the latest version of nodejs to the repository using the  curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt install nodejs
apt-get install npm
git clone https://github.com/waverleylabs/SDPController.git
cd SDPController
sudo npm install
#install mysql-server
sudo apt-get install mysql-server
#login to the database 
mysql -u root -p
create database sdp;
exit
#import the db to the controller
cd setup
mysql -u root -p sdp < sdp.sql 
#login to the database
mysql -u root -p
use sdp;
#populate the sdpid table
insert into sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial) values (1,1,'gateway','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
insert into sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)values (2,1,'controller','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
insert into sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)values (3,1,'client','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
#populate service table
insert into service values(1,'controller', 'controller' );
insert into service values(2,'tcp', 'tcp' );
insert into service values(3,'udp', 'udp' );
#populate service_gateway table (nat_ip here is the client ip)
insert into service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) values(1, 1, 1 ,'tcp',5000, '10.10.10.102', 5000);
insert into service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) values(2, 2, 1 ,'tcp',44, '10.10.10.103', 44);
insert into service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) values(3, 3, 1 ,'udp',45, '10.10.10.103', 45);
#populate sdpid_service
insert into sdpid_service values (1, 1, 1); 
#this means that the gateway has access to service 1 
insert into sdpid_service values (2, 1, 2);
insert into sdpid_service values (3, 1, 3);
insert into sdpid_service values(4, 3, 1); 
#now the client can access service 1 as well
insert into sdpid_service values(5, 3, 2);
insert into sdpid_service values(6, 3, 3);
exit
#----------------create the certificates

cd /home/user1/
sudo apt-get install openssl

country=CA
state=ON
locality=London
organization=UWO
organizationalunit=SE
email=abc@xyz.com
password=controller
# generate the root certificates 
openssl genrsa -des3 -passout pass:$password -out ca.key 4096 
openssl req -new -x509 -days 365 -key ca.key -out ca.crt -passin pass:$password \
    -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
node ./SDPController/genCredentials.js 1 
node ./SDPController/genCredentials.js 2
node ./SDPController/genCredentials.js 3



