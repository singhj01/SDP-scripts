#!/bin/bash
#login as a root
service_port = 4444
service_host = service
HOME = $(pwd)
git clone https://github.com/waverleylabs/SDPController.git
cd SDPController
sudo npm install
#login to the database
mysql -u root -proot -e "create user 'sdpController'@'localhost' identified by 'root';"
mysql -u root -proot -e "create database sdp;"
mysql -u root -proot -e "grant all privileges on sdpControler.* to 'sdpControler'@'localhost';flush privileges;"

#import the db to the controller
cd setup
mysql -u sdpController -proot sdp < sdp.sql

#populate the tables
mysql sdp << EOF
INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial) VALUES (1,1,'gateway','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (2,1,'controller','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');
INSERT INTO sdpid(sdpid,valid,type,country,state,locality,org,org_unit,alt_name,email,serial)VALUES (3,1,'client','CA', 'ON', 'London', 'UWO', 'SE', 'Postdoc', 'abc@xyz.com', 'abc123');

INSERT INTO service VALUES(1,'controller', 'controller' );
INSERT INTO service VALUES(2,'tcp', 'tcp' );
INSERT INTO service VALUES(3,'udp', 'udp' );

INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(1, 1, 1 ,'tcp',5000, 'sdpController', 5000);
INSERT INTO service_gateway (id,service_id, gateway_sdpid, protocol, port, nat_ip, nat_port) VALUES(2, 2, 1 ,'tcp',$service_port, '$service_host', $service_port);
#populate sdpid_service
INSERT INTO sdpid_service VALUES (1, 1, 1);
#this means that the gateway has access to service 1
INSERT INTO sdpid_service VALUES (2, 1, 2);
INSERT INTO sdpid_service VALUES(4, 3, 1);
#now the client can access service 1 as well
INSERT INTO sdpid_service VALUES(5, 3, 2);
EOF
