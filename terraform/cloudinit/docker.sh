#!/usr/bin/env bash

yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ${user}
curl -L https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
chmod o+rw /var/run/docker.sock