FROM jenkins

LABEL maintainer="martynas@atomgraph.com"

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
  apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"

RUN apt-get update && \
  apt-get install -y docker-ce

# RUN usermod -aG staff,docker jenkins

# workaround for jenkins Dockr socket permissions
# https://stackoverflow.com/questions/42164653/docker-in-docker-permissions-error

RUN chmod 666 /var/run/docker.sock

USER jenkins