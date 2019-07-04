#!/usr/bin/env bash

su - ${user} -c "aws configure set region ${region}"
su - ${user} -c "aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/PRIMARY_KEY --with-decryption --query "Parameter.Value" --output text > ~/.ssh/id_rsa"
su - ${user} -c "chmod 600 ~/.ssh/id_rsa"
