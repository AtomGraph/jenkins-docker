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

# map host Docker socket

VOLUME /var/run/docker.sock:/var/run/docker.sock

COPY entrypoint.sh /

RUN chmod +x entrypoint.sh

# entrypoint reused from https://github.com/SvenDowideit/docs-automation/blob/master/jenkins/setup-docker-and-start-jenkins.sh

ENTRYPOINT ["/entrypoint.sh"]