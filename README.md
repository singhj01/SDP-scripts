# Dockerized SDP setup

This project allows for quick deployment of SDP components, consistantly everytime using docker images. 

## Pre-requisites

To run this setup, Docker v18.09+ is required. Lower versions may work but are untested.

## Setup and installation

### Network

First a docker network must be created for the SDP network

```bash
docker network create --driver bridge sdp_network
docker network create --driver bridge simulated_public_network
```

This will create a custom network for attaching our SDP components to.

### Controller

To run the controller, firstly update config.js, certs.sh, and setupMySQL.sh according desired specification. The inline comments should guide how to update the files as well as by following Waverley labs guide (https://github.com/WaverleyLabs/SDPcontroller).

Once configured, from the controller directory run the following commands to start the controller.

```bash
docker build -it controller .
docker run controller --network=sdp_network
```

Once the container is running, grab all the necessary keys and certs to use to run the other components. 

```bash
docker cp controller:/controller/file_to_copy file_destination 
```

Obtain the controller IP using
```bash
docker inspect controller
```


### Gateway

To run the gateway, firstly update the configuration files in the conf folder according desired specification. The inline comments should guide how to update the files as well as by following Waverley labs guide (https://github.com/WaverleyLabs/fwknop).

Once configured, from the gateway directory run the following commands to start the gateway container.

```bash
docker build -it gateway .
docker run gateway --network=sdp_network
docker network connect simulated_public_network gateway
```

Obtain the gateway IP using
```bash
docker inspect gateway
```

Once the gateway is running, copy the necessary keys and certs to the gateway to run the fwknop service. 

```bash
docker cp file_source  gateway:/gateway/file_destination 
docker exec -it bash
```
Verify the configuration is correct, forwarding is enabled using `echo 1 > /proc/sys/net/ipv4/ip_forward` and IPTable configuration is correct then execute

```bash
fwknopd -f
exit
```


### Client

To run the client, firstly update the configuration files `.fwknoprc`  according desired specification. The inline comments should guide how to update the files as well as by following Waverley labs guide (https://github.com/WaverleyLabs/fwknop).

Once configured, from the client directory run the following commands to start the gateway container.

```bash
docker build -it client .
docker run client --network=simulated_public_network
```

Obtain the client IP using
```bash
docker inspect client
```

Once the gateway is running, copy the necessary keys and certs to the gateway to run the fwknop service. 

```bash
docker cp file_source  client:/client/file_destination 
docker exec -it bash
```
Verify the configuration is correct then execute

```bash
fwknop -n service_gate
exit
```

### Services

There are two ways to run a service. First method is to run the service on the same host as the gateway. The other is to run the containerized service.

To protect your containerized service via SDP you must attach your container to the SDP_network

```bash
docker network connect sdp_network service
```

Make sure to configure the service to route all traffic via the gateway using something like `ip route add 0.0.0.0/0 via GATEWAYIP`. Then update the SDP controller database to protect this service via the gateway.




