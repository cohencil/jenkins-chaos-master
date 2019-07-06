#!/usr/bin/env bash

su - ${user} -c "aws configure set region ${region}"
su - ${user} -c "aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/PRIMARY_KEY --with-decryption --query "Parameter.Value" --output text > ~${user}/.ssh/id_rsa"
su - ${user} -c "mkdir ~${user}/.github"
su - ${user} -c "aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/GITHUB_CLIENT_SERCRET --with-decryption --query "Parameter.Value" --output text > ~${user}/.github/secret"
su - ${user} -c "chmod 600 ~${user}/.ssh/id_rsa"
su - ${user} -c "chmod 600 ~${user}/.github/secret"
