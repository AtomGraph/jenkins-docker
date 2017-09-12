#!/bin/sh
set -e

JUSER="jenkins"

DOCKER_GID=$(ls -aln /var/run/docker.sock  | awk '{print $4}')

if ! getent group $DOCKER_GID; then
    echo "Creating group host-docker:$DOCKER_GID"
    addgroup --gid $DOCKER_GID host-docker
fi

usermod -aG $DOCKER_GID $JUSER

exec su $JUSER -c "/usr/local/bin/jenkins.sh"