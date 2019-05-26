FROM ubuntu:14.04

WORKDIR /client

COPY 3* /client/
COPY ca.crt /client/
COPY install_client.sh /client/
COPY fwknopClient.sh /client/
COPY sdp_ctrl_client.conf /client/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN ./install_client.sh
CMD ["/bin/bash","-c", " ./fwknopClient.sh"]


