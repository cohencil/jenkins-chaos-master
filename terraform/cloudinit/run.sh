#!/usr/bin/env bash

su - ${user} -c "export AWS_ACCESS_KEY_ID=\`aws configure get aws_access_key_id\`; \
                 export AWS_SECRET_ACCESS_KEY=\`aws configure get aws_secret_access_key\`; \
                 export GIT_PRIVATE_KEY=\`cat ~/.ssh/id_rsa\`;
                 export GITHUB_CLIENT_SECRET=\`cat ~/.github/secret\`; 
                 export JENKINS_ADMIN_PASSWORD=\`aws ssm get-parameter --name /JENKINS_CHAOS_MASTER/JENKINS_ADMIN_PASSWORD --with-decryption --query "Parameter.Value" --output text\`;
                 cd ~/jenkins-chaos-master/jenkins; 
                 /usr/local/bin/docker-compose down --remove-orphans ;
                 /usr/local/bin/docker-compose up -d"