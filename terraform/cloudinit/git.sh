#!/usr/bin/env bash

#su - ${user} -c "git config --global credential.UseHttpPath true"
#su - ${user} -c "git config --global credential.helper '!aws codecommit credential-helper \$@'"
su - ${user} -c "git config --global user.name jenkins-chaos-master"
su - ${user} -c "git config --global user.email jenkins-chaos-master@tikalk.com"
su - ${user} -c "git clone https://github.com/cohencil/jenkins-chaos-master.git"
su - ${user} -c "mkdir -p ~/jenkins-chaos-master/jenkins/jenkins_home"
