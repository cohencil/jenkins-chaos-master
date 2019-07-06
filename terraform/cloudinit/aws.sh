#!/usr/bin/env bash

su - ${user} -c "aws configure set region ${region}"
su - ${user} -c "aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/PRIMARY_KEY --with-decryption --query "Parameter.Value" --output text > ~/.ssh/id_rsa"
su - ${user} -c "mkdir ~/.github"
su - ${user} -c "aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/GITHUB_CLIENT_SERCRET --with-decryption --query "Parameter.Value" --output text > ~/.github/secret"
su - ${user} -c "chmod 600 ~/.ssh/id_rsa"
su - ${user} -c "chmod 600 ~/.github/secret"
