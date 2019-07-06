# install certbot
wget -r --no-parent -A 'epel-release-*.rpm' \
  http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
rpm -Uvh \
    dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
yum-config-manager --enable epel*
yum install -y certbot python2-certbot-apache


# install nginx
yum -y install nginx
systemctl stop nginx

# create cert
certbot certonly --standalone --non-interactive --agree-tos --email ${hostmaster_email} -d ${instance_name}.${domain_name}

# start nginx
systemctl start nginx


