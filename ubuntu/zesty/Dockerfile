FROM ubuntu:zesty
MAINTAINER Hubert Chathi <hubert@uhoreg.ca>


RUN groupadd -r whalebuilder && \
    useradd -r -g whalebuilder -d /home/whalebuilder -m whalebuilder
WORKDIR /home/whalebuilder


RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential fakeroot
