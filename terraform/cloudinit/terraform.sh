#!/usr/bin/env bash

curl -Lo /tmp/terraform.zip https://releases.hashicorp.com/terraform/${version}/terraform_${version}_linux_amd64.zip
unzip -d /usr/local/bin/ -o /tmp/terraform.zip