FROM ubuntu:14.04

WORKDIR /client

RUN ./install_client.sh
CMD ["/bin/bash","-c", " ./fwknopClient.sh"]


