FROM ubuntu:14.04

EXPOSE 5000

WORKDIR /controller

COPY * /controller/

RUN ./install.sh
RUN ./certs.sh
RUN ./setupMySQL.sh

CMD [" ./run.sh"]

