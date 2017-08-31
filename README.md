# jenkins-docker
Jenkins Docker image with Docker installed

Followed Docker CE installation instructions for Debian (because Jenkins image internally is based on Debian stretch):
https://docs.docker.com/engine/installation/linux/docker-ce/debian/

Host Docker socket `/var/run/docker.sock` needs to be available as volume. For example in `docker-compose.yml`:

    volumes:
      - /var/run/docker.sock:/var/run/docker.sock