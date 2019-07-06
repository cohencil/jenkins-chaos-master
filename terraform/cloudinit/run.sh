#!/usr/bin/env bash

su - ${user} -c "export GIT_PRIVATE_KEY=\`cat ~/.ssh/id_rsa\`; export GITHUB_CLIENT_SECRET=\`cat ~/.github/secret\`; cd ~/jenkins-chaos-master/jenkins; /usr/local/bin/docker-compose down --remove-orphans ;/usr/local/bin/docker-compose up -d"