yum -y install figlet
now=`date +"%Y-%m-%d_%H-%M-%S"`
echo -e "This instance is manages by terraform\n
      at $now \n
      all local changes will not persist \!\!\!" > /etc/motd

figlet ${shortname} >> /etc/motd