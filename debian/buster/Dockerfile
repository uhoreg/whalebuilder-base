FROM debian:buster
MAINTAINER Hubert Chathi <hubert@uhoreg.ca>

# Persistent
ENV TZ=Etc/UTC

# Persists just during build
ARG DEBIAN_FRONTEND="noninteractive"


RUN groupadd -r whalebuilder && \
    useradd -r -g whalebuilder -d /home/whalebuilder -m whalebuilder
WORKDIR /home/whalebuilder


RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential fakeroot tzdata auto-apt-proxy
