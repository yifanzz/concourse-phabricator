FROM ubuntu:latest

RUN apt install git

RUN mkdir -p /opt/resource/

ADD build-out/* /opt/resource/

ENTRYPOINT /bin/bash