#!/usr/bin/env bash

#su - ${user} -c "git config --global credential.UseHttpPath true"
#su - ${user} -c "git config --global credential.helper '!aws codecommit credential-helper \$@'"
su - ${user} -c "git config --global user.name jenkins-chaos-master"
su - ${user} -c "git config --global user.email jenkins-chaos-master@tikalk.com"
su - ${user} -c "git clone git@github.com:cohencil/jenkins-chaos-master.git"
#su - ${user} -c "cd ~/jenkins-chaos-master/jenkins; mkdir jenkins_home"
#su - ${user} -c "cd ~/jenkins-chaos-master/jenkins; /usr/local/bin/docker-compose down --remove-orphans ;/usr/local/bin/docker-compose up -d"
