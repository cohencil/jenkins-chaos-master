#!/usr/bin/env bash

export GIT_PRIVATE_KEY=`cat ~/.ssh/id_rsa`
export JENKINS_ADMIN_PASSWORD=`aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/JENKINS_ADMIN_PASSWORD --with-decryption --query "Parameter.Value" --output text`

docker-compose down --remove-orphans
docker-compose up -d
sleep 2
docker-compose logs -f