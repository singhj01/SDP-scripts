FROM ubuntu:14.04

WORKDIR /gateway
ENV DB_HOST=$hostname

COPY * /gateway/
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN ./install.sh
#RUN ./setupMySQL.sh
#RUN ./certs.sh
#CMD ["/bin/bash", "-c","/controller/run.sh"]


