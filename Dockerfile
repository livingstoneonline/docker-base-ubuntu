FROM ubuntu:trusty
MAINTAINER Nigel Banks <nigel.g.banks@gmail.com>

LABEL "License"="GPLv3" \
      "Version"="0.0.1"

ARG S6_VERSION="1.17.1.2"
ARG CONFD_VERSION="0.11.0"

ENV DEBIAN_FRONTEND=noninteractive \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    TERM=xterm

# Install s6-overlay and confd, and other essentials.
RUN apt-get update && \
apt-get -y install \
	      libxml2-utils \
        build-essential \
        curl \
        emacs \
        expect \
        git \
        htop \
        parallel \
        python-software-properties \
        silversearcher-ag \
        software-properties-common \
        unzip \
        vim \
        wget \
        zsh \
    && \
    add-apt-repository -y ppa:costamagnagianfranco/ettercap-stable-backports && \
    apt-get -y update && \
    apt-get -y install curl && \
    curl -L https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64.tar.gz | \
    tar -xzf - -C / && \
    curl -L -o /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 && \
    chmod a+x /usr/local/bin/confd && \
    rm -rf /var/lib/apt/lists/* \
           /root/.cache/* \
           /var/tmp/* \
           /tmp/*

# Start s6
ENTRYPOINT [ "/init" ]

COPY rootfs /
