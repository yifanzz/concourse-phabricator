FROM ubuntu:latest

RUN apt-get update && apt-get install -y git-all

RUN mkdir -p /opt/resource/

ADD build-out/* /opt/resource/

ENTRYPOINT /bin/bash