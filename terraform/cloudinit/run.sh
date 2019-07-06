#!/usr/bin/env bash

su - ${user} -c "export GIT_PRIVATE_KEY=\`cat ~/.ssh/id_rsa\`; cd ~/jenkins-chaos-master/jenkins; /usr/local/bin/docker-compose down --remove-orphans ;/usr/local/bin/docker-compose up -d"