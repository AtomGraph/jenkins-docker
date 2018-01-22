FROM jenkins/jenkins

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

COPY entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

# https://issues.jenkins-ci.org/browse/JENKINS-44287

# neeed to run entrypoint as root

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]